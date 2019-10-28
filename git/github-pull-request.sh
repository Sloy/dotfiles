#!/usr/bin/env bash

# Credit to @padilo, many thanks!!

url=$(git remote get-url origin)

if [[ "$(echo $url | cut -d@ -f1)" != "git" ]]; then
  echo "Unrecognized remote, can't open PR"
  exit 1
fi

url_no_user=$(echo $url | cut -d@ -f2)
host=$(echo $url_no_user | cut -d: -f1)
project=$(echo $url_no_user | cut -d: -f2 | rev | cut -d. -f1- | rev)
branch=$(git rev-parse --abbrev-ref HEAD)

open "https://$host/$project/compare/$branch?expand=1"
