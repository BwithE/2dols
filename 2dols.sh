#!/bin/bash

# Root check
if [[ $EUID -ne 0 ]]; then
    echo "THIS SCRIPT NEEDS TO BE RUN AS ROOT."
    echo "EX: sudo ./$0"
    exit 1
fi

# Banner
cat << "EOF"
██████╗ ██████╗  ██████╗ ██╗     ███████╗
╚════██╗██╔══██╗██╔═══██╗██║     ██╔════╝
 █████╔╝██║  ██║██║   ██║██║     ███████╗
██╔═══╝ ██║  ██║██║   ██║██║     ╚════██║
███████╗██████╔╝╚██████╔╝███████╗███████║
╚══════╝╚═════╝  ╚═════╝ ╚══════╝╚══════╝

EOF

# Unified tool list (close to Kali)
tool_list="aircrack-ng arp-scan bloodhound build-essential chisel curl exploitdb ftp g++-mingw-w64 gobuster gpgv2 libaprutil1 libgmp3-dev libpcap-dev libpq-dev libreadline6-dev libsqlite3-dev libssl-dev libsvn1 libtool libxml2 libxml2-dev libxslt-dev libyaml-dev libreoffice libreoffice-gtk4 ligolo-ng locate mingw-w64 ncat net-tools ncurses-dev nmap obsidian openssl postgresql postgresql-contrib python3-venv qrencode rlwrap seclists shellter steghide terminator tshark tree vsftpd wget wireshark wine xsel zbar-tools zlib1g zlib1g-dev veil ettercap-text-only"

# Detect OS
OS=$(uname -a | tr '[:upper:]' '[:lower:]')

# Install function
install_packages() {
    apt update -y && apt upgrade -y
    apt install -y $tool_list

    # Only install Metasploit if NOT Kali
    if [[ $1 == "install_msf" ]]; then
        curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb -o msfinstall
        chmod 755 msfinstall
        ./msfinstall && rm -f msfinstall
    fi

    echo 'set completion-ignore-case on' >> /etc/inputrc
    apt autoremove -y && apt clean
}

# OS handling
if [[ $OS == *"ubuntu"* ]]; then
    echo "[+] Detected Ubuntu"
    install_packages "install_msf"

elif [[ $OS == *"raspbian"* ]]; then
    echo "[+] Detected Raspbian"
    install_packages "install_msf"

elif [[ $OS == *"kali"* ]]; then
    echo "[+] Detected Kali Linux"
    install_packages "skip_msf"  # Kali already has Metasploit, ExploitDB, etc.

else
    echo "[-] Unsupported OS. Exiting..."
    exit 1
fi

echo "+-------------------------------------+"
echo "Tool installation completed!"
                  
