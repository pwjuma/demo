#!/bin/bash

DEFAULT=1
COUNT=${1:-$DEFAULT}
reponame=$(gh repo view --json nameWithOwner -q ".nameWithOwner")

for (( i=1; i<$COUNT+1; i++))
do
	subject=`lipsum -w 2`
	body=`lipsum -n 1`
	gh issue create --title "$subject" --body "$body" --repo ${reponame} 
done
