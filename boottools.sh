#!/bin/bash
# Make sure you are root before you run this script (sudo ./script.sh)
# This script is designed to update your machine and install updates/upgrades and software of users choice
# This also changes the CASE-SENSITIVE in UBUNTU, Raspbian and CentOS

clear

# Checks to verify that the script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "THIS SCRIPT NEEDS TO BE RUN AS ROOT."
   echo "EX: sudo ./boottools.sh"
   exit 1
fi

# function to install packages
install_packages() {
    if command -v apt &> /dev/null; then
        sudo apt install -y "${@}"
    elif command -v yum &> /dev/null; then
        sudo yum install -y "${@}"
    else
        echo "unsupported package manager. exiting."
        exit 1
    fi
    clear
}

clear
# update and upgrade
echo "updating and upgrading..."
if command -v apt &> /dev/null; then
    sudo apt update -y && sudo apt upgrade -y
elif command -v yum &> /dev/null; then
    sudo yum update -y
else
    echo "unsupported package manager. exiting."
    exit 1
fi
clear

# check for ubuntu
if grep -q ID=ubuntu /etc/os-release; then
    echo "this is ubuntu!"

    # install ubuntu packages
    install_packages terminator net-tools nmap arp-scan aircrack-ng wireshark tshark tree ettercap-text-only gpgv2 autoconf bison build-essential postgresql libaprutil1 libgmp3-dev libpcap-dev openssl libpq-dev libreadline6-dev libsqlite3-dev libssl-dev locate libsvn1 libtool libxml2 libxml2-dev libxslt-dev wget libyaml-dev ncurses-dev postgresql-contrib xsel zlib1g zlib1g-dev qrencode steghide vsftpd ftp zbar-tools

    # install metasploit
    sudo rm -r msfinstall
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
    sudo chmod 755 msfinstall
    sudo ./msfinstall
    sudo rm -rf msfinstall

    # additional ubuntu configs
    echo 'set completion-ignore-case on' | sudo tee -a /etc/inputrc
    clear

# check for raspbian
elif grep -q ID=raspbian /etc/os-release; then
    echo "this is raspbian!"

    # install raspbian packages
    install_packages terminator net-tools nmap arp-scan ettercap-text-only aircrack-ng wireshark tshark tree qrencode steghide vsftpd ftp zbar-tools

    # additional raspbian configs
    echo 'set completion-ignore-case on' | sudo tee -a /etc/inputrc
    clear

# check for kali
elif grep -q ID=kali /etc/os-release; then
    echo "this is kali!"

    # install kali packages
    install_packages terminator qrencode zbar-tools vsftpd ftp steghide

    # additional kali configs
    clear

# check for centos
elif grep -q ID=centos /etc/os-release; then
    echo "this is centos!"

    # install centos packages
    install_packages terminator net-tools nmap arp-scan aircrack-ng wireshark tshark tree ettercap gpgv2 autoconf bison make postgresql postgresql-server postgresql-contrib libpcap libpcap-devel openssl openssl-devel readline readline-devel sqlite sqlite-devel libyaml libyaml-devel libxml2 libxml2-devel libxslt libxslt-devel wget ncurses ncurses-devel zlib zlib-devel qrencode vsftpd ftp zbar-tools steghide

    # additional centos configs
    echo 'set completion-ignore-case on' | sudo tee -a /etc/inputrc
    clear


# if not
else
    echo "this is not ubuntu, raspbian, kali, or centos. exiting."
    exit 1
fi

clear
echo "script completed successfully."
