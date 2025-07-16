#!/bin/bash

# Author: Lalaji
# Insta: @lalajifor_cybersecurity
# Pro_scan: Advanced Nmap-based Network Scanner

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Banner
function banner() {
    clear
    echo -e "${RED}"
    figlet -f slant "Pro_Scan" | lolcat
    echo -e "${NC}Created By: ${YELLOW}Lalaji 🔥 | Insta: @lalaji_security${NC}"
    echo ""
}

# Dependency Checker
function dependency_check() {
    for dep in nmap figlet lolcat whois; do
        if ! command -v $dep &>/dev/null; then
            echo -e "${RED}[!] $dep not found, installing...${NC}"
            sudo apt update && sudo apt install -y $dep
        else
            echo -e "${GREEN}[+] $dep found.${NC}"
        fi
    done
}

# Disclaimer
function disclaimer() {
    echo -e "${YELLOW}"
    echo "⚠️  This tool is intended for educational and authorized security testing ONLY."
    echo "❌ Any misuse is strictly prohibited and you are solely responsible."
    echo -e "${NC}"
    read -p "Do you accept this disclaimer? (y/n): " choice
    if [[ "$choice" != "y" ]]; then
        echo -e "${RED}Exiting...${NC}"
        exit 1
    fi
}

# Main Menu
function menu() {
    banner
    echo -e "${BLUE}[1] Ping Scan"
    echo "[2] TCP SYN Scan"
    echo "[3] OS Detection"
    echo "[4] Version Detection"
    echo "[5] Aggressive Scan"
    echo "[6] Top 100 Ports"
    echo "[7] All Ports Scan"
    echo "[8] Firewall Evasion Scan"
    echo "[9] Vulnerability Scan (nmap NSE)"
    echo "[10] DNS Brute Force"
    echo "[11] HTTP Enumeration"
    echo "[12] FTP Anonymous Login Check"
    echo "[13] SMB Enumeration"
    echo "[14] WHOIS Lookup"
    echo "[15] WAF Detection"
    echo "[16] MAC Address Spoofing"
    echo "[17] Exit${NC}"
    echo ""
    read -p "Choose your option [1-17]: " option
}

# Target Input
function target() {
    read -p "Enter Target IP/Domain: " target
}

# Functions for each scan
function ping_scan() {
    target
    nmap -sn $target
}

function tcp_syn() {
    target
    nmap -sS $target
}

function os_detect() {
    target
    nmap -O $target
}

function version_detect() {
    target
    nmap -sV $target
}

function aggressive() {
    target
    nmap -A $target
}

function top_ports() {
    target
    nmap --top-ports 100 -sV $target
}

function all_ports() {
    target
    nmap -p- $target
}

function firewall_evasion() {
    target
    nmap -f -D RND:10 $target
}

function vuln_scan() {
    target
    nmap --script vuln -sV $target
}

function dns_brute() {
    target
    nmap -sU --script dns-brute $target
}

function http_enum() {
    target
    nmap -sV --script http-enum $target
}

function ftp_anon() {
    target
    nmap -p 21 --script ftp-anon $target
}

function smb_enum() {
    target
    nmap -p 445 --script smb-enum-shares,smb-enum-users $target
}

function whois_lookup() {
    target
    whois $target
}

function waf_detect() {
    target
    nmap -p 80,443 --script http-waf-detect,http-waf-fingerprint $target
}

function mac_spoof() {
    echo -e "${YELLOW}[*] Current MAC Address:${NC}"
    ifconfig | grep ether
    read -p "Enter interface to spoof (e.g., eth0): " iface
    sudo ifconfig $iface down
    sudo macchanger -r $iface
    sudo ifconfig $iface up
    echo -e "${GREEN}[+] MAC spoofed!${NC}"
}

# Main Loop
function main() {
    dependency_check
    disclaimer
    while true; do
        menu
        case $option in
            1) ping_scan ;;
            2) tcp_syn ;;
            3) os_detect ;;
            4) version_detect ;;
            5) aggressive ;;
            6) top_ports ;;
            7) all_ports ;;
            8) firewall_evasion ;;
            9) vuln_scan ;;
            10) dns_brute ;;
            11) http_enum ;;
            12) ftp_anon ;;
            13) smb_enum ;;
            14) whois_lookup ;;
            15) waf_detect ;;
            16) mac_spoof ;;
            17) echo -e "${RED}Exiting...${NC}"; exit ;;
            *) echo -e "${RED}[!] Invalid Option${NC}" ;;
        esac
        echo ""
        read -p "Press Enter to continue..."
    done
}

main
