"""Remove vertical padding while a native macOS Kitty window is fullscreen.

Kitty does not expose the OS-window fullscreen state through its public remote
control data.  A global watcher runs inside Kitty itself, so on macOS it can
read the matching NSWindow's style mask without polling or Accessibility
permissions.  This requires ``macos_traditional_fullscreen no``.
"""

from __future__ import annotations

import ctypes
import sys
from typing import Any

from kitty.boss import Boss
from kitty.fast_data_types import add_timer, cocoa_window_id, remove_timer
from kitty.window import Window


FULLSCREEN_STYLE_MASK = 1 << 14
CHECK_DELAY_SECONDS = 0.15

_pending_timers: dict[int, int] = {}
_applied_state: dict[int, bool] = {}

_ns_application_ref = None
_send_unsigned = None
_send_pointer_signed = None
_sel_window_with_number = None
_sel_style_mask = None


if sys.platform == 'darwin':
    try:
        _appkit = ctypes.CDLL(
            '/System/Library/Frameworks/AppKit.framework/AppKit'
        )
        _objc = ctypes.CDLL('/usr/lib/libobjc.A.dylib')

        _objc.sel_registerName.argtypes = (ctypes.c_char_p,)
        _objc.sel_registerName.restype = ctypes.c_void_p

        _objc_msg_send = ctypes.cast(_objc.objc_msgSend, ctypes.c_void_p).value
        if _objc_msg_send:
            _send_unsigned = ctypes.CFUNCTYPE(
                ctypes.c_ulong, ctypes.c_void_p, ctypes.c_void_p
            )(_objc_msg_send)
            _send_pointer_signed = ctypes.CFUNCTYPE(
                ctypes.c_void_p,
                ctypes.c_void_p,
                ctypes.c_void_p,
                ctypes.c_long,
            )(_objc_msg_send)

            _sel_window_with_number = _objc.sel_registerName(
                b'windowWithWindowNumber:'
            )
            _sel_style_mask = _objc.sel_registerName(b'styleMask')

            # Reuse Kitty's existing NSApplication. Initializing one in a
            # non-GUI helper process is invalid, while NSApp is simply nil there.
            _ns_application_ref = ctypes.c_void_p.in_dll(_appkit, 'NSApp')
    except (AttributeError, OSError, TypeError, ValueError):
        pass


def _native_fullscreen_state(os_window_id: int) -> bool | None:
    """Return native fullscreen state, or None if the NSWindow is unavailable."""
    if _ns_application_ref is None or not _ns_application_ref.value:
        return None
    if not all((
        _send_unsigned,
        _send_pointer_signed,
        _sel_window_with_number,
        _sel_style_mask,
    )):
        return None

    try:
        target_window_number = cocoa_window_id(os_window_id)
        application = _ns_application_ref.value
        native_window = _send_pointer_signed(
            application, _sel_window_with_number, target_window_number
        )
        if native_window:
            style_mask = _send_unsigned(native_window, _sel_style_mask)
            return bool(style_mask & FULLSCREEN_STYLE_MASK)
    except (ctypes.ArgumentError, OSError, TypeError, ValueError):
        return None
    return None


def _apply_padding(boss: Boss, os_window_id: int) -> None:
    fullscreen = _native_fullscreen_state(os_window_id)
    tab_manager = boss.os_window_map.get(os_window_id)
    if fullscreen is None or tab_manager is None:
        return

    tabs_to_update: list[tuple[int, tuple[int, ...]]] = []
    source_window = None
    for tab in tab_manager.tabs:
        windows = tuple(tab)
        if source_window is None and tab.active_window is not None:
            source_window = tab.active_window
        window_ids = tuple(window.id for window in windows)
        if window_ids and any(
            _applied_state.get(window_id) != fullscreen
            for window_id in window_ids
        ):
            tabs_to_update.append((tab.id, window_ids))

    if source_window is None:
        return

    spacing = (
        (
            'padding-top=0',
            'padding-bottom=0',
            'padding-left=default',
            'padding-right=default',
        )
        if fullscreen
        else ('padding=default',)
    )
    for tab_id, window_ids in tabs_to_update:
        for window_id in window_ids:
            _applied_state[window_id] = fullscreen
        try:
            boss.call_remote_control(source_window, (
                'set-spacing',
                f'--match-tab=id:{tab_id}',
                *spacing,
            ))
        except Exception:
            for window_id in window_ids:
                _applied_state.pop(window_id, None)
            raise


def _schedule_update(boss: Boss, os_window_id: int) -> None:
    previous_timer = _pending_timers.pop(os_window_id, None)
    if previous_timer is not None:
        remove_timer(previous_timer)

    def update(timer_id: int | None) -> None:
        if timer_id is not None and _pending_timers.get(os_window_id) != timer_id:
            return
        _pending_timers.pop(os_window_id, None)
        _apply_padding(boss, os_window_id)

    _pending_timers[os_window_id] = add_timer(
        update, CHECK_DELAY_SECONDS, False
    )


def on_load(boss: Boss, data: dict[str, Any]) -> None:
    for os_window_id in tuple(boss.os_window_map):
        _schedule_update(boss, os_window_id)


def on_resize(boss: Boss, window: Window, data: dict[str, Any]) -> None:
    _schedule_update(boss, window.os_window_id)


def on_focus_change(boss: Boss, window: Window, data: dict[str, Any]) -> None:
    if data.get('focused'):
        _schedule_update(boss, window.os_window_id)


def on_close(boss: Boss, window: Window, data: dict[str, Any]) -> None:
    _applied_state.pop(window.id, None)
