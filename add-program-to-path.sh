# this script adds the specified program to $PATH

# example: ./add-program-to-path.sh '/path/to/add/add-program-to-path.sh'

BOLD='\e[1m'
RED='\e[31m'

if [ $# -ne 1 ]
then
    echo -e "${BOLD}${RED}Usage: $0 '/absolute/path/to/program'" >&2
    exit -1
fi

cd $HOME

if [[ ":$PATH:" == *":$1:"* ]]; then
    echo "$1 already exists in PATH"
else
    # appends to the end of .bashrc
    VAR='if [[ ":$PATH:" != "*':$1:'*" ]]; then\n'
    VAR=$VAR'    export PATH=$PATH:"'$1'"\n'
    VAR=$VAR'fi\n'
    echo -e $VAR >> .bashrc
    echo "$1 added to PATH"
fi

# NOT WORKING INSIDE THE SCRIPT
# open a new terminal to make the changes take effect

# reloads .bashrc file which is normally read only at log in
# source .bashrc
# . .bashrc

