#!/bin/bash

if ! git ls-remote --exit-code https 2>&1 >/dev/null; then
  remote_url="$(git remote get-url origin)"
  if [ "${remote_url:0:4}" == "git@" ]; then
    https_url="$(echo -n $remote_url | sed -e 's/:/\//g' | sed -e 's/git@/https:\/\//g')"
  else
    https_url="$remote_url"
  fi
  echo test
  git remote add https "$https_url"
fi
git fetch https 2>/dev/null

LOCAL=$(git rev-parse master)
REMOTE=$(git rev-parse "https/master")

if [ $LOCAL != $REMOTE ]; then
  echo "===================================="
  echo "Dotfiles are not in sync with remote"
  echo "===================================="
fi
