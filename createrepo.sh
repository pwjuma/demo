#!/bin/bash

REPO=`cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g'`

git init ${REPO}
cd ${REPO}
cp ~/Git/generatecommit/gitignore .gitignore
cp ~/Git/generatecommit/*{.sh,.py} .
sh commits.sh

if [[ "$1" == *"remote"* ]]
  then
	URL=`gh repo create ${REPO} --public --source=. --remote=origin 2>&1  | tail -n 1 | cut -d" " -f3`
	cd ${REPO}
	git push --set-upstream origin $(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
	open -a "/Applications/Google Chrome.app" "$URL"
fi
