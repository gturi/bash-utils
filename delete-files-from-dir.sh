#!/bin/bash

# given a directory, recursively deletes files ending with the specified KEYWORD 

DIR=$1 # directory
KEYWORD=$2

for file in `find $DIR -name "*$KEYWORD" -print`
do
echo "${file} removed";
rm ${file};
done
