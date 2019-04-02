#!/bin/bash

# clean up root

# remove logs
sudo rm -rf /var/log

# cleans apt-get cache
# deletes downloaded packages (.deb) already installed (and no longer needed)
sudo apt-get clean

# removes all stored archives in your cache for packages that can not be downloaded anymore 
sudo apt-get autoclean

# removes unnecessary packages
sudo apt-get autoremove

#---------------------------------------------

# remove all unused linux kernel headers, images and modules
# https://ubuntugenius.wordpress.com/2011/01/08/ubuntu-cleanup-how-to-remove-all-unused-linux-kernel-headers-images-and-modules/
#dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'
#dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

#---------------------------------------------

# manually remove old Kernels

# shows current Kernel version -- DO NOT REMOVE IT
#uname -r

# list all installed Kernel versions
#dpkg --list 'linux-image*'

# shows Kernels with other infos
#dpkg --get-selections | grep linux-image

# delete old kernel versions
#sudo apt-get remove --purge linux-image-X.X.XX-XX-generic

#sudo update-grub2
