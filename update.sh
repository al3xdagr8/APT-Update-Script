#!/bin/bash

################################################################################
# Title: APT-Update-Script
# Author: al3xdagr8
# Date: October 09, 2023
# Version: 1.0
#
# Description: Bash script that simplifies the process of keeping
#              Debian-Based Linux system up-to-date using APT-GET.
#
# Changelog:
# - Version 1.0 (October 09, 2023):
#   - Initial release.
################################################################################

# Colors
yellow=$'\e[1;33m'
cyan=$'\e[0;36m'
green=$'\e[1;32m'
reset=$'\e[0m'

# Function to update system packages
update(){
    # Check if the script is being run as root
    if [ "$EUID" -ne 0 ]; then
        echo "${yellow}Please run this script as root.${reset}"
        exit 1
    fi
    
    # Update the package list and upgrade installed packages
    echo "${cyan}Updating package list and upgrading installed packages...${reset}"
    apt-get update
    apt-get upgrade -y
    apt-get full-upgrade -y
    
    # Clean up obsolete packages
    echo "${cyan}Cleaning up obsolete packages...${reset}"
    apt autoremove -y
    apt autoclean
    
    echo "${green}System update complete!${reset}"
}

# Check if the reboot-required file exists
checkReboot(){
    if [ -f /var/run/reboot-required ]; then
        echo "${yellow}Reboot is required.${reset}"
    else
        echo "${cyan}No reboot is required.${reset}"
    fi
}

update
checkReboot