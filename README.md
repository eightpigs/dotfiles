# dotfiles

Configs for zsh, terminal emulators, tmux, and editors, plus an interactive
installer. macOS and Linux files live in the same tree; skip what you do not
use.

## Layout

```
bin/          extra commands (symlinked to ~/.local/bin)
cfg/          app configs (usually symlinked to ~/.config/<name>)
os/           OS bootstrap (common, darwin, linux)
profiles.d/   zsh env, aliases, completion, prompt
install.sh    installer
```

`cfg/<app>/.init.sh`, when present, runs instead of a plain symlink.

## Install

You need `git` and `zsh`. Read `install.sh` and `os/**/setup.sh` first.

```sh
./install.sh
```

Each step asks before it runs. If you accept "Copy cfgs to ~/.config", the
installer **replaces** `~/.config/<name>` for every entry in `cfg/`. It copies
the previous `~/.config` tree (except `nvm`) to `~/.config.bak-<timestamp>`
first.

It then appends this to `~/.zshrc` and `~/.zlogin` when those files exist:

```sh
source ~/.config/profiles.d/main
```

## Local overrides

Machine-specific values stay out of git. Copy the example, drop the `.example`
suffix, and edit. The copies are gitignored.

| File | Used by |
| --- | --- |
| `profiles.d/local` | sourced from `profiles.d/main` after aliases |
| `profiles.d/work` | same, if the file exists |
| `os/darwin/local.sh` | sourced from `os/darwin/setup.sh` |
| `cfg/wezterm/local.lua` | merged into WezTerm config |

`profiles.d/local` is the place for extra `PATH` entries, proxies, and
`NVIM_CONFIG_REPO`. `os/darwin/local.sh` can set `extra_casks`,
`HAMMERSPOON_REPO`, and `CUSTOM_HOSTNAME`.

## Neovim

`cfg/nvim` is a small fallback. To use another repo:

```sh
export NVIM_CONFIG_REPO=https://github.com/example/nvim-config.git
# optional: export NVIM_CONFIG_DIR=$HOME/.local/share/nvim-config
```

Set that in `profiles.d/local` **before** running the installer (or re-run the
config step). `cfg/nvim/.init.sh` clones the repo and points `~/.config/nvim`
at it.

## tmux

Prefix is `Alt-b`. Plugin manager is [TPM](https://github.com/tmux-plugins/tpm);
after the first install, open tmux and press `prefix` + `I`. See
`cfg/tmux/README.md` for bindings.

## Shell

`profiles.d/main` loads `env`, `alias`, `zsh`, `fzf`, then `work` and `local`
if they exist. `profiles.d/term` is not sourced by default.
