import os
import unicodedata

from kitty.boss import get_boss
from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData

DEFAULT_MAX_TITLE_WIDTH = 30


def _color_to_rgb(c) -> int:
    """Convert Color object or int to screen cursor RGB format."""
    try:
        return (1 << 24) | (c[0] << 16) | (c[1] << 8) | c[2]
    except (TypeError, IndexError):
        return (1 << 24) | (int(c) & 0xffffff)


def _cell_width(char: str) -> int:
    if unicodedata.combining(char):
        return 0
    if unicodedata.category(char) in {'Cc', 'Cf'}:
        return 0
    return 2 if unicodedata.east_asian_width(char) in {'F', 'W'} else 1


def _display_width(text: str) -> int:
    return sum(_cell_width(char) for char in text)


def _truncate_to_width(text: str, max_width: int) -> str:
    if max_width <= 0:
        return ''
    if _display_width(text) <= max_width:
        return text

    marker = ''
    marker_width = _display_width(marker)
    if max_width <= marker_width:
        return marker

    target = max_width - marker_width
    width = 0
    out = []
    for char in text:
        char_width = _cell_width(char)
        if width + char_width > target:
            break
        out.append(char)
        width += char_width
    return ''.join(out) + marker


def _draw_clipped(screen: Screen, text: str, max_width: int) -> int:
    text = _truncate_to_width(text, max_width)
    screen.draw(text)
    return _display_width(text)


SHELLS = frozenset({
    'zsh', 'bash', 'fish', 'sh', 'dash',
    'nu', 'elvish', 'tcsh', 'csh', 'ksh',
})

# Interactive / long-running processes worth showing in the tab title.
NOTABLE_CMDS = frozenset({
    # editors
    'nvim', 'vim', 'vi', 'emacs', 'nano', 'helix', 'hx', 'code',
    # remote
    'ssh', 'mosh', 'telnet',
    # repls
    'python', 'python3', 'ipython', 'node', 'ruby', 'irb', 'lua',
    'ghci', 'erl', 'iex', 'scala', 'clj', 'r',
    # system
    'top', 'htop', 'btop', 'glances', 'watch',
    'less', 'more', 'man',
    # development
    'docker', 'kubectl', 'lazygit', 'lazydocker', 'tig',
    'gdb', 'lldb', 'nix',
    # multiplexers
    'tmux', 'screen', 'zellij',
    # agents
    'claude', 'codex', 'gemini',
    # other
    'mysql', 'psql', 'redis-cli', 'mongosh', 'sqlite3',
    'fzf', 'nnn', 'ranger', 'yazi', 'mc',
})


def _get_tab_parts(tab: TabBarData, index: int) -> tuple:
    """Returns (exe_name, dir_name). exe_name is empty for shell processes."""
    boss = get_boss()
    if boss is None:
        return ('', tab.title)
    for tm in boss.os_window_map.values():
        for t in tm.tabs:
            if t.id == tab.tab_id:
                w = t.active_window
                if w is None:
                    break
                try:
                    fp = w.child.foreground_processes
                except Exception:
                    fp = []
                cwd = ''
                if fp:
                    cwd = fp[-1].get('cwd', '')
                if not cwd:
                    try:
                        cwd = w.child.current_cwd or w.child.cwd or ''
                    except Exception:
                        cwd = ''
                home = os.path.expanduser('~')
                dir_name = '~' if cwd == home else (os.path.basename(cwd) or cwd)
                if fp:
                    cmdline = fp[-1].get('cmdline', [])
                    if cmdline:
                        exe = os.path.basename(cmdline[0])
                        name = exe.lower().lstrip('-')
                        if name not in SHELLS and name in NOTABLE_CMDS:
                            return (exe, dir_name)
                return ('', dir_name)
    return ('', tab.title)


_cached_active_bg = 0


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global _cached_active_bg
    if tab.is_active:
        _cached_active_bg = screen.cursor.bg

    prev_tab = getattr(extra_data, 'prev_tab', None)
    prev_active = prev_tab.is_active if prev_tab is not None else False
    if index > 1:
        if prev_active and _cached_active_bg:
            orig_bg = screen.cursor.bg
            screen.cursor.bg = _cached_active_bg
            screen.draw(' ')
            screen.cursor.bg = orig_bg
        elif tab.is_active:
            screen.draw(' ')
        else:
            screen.draw('')

    exe, dir_name = _get_tab_parts(tab, index)
    max_len = max(1, max_title_length or DEFAULT_MAX_TITLE_WIDTH)
    if exe:
        prefix = f" {index}: "
        prefix_width = _display_width(prefix)
        if prefix_width >= max_len:
            _draw_clipped(screen, prefix, max_len)
        else:
            screen.draw(prefix)
            remaining = max_len - prefix_width
            exe_width = _display_width(exe)
            suffix = f" {dir_name} "
            suffix_width = _display_width(suffix)

            screen.cursor.bold = True
            if exe_width >= remaining:
                _draw_clipped(screen, exe, remaining)
                screen.cursor.bold = False
            else:
                screen.draw(exe)
                screen.cursor.bold = False
                remaining -= exe_width
                if suffix_width <= remaining:
                    screen.draw(suffix)
                elif remaining >= 3:
                    screen.draw(f" {_truncate_to_width(dir_name, remaining - 2)} ")
    else:
        title = f" {index}: {dir_name} "
        _draw_clipped(screen, title, max_len)
    end = screen.cursor.x
    if is_last and not getattr(extra_data, 'for_layout', False):
        try:
            screen.cursor.bold = False
            bg = getattr(draw_data, 'tab_bar_background', None) or draw_data.default_bg
            screen.cursor.bg = _color_to_rgb(bg)
            screen.draw(' ' * max(0, screen.columns - end))
        except Exception:
            pass
    return end
