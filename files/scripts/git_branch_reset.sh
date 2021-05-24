#!/usr/bin/env bash

MAIN_BRANCH_NAME=${MAIN_BRANCH_NAME:-"main"}

read -p "You are about to reset the git history of '$MAIN_BRANCH_NAME' branch. Are you Sure? [y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  git checkout --orphan tmp-git-reset
  git add -A
  git commit -m 'Initial commit'
  git branch -D "$MAIN_BRANCH_NAME"      # Deletes the old branch
  git branch -m "$MAIN_BRANCH_NAME"      # Rename the temporary branch
  git push -f origin "$MAIN_BRANCH_NAME" # Force push to remote server
fi
