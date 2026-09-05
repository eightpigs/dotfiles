# tmux

Prefix: `Alt-b` (`M-b`). Config: `.tmux.conf`. Helpers: `pane-status-label`,
`mirror-prefix-meta`.

## Prefix bindings

| Key | Action |
| --- | --- |
| `h` `j` `k` `l` | select pane |
| `H` `J` `K` `L` | resize pane (repeatable) |
| `\|` | split horizontal, cwd from current pane |
| `-` | split vertical, cwd from current pane |
| `=` | equalize pane sizes, keep layout |
| `c` | new window, cwd from current pane |
| `,` | rename window (sticky name in the status bar) |
| `.` | move window before a given index |
| `` ` `` | last window |
| `r` | reload `~/.tmux.conf` |
| `s` | tmux-jump |
| `Alt-1` … `Alt-7` | select layout |

Copy mode uses vi keys. `v` starts selection, `y` copies.

## No prefix

| Key | Action |
| --- | --- |
| `Shift-Left` / `Shift-Right` | previous / next window |
| `Shift-Up` / `Shift-Down` | toggle or move the status bar |
| `Alt-Left` / `Alt-Right` | swap window with neighbor |
| `Alt-1` … `Alt-9` | select window |
| `Alt-h` `j` `k` `l` | pane movement (passed through in Vim) |

## Plugins

Installed via TPM (`~/.tmux/plugins/tpm`). Press `prefix` + `I` once.

- tmux-sensible
- tmux-resurrect
- tmux-jump
