#!/bin/bash
# If NVIM_CONFIG_REPO is set, clone it and use that tree.
# Otherwise symlink this directory.

set -euo pipefail

dest="${XDG_CONFIG_HOME:?}/nvim"

if [ -n "${NVIM_CONFIG_REPO:-}" ]; then
  src="${NVIM_CONFIG_DIR:-$HOME/.local/share/nvim-config}"
  if [ ! -d "$src/.git" ]; then
    git clone --depth 1 "$NVIM_CONFIG_REPO" "$src"
  fi
  rm -rf "$dest"
  ln -sfn "$src" "$dest"
else
  rm -rf "$dest"
  ln -sfn "$PWD/cfg/nvim" "$dest"
fi
