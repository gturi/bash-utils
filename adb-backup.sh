#!/bin/bash

function usage {
    echo "usage: ./adb-backup.sh [Options] {android folders to backup}"
    echo " -d directory   change the directory (/home/$USER/Desktop) where the backup will be saved"
    echo " -r    remove the platform-tools folder (where adb is stored) at the end of the process"
    echo "EXAMPLES:"
    echo "./adb-backup.sh /sdcard/Pictures"
    echo "./adb-backup.sh /sdcard/DCIM /sdcard/Download /sdcard/Pictures"
    echo "./adb-backup.sh -d /home/$USER/Downloads /sdcard/Pictures"
    exit 1
}

function combine_path {
    if [[ "$1" == */ ]] && [[ "$2" == /* ]]
    then
        combine_result="$1${2:1}"
    elif [[ "$1" == */ ]] || [[ "$2" == /* ]]
    then
        combine_result="$1$2"
    else
        combine_result="$1/$2"
    fi
}

# cd to the current script directoy
cd "$(dirname "$0")"

WORKING_DIR="/home/$USER/Desktop"
ADB_DIR=platform-tools

while getopts "rd:" opt; do
  case $opt in
    d)
      # changes the default working directory (where the adb-tools
      # will be downloaded and the backup will be saved)
      WORKING_DIR=$OPTARG
      ;;
    r)
      REMOVE_ADB=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument" >&2
      exit 1
      ;;
  esac
done

# if the number of received arguments is less than the next index
# to parse, no folder to backup has been passed to the script
if [ $# -lt $OPTIND ]
then
    usage
    exit 1
fi

#cd "$WORKING_DIR"
combine_path "$WORKING_DIR" "$ADB_DIR"
ADB_TOOLS_PATH="$combine_result"

# downloads latest platform-tools if missing
#if [ ! -d $ADB_DIR ]
if [ ! -d "$ADB_TOOLS_PATH" ]
then
    TMPFILE=`mktemp`
    ADBURL="https://dl.google.com/android/repository/platform-tools-latest-linux.zip"

    wget $ADBURL -O $TMPFILE
    unzip -d $WORKING_DIR $TMPFILE
    rm $TMPFILE
fi

#cd $ADB_DIR
ADB="$ADB_TOOLS_PATH/adb"

# creates the backup folder's name
BCK_NAME=Backup-$($ADB shell getprop ro.product.device)-$(date +"%Y-%m-%d")
combine_path "$WORKING_DIR" "$BCK_NAME"
#BCK_DIR="$WORKING_DIR/$BCK_NAME"
BCK_DIR="$combine_result"

mkdir "$BCK_DIR"

# $OPTIND stores the next index to parse after all the flags
# (and their parameters) have been successfully evaluated
for android_directory in "${@:$OPTIND}"
do
    # -a preserves file timestamp and mode
    $ADB pull -a "$android_directory" "$BCK_DIR"
done

./remove-empty-directories.sh "$BCK_DIR"

# remove platform-tools if the flag -r was set
if [ -n "${REMOVE_ADB+set}" ]; then
    rm -rf "$ADB_TOOLS_PATH"
fi
