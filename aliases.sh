#!/usr/bin/env bash

git() { if [ "$#" -gt 1 ] && [[ "$2" == "git" ]]; then shift; shift; echo "git $*"; fi; /usr/bin/git "$@"; };
