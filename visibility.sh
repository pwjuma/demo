#!/bin/bash

isPrivate=$(gh repo view --json isPrivate -q ".isPrivate")
reponame=$(gh repo view --json nameWithOwner -q ".nameWithOwner")

echo "$isPrivate"

if [ $isPrivate == "true" ]
then
	isPrivate=public
fi

if [ $isPrivate == "false" ]
then
  isPrivate=private
fi	

gh repo edit peterjuma/miniature-octo-tribble --visibility $isPrivate