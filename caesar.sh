#!/bin/bash

COUNT=0
for letter in {a..z}; do
   nletter=$(tr "a-z" "b-za" <<< $letter)
   echo "ROT $COUNT -> [$letter]"
   # replace characters
   tr "a-z" "$nletter-za-$letter" < "$1"
   echo
   COUNT=$((COUNT+1))
done

