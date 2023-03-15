#!/bin/bash
default=10
count=${1:-$default}
filename=${2:-"file-with-$count-lines.txt"}
# for (( i=1; i<$count+1; i++)) do 
# 	echo -e "#Vivamus in erat ut urna cursus vestibulum. Morbi ac felis. Phasellus ullamcorper ipsum rutrum nunc. In auctor lobortis lacus."  >> $filename
# done
lipsum -n $count -l >> $filename
echo "Created $filename with $count lines"
