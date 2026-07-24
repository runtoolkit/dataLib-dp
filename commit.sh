#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

files="$(git status --porcelain | awk '{print $2}' | paste -sd' ' -)"

if [ -z "$files" ]; then
    printf "\033[0;32mNothing to commit.\033[0m\n"
    exit 0
fi

printf "\033[0;31mAdding {%s} to git\033[0m\n" "$files"
git add -A

printf "\033[0;33mCommitting {%s} to git\033[0m\n" "$files"
git commit -m "Auto commit $(date +%Y-%m-%d_%H:%M:%S)" || exit 1

printf "\033[0;33mPushing {%s} to git\033[0m\n" "$files"
git push || exit 1

printf "\033[0;32mCommitted {%s} to git\033[0m\n" "$files"
exit 0