#!/bin/bash

key="$HOME/.ssh/id_ed25519"
if [ ! -f "$key" ]; then
  ssh-keygen -t ed25519 -N '' -f $key 
fi

if ! gh auth status; then
  dcli sync
  gh auth login \
    --hostname github.com \
    --git-protocol ssh \
    --skip-ssh-key \
    --with-token < <(dcli note "GitHub CLI Token");
fi

name="$(scutil --get ComputerName)"
if ! gh ssh-key list | grep "$name"; then
  gh ssh-key add "$key.pub" --title "$name"
fi

