#!/bin/bash

DEFAULTCOUNT=$(( ( RANDOM % 10 )  + 1 ))

FILECOUNT=${1:-$DEFAULTCOUNT}

echo Creting ${FILECOUNT} files...

FILECONTENT="

### Editing file on $(date +%F_%H-%M-%S)

$(lipsum -n 2)

"

for ((i=1;i<=${FILECOUNT};i++))
do
  RANDOMFILE=`cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g'`
  echo "Editing file $RANDOMFILE.md"; echo "${FILECONTENT}" >> ${RANDOMFILE}.md;
done



