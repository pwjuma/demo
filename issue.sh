#!/bin/bash

subject=`lipsum -w 2`
body=`lipsum -n 1`
reponame=$(gh repo view --json nameWithOwner -q ".nameWithOwner")
URL=$(gh issue create --title "$subject" --body "$body" --repo ${reponame} | grep -oE "https://github.com/[a-zA-Z0-9./?=_-]*/issues/[0-9]*")
open -a "/Applications/Google Chrome.app" "$URL"

