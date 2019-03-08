#!/bin/bash

# cd to the current script directoy
cd "$(dirname "$0")"

KERNELNAME="$(uname -s)"

EXECBASH="; exec bash"
WAITENTER="; read" #"; read -p 'Press enter to continue' x"


case "${KERNELNAME}" in
    Linux*)     machine=Linux
        if [ -f $(which gnome-terminal) ]
        then
            gnome-terminal -- bash -c "$1 $EXECBASH"
        else
            x-terminal-emulator -e "$1 $EXECBASH"
        fi
        ;;
    Darwin*)    machine=Mac
        open -a Terminal "$1 $EXECBASH"
        # not working, the new opened terminal needs to cd to the script directory
        # osascript -e 'tell application "Terminal" to do script "cd path; ./start-server.sh"'
        ;;
    #CYGWIN*)    machine=Cygwin;;
    #MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${KERNELNAME}"
esac
