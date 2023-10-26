#!/bin/bash
# Make sure you are root before you run this script (sudo ./script.sh)
# This script is designed to update your machine and install updates/upgrades and software of users choice
# This also changes the CASE-SENSITIVE in UBUNTU and Raspbian

clear
echo "
▀█████████▄   ▄██████▄   ▄██████▄      ███         ███      ▄██████▄   ▄██████▄   ▄█          ▄████████ 
  ███    ███ ███    ███ ███    ███ ▀█████████▄ ▀█████████▄ ███    ███ ███    ███ ███         ███    ███ 
  ███    ███ ███    ███ ███    ███    ▀███▀▀██    ▀███▀▀██ ███    ███ ███    ███ ███         ███    █▀  
 ▄███▄▄▄██▀  ███    ███ ███    ███     ███   ▀     ███   ▀ ███    ███ ███    ███ ███         ███        
▀▀███▀▀▀██▄  ███    ███ ███    ███     ███         ███     ███    ███ ███    ███ ███       ▀███████████ 
  ███    ██▄ ███    ███ ███    ███     ███         ███     ███    ███ ███    ███ ███                ███ 
  ███    ███ ███    ███ ███    ███     ███         ███     ███    ███ ███    ███ ███▌    ▄    ▄█    ███ 
▄█████████▀   ▀██████▀   ▀██████▀     ▄████▀      ▄████▀    ▀██████▀   ▀██████▀  █████▄▄██  ▄████████▀  
                                                                                 ▀                      
"
# Checks to verify that the script is running as root
if [[ $EUID -ne 0 ]]; then
   echo "THIS SCRIPT NEEDS TO BE RUN AS ROOT."
   echo "EX: sudo ./boot-tools.sh"
   exit 1
fi

# this script checks for the operating system
# this portion is for ubuntu
if [[ "$(cat /etc/os-release | grep ID=ubuntu)" == 'ID=ubuntu' ]]; then
  # do stuff for Ubuntu
  echo "This is Ubuntu!"
    echo "INSTALLING UPDATES"
    sudo apt update -y #&& sudo apt upgrade -y
    clear
    echo "INSTALLING TERMINATOR"
    sudo apt install terminator -y
    clear
    echo "INSTALLING NET TOOLS"
    sudo apt install net-tools -y
    clear
    echo "INSTALLING NMAP"
    sudo apt install nmap -y
    clear
    echo "INSTALLING ARP-SCAN"
    sudo apt install arp-scan -y
    clear
    echo "INSTALLING AIRCRACK"
    sudo apt-get install aircrack-ng -y
    clear
    echo "INSTALLING WIRESHARK"
    sudo apt-get install wireshark -y
    clear
    echo "INSTALLING T-SHARK"
    sudo apt install tshark -y
    clear
    echo "INSTALLING TREE"
    sudo apt install tree -y
    clear
    echo "INSTALLING ETTERCAP"
    sudo apt install ettercap-text-only -y
    clear
    echo "INSTALLING BRAVE BROWSER"
    sudo apt install curl -y
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser -y
    clear
    echo "REMOVING FIREFOX"
    sudo apt remove firefox -y
    sudo snap remove firefox -y
    clear
    echo "INSTALLING METASPLOIT"
    sudo apt install gpgv2 autoconf bison build-essential postgresql libaprutil1 libgmp3-dev libpcap-dev openssl libpq-dev libreadline6-dev libsqlite3-dev libssl-dev locate libsvn1 libtool libxml2 libxml2-dev libxslt-dev wget libyaml-dev ncurses-dev  postgresql-contrib xsel zlib1g zlib1g-dev -y
    sudo rm -r msfinstall
    clear
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
    sudo chmod 755 msfinstall
    sudo ./msfinstall
    sudo rm -rf msfinstall
    clear
    echo "INSTALLING QRENCODE"
    sudo apt install qrencode -y
    clear
    echo "INSTALLING SSH AND FTP"
    sudo apt install ssh -y && sudo apt install vsftpd -y && sudo apt install ftp -y
    sudo systemctl stop ssh
    sudo systemctl disable ssh
    sudo systemctl stop vsftpd
    sudo systemctl disable vsftpd
    clear
    echo "INSTALLING STEGHIDE"
    sudo apt install steghide -y
    clear
# takes away case in-sensitive on ubuntu
    echo "CHANGING CASE SENSITIVITY"
    sudo echo 'set completion-ignore-case On' >> /etc/inputrc
    sudo echo 'set completion-ignore-case On' | sudo tee -a /etc/inputrc
    clear

# this portion is for rasbpian
elif [[ "$(cat /etc/os-release | grep ID=raspbian)" == 'ID=raspbian' ]]; then
  # do stuff for Raspbian
  echo "This is Raspbian!"
    echo "INSTALLING UPDATES"
    sudo apt update -y #&& sudo apt upgrade -y
    clear
    echo "INSTALLING TERMINATOR"
    sudo apt install terminator -y
    clear
    echo "INSTALLING NET TOOLS"
    sudo apt install net-tools -y
    clear
    echo "INSTALLING NMAP"
    sudo apt install nmap -y
    clear
    echo "INSTALLING ARP-SCAN"
    sudo apt install arp-scan -y
    clear
    echo "INSTALLING ETTERCAP"
    sudo apt install ettercap-text-only -y
    clear
    echo "INSTALLING AIRCRACK"
    sudo apt-get install aircrack-ng -y
    clear
    echo "INSTALLING WIRESHARK"
    sudo apt-get install wireshark -y
    clear
    echo "INSTALLING T-SHARK"
    sudo apt install tshark -y
    clear
    echo "INSTALLING TREE"
    sudo apt install tree -y
    clear
    echo "INSTALLING METASPLOIT"
    sudo apt install gpgv2 autoconf bison build-essential postgresql libaprutil1 libgmp3-dev libpcap-dev openssl libpq-dev libreadline6-dev libsqlite3-dev libssl-dev locate libsvn1 libtool libxml2 libxml2-dev libxslt-dev wget libyaml-dev ncurses-dev  postgresql-contrib xsel zlib1g zlib1g-dev -y
    sudo rm -r msfinstall
    clear
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
    sudo chmod 755 msfinstall
    sudo ./msfinstall
    sudo rm -rf msfinstall
    clear
    echo "INSTALLING STEGHIDE"
    sudo apt install steghide -y
    clear
    echo "INSTALLING QRENCODE"
    sudo apt install qrencode -y
    clear
    echo "INSTALLING FTP"
    sudo apt install vsftpd -y && sudo apt install ftp -y
    sudo systemctl stop ssh
    sudo systemctl disable ssh
    sudo systemctl stop vsftpd
    sudo systemctl disable vsftpd
    clear
    echo "INSTALLING ZBAR-TOOLS"
    sudo apt install zbar-tools -y
    clear

# takes away case in-sensitive on rasbian
    echo "CHANGING CASE SENSITIVITY"
    sudo echo 'set completion-ignore-case On' >> /etc/inputrc
    sudo echo 'set completion-ignore-case On' | sudo tee -a /etc/inputrc
    clear

# this portion is for KALI
elif [[ "$(cat /etc/os-release | grep ID=kali)" == 'ID=kali' ]]; then
  # do stuff for Kali
  echo "This is Kali!"
    echo "INSTALLING UPDATES"
    sudo apt update -y #&& sudo apt upgrade -y
    clear
    echo "INSTALLING TERMINATOR"
    sudo apt install terminator -y
    clear
    echo "INSTALLING BRAVE BROWSER"
    sudo apt install curl -y
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser -y
    clear
    echo "REMOVING FIREFOX"
    sudo apt remove firefox-esr -y
    clear
    echo "INSTALLING QRENCODE"
    sudo apt install qrencode -y
    clear
    echo "INSTALLING ZBAR-TOOLS"
    sudo apt install zbar-tools -y
    clear
    echo "INSTALLING FTP"
    sudo apt install vsftpd -y && sudo apt install ftp -y
    sudo systemctl stop ssh
    sudo systemctl disable ssh
    sudo systemctl stop vsftpd
    sudo systemctl disable vsftpd
    clear
    echo "INSTALLING STEGHIDE"
    sudo apt install steghide -y
    clear
else
  # Do something for other operating systems
  echo "This is not Ubuntu, Raspbian or Kali."
  # ...
fi
