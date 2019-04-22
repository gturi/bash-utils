#!/bin/bash

# usage: ./remove_empty_directories "/absolute/path/to/target_folder"
# description: recursively removes empty directories inside the specified path

# removes all the empty directories in the specified one (included)
function find_and_remove {
    # finds the directories in the specified one ($1) 
    # and recursively calls the function for each match
    for dir in $(find "$1" -maxdepth 1 -type d ! -path "$1"); do
        find_and_remove "$dir"
    done

    # checks if current directory is empty
    if [[ ! $(ls -A "$1") ]]
    then
        rmdir "$1"
    fi
}

if [ $# -ne 1 ]
then
    echo "Wrong arguments number, expected 1 got $#"
    exit -1
fi

# prevents errors with files with spaces in their name
IFS=$'\n'

find_and_remove "$1"
