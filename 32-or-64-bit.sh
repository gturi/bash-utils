#!/bin/bash

# this script tells if you have a 32 or 64 bit architecture
# i686 -> 32 bit architecture
# x86_64 -> 64 bit architecture

RESULT="$(uname -m)"
if [ "${RESULT}" == "x86_64" ];
then
  VAR=64
elif [ "${RESULT}" == "i686" ];
then
  VAR=32
fi
echo "your computer has a ${VAR} bit architecture";

#shows more infos
echo -e "\nmore infos"
uname -a

