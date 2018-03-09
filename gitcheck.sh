#!/bin/sh

https_url="$(git remote get-url origin  | sed -e 's/:/\//g' | sed -e 's/git@/https:\/\//g')"
git fetch "$https_url" 2>/dev/null

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")

if [ $LOCAL != $REMOTE ]; then
  echo "======================================================="
  echo "Dotfiles are not in sync with remote, you should update"
  echo "======================================================="
fi
