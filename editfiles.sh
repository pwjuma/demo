#!/bin/bash
FILES="$@"

n=$(( ( RANDOM % 5 )  + 1 ))

md="

### Editing file on $(date +%F_%H-%M-%S)

$(lipsum -n ${n})

"

if [ $# -eq 0 ]
then
    RANDOMFILE=`cat /usr/share/dict/web2a | sort -R | head -1 | sed 's/ //g'`
    echo "Editing file $RANDOMFILE.md"; echo "${md}" >> ${RANDOMFILE}.md; 
else
  for filename in $FILES
    do
      { echo "Editing file $filename"; echo "${md}" >> $filename; }
  done
fi

