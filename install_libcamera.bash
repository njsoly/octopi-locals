#!/usr/bin/env bash

###################################################################################################################################
# I found these instructions online, and adjusted a wget line to a cURL one.
#
# Original source:
# https://docs.arducam.com/Raspberry-Pi-Camera/Motorized-Focus-Camera/Quick-Start-Guide/OV5647-Motorized-Focus-Camera/
###################################################################################################################################

if [[ ! $(cat /boot/config.txt | grep 'dtoverlay=ov5647,vcm') ]]; then
	echo "you have to go in and enter dtoverlay=ov5647,vcm under [all] in /boot/config.txt"
	echo "then reboot the system (sudo reboot)."
fi


if [[ -x install_pivariety_pkgs.sh ]]; then
	curl -o install_pivariety_pkgs.sh https://github.com/ArduCAM/Arducam-Pivariety-V4L2-Driver/releases/download/install_script/install_pivariety_pkgs.sh
	chmod +x install_pivariety_pkgs.sh
fi

./install_pivariety_pkgs.sh -p libcamera_dev
./install_pivariety_pkgs.sh -p libcamera_apps

