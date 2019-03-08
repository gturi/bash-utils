#!/bin/bash

# this script replaces tabs with spaces

TAB='\t'
SPACELEN=4  # default space number per tab

if (( $# < 1 || $# > 3 ))
then
    echo "Usage: $0 [file [spacelen [out-file]]]" 
    exit -1;
fi

FILE=$1

# setting space length
if (( $# > 1 ))
then 
    SPACELEN=$2
fi

for (( NUM=0 ; $NUM < $SPACELEN ; NUM=${NUM}+1)) ;
do SPACE+=' ' ;
done

# removing tabs

PATTERN="s/$TAB/$SPACE/g"

if (( $# > 2 ))
then
    OUT=$3
    sed "$PATTERN" $FILE > $OUT
else
    sed -i "$PATTERN" $FILE  # -i stands for inplace
fi

echo "tab conversion ended successfully"
exit 0
