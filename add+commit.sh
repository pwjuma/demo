#!/bin/bash
COMMITMSG=$(curl -s http://whatthecommit.com/ | grep -A2 '<div id="content">' | awk -F: 'NR==2 {sub(/<p>/,"");print $1}')
git add .
git commit -a -m "${COMMITMSG}"