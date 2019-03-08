#!/bin/bash

PORT=8080

if [ $# -ge 1 ]; then 
    PORT=$1
fi


if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null ; then
    printf "process "
else
    printf "no process "
fi
printf "running on port $PORT \n"

