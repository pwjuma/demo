#!/bin/bash

OWNER=peterjuma
REPO=$(basename -s .git `git config --get remote.origin.url`)

# https://michaelcurrin.github.io/auto-tag/installation

sh pr --merge

# Tag the commit 
sh autotag b


TAG=$(git describe --tags --abbrev=0)

git push origin ${TAG}
git push 

URL=$(curl -s\
  -H "Authorization: token $TOKEN" \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/${OWNER}/${REPO}/releases \
  -d '{"tag_name": "'"${TAG}"'", "name": "'"${TAG}"'", "generate_release_notes": true}' | jq -r '.html_url')

open -a "/Applications/Google Chrome.app" "$URL"