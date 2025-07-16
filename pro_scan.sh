#!/bin/bash

# Author: Lala Ji
# Instagram: @lala_g_hacks
# Pro_scan - Advanced Nmap Network Scanner

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Dependency Checker
deps=("nmap" "figlet" "lolcat")
for pkg in "${deps[@]}"; do
    if ! command -v $pkg &> /dev/null; then
        echo -e "${RED}Installing $pkg...${NC}"
        sudo apt install -y $pkg
    fi
done

# Banner Function
banner() {
    clear
    figlet "PRO_SCAN" | lolcat
    echo -e "${GREEN}Created by Lala Ji | Instagram: @lala_g_hacks${NC}\n"
}

# Output Folder
mkdir -p scan_results

# Function to Save Output
save_output() {
    echo -e "\n${YELLOW}Saving output to scan_results/$1_${timestamp}.txt${NC}"
    echo "$result" > scan_results/$1_${timestamp}.txt
}

# Main Menu
main_menu() {
    PS3=$'\n\033[1;32mSelect your scan option: \033[0m'
    options=(
        "Ping Sweep"
        "TCP SYN Scan"
        "UDP Scan"
        "OS Detection"
        "Aggressive Scan"
        "Vulnerability Scan (NSE)"
        "Top 100 Ports"
        "All Ports"
        "Firewall Evasion"
        "DNS Brute Force"
        "HTTP Enumeration"
        "FTP Enumeration"
        "SMB Enumeration"
        "WAF Detection"
        "Whois Lookup"
        "MAC Spoofing"
        "Exit"
    )

    select opt in "${options[@]}"; do
        case $REPLY in
            1) basic_ping;;
            2) tcp_syn;;
            3) udp_scan;;
            4) os_detection;;
            5) aggressive_scan;;
            6) vuln_scan;;
            7) top_ports;;
            8) all_ports;;
            9) firewall_evasion;;
            10) dns_brute;;
            11) http_enum;;
            12) ftp_enum;;
            13) smb_enum;;
            14) waf_detect;;
            15) whois_lookup;;
            16) mac_spoof;;
            17) exit;;
            *) echo -e "${RED}Invalid Option${NC}";;
        esac
        break
    done
}

# Individual Scan Functions
basic_ping() {
    banner
    read -p "Enter target IP or range: " target
    timestamp=$(date +%F_%T)
    result=$(nmap -sn $target)
    echo "$result"
    save_output "ping_sweep"
}

tcp_syn() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap -sS $target)
    echo "$result"
    save_output "tcp_syn"
}

udp_scan() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap -sU $target)
    echo "$result"
    save_output "udp_scan"
}

os_detection() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap -O $target)
    echo "$result"
    save_output "os_detection"
}

aggressive_scan() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap -A $target)
    echo "$result"
    save_output "aggressive"
}

vuln_scan() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap --script vuln $target)
    echo "$result"
    save_output "vuln"
}

top_ports() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap --top-ports 100 $target)
    echo "$result"
    save_output "top_ports"
}

all_ports() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap -p- $target)
    echo "$result"
    save_output "all_ports"
}

firewall_evasion() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap -sS -T4 -f --data-length 200 $target)
    echo "$result"
    save_output "firewall_evasion"
}

dns_brute() {
    banner
    read -p "Enter domain: " domain
    timestamp=$(date +%F_%T)
    result=$(nmap --script dns-brute $domain)
    echo "$result"
    save_output "dns_brute"
}

http_enum() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap --script http-enum $target)
    echo "$result"
    save_output "http_enum"
}

ftp_enum() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap --script ftp-anon $target)
    echo "$result"
    save_output "ftp_enum"
}

smb_enum() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap --script smb-enum-shares,smb-enum-users $target)
    echo "$result"
    save_output "smb_enum"
}

waf_detect() {
    banner
    read -p "Enter target: " target
    timestamp=$(date +%F_%T)
    result=$(nmap --script http-waf-detect $target)
    echo "$result"
    save_output "waf_detect"
}

whois_lookup() {
    banner
    read -p "Enter domain/IP: " target
    timestamp=$(date +%F_%T)
    result=$(whois $target)
    echo "$result"
    save_output "whois"
}

mac_spoof() {
    banner
    echo -e "${YELLOW}Enabling MAC spoofing...${NC}"
    sudo ifconfig eth0 down
    sudo macchanger -r eth0
    sudo ifconfig eth0 up
    echo -e "${GREEN}MAC Address spoofed successfully${NC}"
}

# Start
banner
while true; do
    main_menu
    read -p $'\nPress Enter to go back to menu...'
    banner
done

