#!/bin/bash

if (( $# < 1 || $# > 2 ))
then
    echo "Usage: $0 [file [out-file]]" 
    exit -1;
fi

FILE=$1
PATTERN='s/[ \t]*$//'

#echo -e " \t   blahblah  \t  " | sed 's/[ \t]*$//'
if (( $# > 1 ))
then
    OUT=$2
    sed "$PATTERN" $FILE > $OUT
else
    sed -i "$PATTERN" $FILE  # -i stands for inplace
fi

echo "trailing tabs and spaces removed successfully"
exit 0
