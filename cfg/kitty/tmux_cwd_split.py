"""Open a kitty split in the active tmux pane's working directory."""

from __future__ import annotations

import os
import shutil
import subprocess

from kittens.tui.handler import result_handler
from kitty.boss import Boss
from kitty.window import Window


LOCATIONS = frozenset({'vsplit', 'hsplit'})
TMUX_CLIENT_FORMAT = '#{client_pid}\t#{pane_current_path}'
TMUX_PATHS = ('/opt/homebrew/bin/tmux', '/usr/local/bin/tmux', '/usr/bin/tmux')


def main(args: list[str]) -> None:
    pass


def _tmux_pane_cwd(window: Window) -> str | None:
    """Return the active pane cwd when this kitty window is running tmux."""
    try:
        processes = window.child.foreground_processes
    except Exception:
        return None

    for process in reversed(processes):
        cmdline = process.get('cmdline') or ()
        if not cmdline:
            continue

        command = str(cmdline[0])
        if os.path.basename(command).lstrip('-') != 'tmux':
            continue

        executable = next(
            (path for candidate in (command, *TMUX_PATHS) if (path := shutil.which(candidate))),
            None,
        )
        pid = process.get('pid')
        if not executable or not isinstance(pid, int):
            continue
        try:
            result = subprocess.run(
                [executable, 'list-clients', '-F', TMUX_CLIENT_FORMAT],
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.DEVNULL,
                text=True,
                timeout=1,
            )
        except (OSError, subprocess.SubprocessError):
            continue

        for line in result.stdout.splitlines():
            client_pid, separator, cwd = line.partition('\t')
            if separator and client_pid == str(pid) and os.path.isdir(cwd):
                return cwd
    return None


@result_handler(no_ui=True)
def handle_result(
    args: list[str],
    answer: str,
    target_window_id: int,
    boss: Boss,
) -> None:
    window = boss.window_id_map.get(target_window_id)
    if window is None:
        return

    location = next((arg for arg in reversed(args) if arg in LOCATIONS), 'vsplit')
    cwd = _tmux_pane_cwd(window) or 'current'
    tab_match = f'window_id:{window.id}'
    window_match = f'id:{window.id}'

    boss.call_remote_control(window, ('goto-layout', f'--match={tab_match}', 'splits'))
    boss.call_remote_control(window, (
        'launch',
        f'--match={tab_match}',
        f'--source-window={window_match}',
        f'--cwd={cwd}',
        '--copy-env',
        f'--location={location}',
    ))
