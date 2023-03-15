#!/bin/bash
NEW_HEAD=`cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g'`
git checkout -b ${NEW_HEAD}
./commits.sh 1 "${NEW_HEAD}.md"
git push --set-upstream origin ${NEW_HEAD}