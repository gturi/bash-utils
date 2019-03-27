#!/bin/bash

NEWLINE="\n"
ENTRY="[Desktop Entry]"
ENCODING="Encoding=UTF-8"
TYPE="Type=Application"

FILECONTENT=""
function append_new_key {
    # Appends to FILECONTENT only if the input after = is not empty
    if [[ $1 =~ .+=.+$ ]] ; then
        FILECONTENT+=${1}${NEWLINE}
    fi
}

function take_input {

    # Checks that the input arguments are not less than 1 or greater than 2
    if [ $# -lt 1 ] || [ $# -gt 2 ] ;
    then
        exit -1
    fi

    # Checks if DEFAULT variable is set
    if [ -v DEFAULT ] ;
    then
        MSG="$MSG [$DEFAULT]"
    fi

    # Reads user input and assigns empty value if it is null
    read -p "$MSG: " INPUT
    INPUT="${INPUT:-$DEFAULT}"

    # Associates the input to the KEY mapping
    MAPPING="${KEY}${INPUT}"

    # Saves in the first parameter the MAPPING value
    local -n ref1=$1
    ref1=$MAPPING

    # Saves in the second parameter the INPUT value
    if [ $# -eq 2 ] ;
    then
        local -n ref2=$2
        ref2=$INPUT
    fi

    unset DEFAULT
}

# The version of the desktop entry specification to which this file complies
MSG="App Version"
DEFAULT="1.0.0"
KEY="Version="
take_input Version V
echo $Version

# The name of the application
MSG="App Name"
KEY="Name="
take_input Name N
echo $Name

# A comment which can/will be used as a tooltip
MSG="App Comment"
DEFAULT=""
KEY="Comment="
take_input Comment
echo $Comment

# The path to the folder in which the executable is run
# (leaving this field empty requires the usage of absolute 
# paths into Exec and Icon fields declaration)
MSG="App folder path"
KEY="Path="
take_input Path

# The executable of the application, with the required arguments.
MSG="App launcher path (with the required arguments)"
KEY="Exec="
take_input Exec

# The name of the icon that will be used to display this entry
MSG="App icon path "
DEFAULT="icon.xpm"
KEY="Icon="
take_input Icon

# Describes whether this application needs to be run in a terminal or not
MSG="Run in terminal"
DEFAULT="false"
KEY="Terminal="
take_input Terminal

# Describes the categories in which this entry should be shown
MSG="App categories"
DEFAULT="Application;"
KEY="Categories="
take_input Categories


# adding keys
FILECONTENT=${ENTRY}${NEWLINE}
append_new_key $ENCODING
append_new_key $TYPE
append_new_key $Version
append_new_key $Name
append_new_key $Comment
append_new_key $Path
append_new_key $Exec
append_new_key $Icon
append_new_key $Terminal
append_new_key $Categories


# creating application entry and adding execution permissions
MSG="Enter application entry name"
DEFAULT=$N-$V
KEY=""
take_input Menu
ENTRYPATH="/home/$USER/.local/share/applications/$Menu.desktop"
echo -e "$FILECONTENT" > $ENTRYPATH
chmod u+x $ENTRYPATH

