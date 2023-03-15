#!/bin/bash

# default=1
# count=${1:-$default}
COUNT="$1"

FILE=$(cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g')
FILENAME=${2:-"${FILE}.md"}

if [ $# -eq 0 ]
  then
	exit 1
fi

for (( i=1; i<$COUNT+1; i++))
do
	sh ./editfiles.sh $FILENAME
done