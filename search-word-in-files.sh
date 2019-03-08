#!/bin/bash

# this script finds all the files inside a specified directory
# that contains the specified pattern (aka word)

# script params
# -r or -R is recursive,
# -n is line number, and
# -w stands for match the whole word.
# -l (lower-case L) can be added to just give the file name of matching files.
# --color used in the script to show colors, the flag is useless if the grep command is launched directly in the terminal

# This will only search through those files which have .c or .h extensions:
# grep --include=\*.{c,h} -rnw '/path/to/somewhere/' -e 'pattern'

# This will exclude searching all the files ending with .o extension:
# grep --exclude=*.o -rnw '/path/to/somewhere/' -e 'pattern'

# This will exclude the dirs dir1/, dir2/ and all of them matching *.dst/:
# grep --exclude-dir={dir1,dir2,*.dst} -rnw '/path/to/somewhere/' -e 'pattern'

if (($# == 2))
then
    DIRPATH=$1
    PATTERN=$2
    grep --color -rnw /${DIRPATH} -e ${PATTERN}
    exit 0
fi

#not working
if (($# == 3))
then
    ADDFLAGS=$1
    DIRPATH=$2
    PATTERN=$3
    grep --color ${ADDFLAGS} -rnw /${DIRPATH} -e ${PATTERN}
    exit 0
fi

echo "script usage:"
echo "$0 path/to/search/ pattern"
echo "$0 additional_flag path/to/search/ pattern"
exit -1
