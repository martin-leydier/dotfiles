#!/bin/bash

remote_url="$(git remote get-url origin)"
if [[ $remote_url == "git@*" ]]; then
  https_url="$(echo -n $remote_url | sed -e 's/:/\//g' | sed -e 's/git@/https:\/\//g')"
else
  https_url="$remote_url"
fi
git fetch "$https_url" 2>/dev/null

UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")

if [ $LOCAL != $REMOTE ]; then
  echo "======================================================="
  echo "Dotfiles are not in sync with remote, you should update"
  echo "======================================================="
fi
