#!/bin/bash

for ref in $(git branch)
do
   if [[ "$ref" != "master" && "$ref" != "main" && "$ref" != *"remotes/origin"* ]]; then
		git checkout $ref --quiet
		echo "Resetting branch ${ref}"
		echo "============================================================"
		git reset --hard HEAD~
	fi
done
