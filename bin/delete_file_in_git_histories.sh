#!/bin/bash
# Purge files that should never have been in git history.
# Rewrites all commits. Requires a force-push afterwards.
#
# Usage (from repo root):
#   ./bin/delete_file_in_git_histories.sh
#
# Dirty working trees are stashed automatically and restored after the rewrite.
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

if ! command -v git-filter-repo >/dev/null 2>&1; then
  echo "git-filter-repo is required: brew install git-filter-repo"
  exit 1
fi

origin_url="$(git remote get-url origin 2>/dev/null || true)"

stashed=0
if [ -n "$(git status --porcelain)" ]; then
  git stash push -u -m "wip: before git-filter-repo"
  stashed=1
fi

git filter-repo --force \
  --invert-paths \
  --path idea/settings.jar \
  --path nvim/.netrwhist \
  --path 'cfg/emacs/cnfonts/v4/#profile1.el#' \
  --path 'emacs/cnfonts/v4/#profile1.el#' \
  --path cfg/emacs/transient/history.el \
  --path emacs/transient/history.el

if [ -n "$origin_url" ] && ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin "$origin_url"
fi

if [ "$stashed" -eq 1 ]; then
  git stash pop
fi

echo
echo "History rewritten. GitHub still has the old commits until you force-push:"
echo "  git push --force --all"
echo "Do not git fetch before that, or origin will bring the old objects back."
