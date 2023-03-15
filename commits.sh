#!/bin/bash

# default=1
# count=${1:-$default}
COUNT="$1"

FILE=$(cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g')
FILENAME=${2:-"${FILE}.md"}

if [ $# -eq 0 ]
  then
	COMMITMSG=$(python3 commitmsg.py)
	#COMMITMSG=$(curl -s http://whatthecommit.com/ | grep -A2 '<div id="content">' | awk -F: 'NR==2 {sub(/<p>/,"");print $1}')
	git add .
	git commit -a -m "${COMMITMSG}"
	exit 1
fi

for (( i=1; i<$COUNT+1; i++))
do
	sh ./editfiles.sh $FILENAME
	COMMITMSG=$(python3 commitmsg.py)
	#COMMITMSG=$(curl -s http://whatthecommit.com/ | grep -A2 '<div id="content">' | awk -F: 'NR==2 {sub(/<p>/,"");print $1}')
	git add $FILENAME
	git commit -a -m "${COMMITMSG}"
done
