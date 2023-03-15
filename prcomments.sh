#!/bin/bash

echo "Usage: ./prcomments.sh -p <pr-number> -c <comment count>"

while getopts p:c: flag
do
    case "${flag}" in
        p) prnumber=${OPTARG};;
        c) count=${OPTARG};;
    esac
done

echo "Pull request number: $prnumber"
echo "Pull request comments: $count"

for (( i=1; i<$count+1; i++))
do
    body=`lipsum -n 1`
    curl --silent \
    -H "Authorization: token $TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/peterjuma/demo/issues/${prnumber}/comments \
    -d '{"body":"'"$body"'"}' &
done
