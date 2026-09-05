# dotfiles

Portable configs and bootstrap scripts. Copy the `*.example` files for
machine-specific values. Do not commit secrets, hostnames, or local paths.

```
.
 bin           # extra commands linked into ~/.local/bin
 cfg           # application configs (symlinked into $XDG_CONFIG_HOME)
 os            # OS bootstrap
 profiles.d    # shell env, aliases, prompt
 install.sh    # interactive installer
 README.md
```

## Usage

1. Back up `$XDG_CONFIG_HOME` (usually `~/.config`).
2. Read `install.sh` and `os/**/setup.sh` before running anything.
3. Copy local templates (see below) and edit them.
4. Run `./install.sh` and confirm each step.

The installer asks before it writes. It still replaces matching names under
`~/.config`, so read it first.

## Local files (gitignored)

| Path | Purpose |
| --- | --- |
| `profiles.d/local` | extra env, aliases, optional proxy |
| `profiles.d/work` | work-only shell snippets |
| `os/darwin/local.sh` | extra Homebrew casks, optional hostname |
| `cfg/wezterm/local.lua` | WezTerm SSH domains and other overrides |
| `cfg/aria2/aria2.local.conf` | download dir, RPC secret |

Start from the matching `*.example` file.

## Notes

- Neovim: set `NVIM_CONFIG_REPO` to clone an external config, or use `cfg/nvim`.
- Timezone, geo mirrors, and input-method packages stay in local files, not here.
