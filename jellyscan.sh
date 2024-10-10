#!/bin/bash

# Define color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m'

# Get the IP address from the first argument
ip=$1

# Display the banner
echo -e "${CYAN}
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠒⠋⠉⠉⠉⠒⢤⡀⠀⠀⠀⠀⠀⠀⠀    _      _ _        _____                 
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠖⠁⠀⠀⠀⠀⠀⠀⠈⠳⡄⠀⠀⠀⠀⠀   (_)    | | |      / ____|                
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢆⠀⠀⠀    _  ___| | |_   _| (___   ___ __ _ _ __  
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀   | |/ _ \ | | | | |\___ \ / __/ _' | '_ \\
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀   | |  __/ | | |_| |____) | (_| (_| | | | |
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢇⡀⠀⠀⢀⠀⢀⠀⠀⡀⠀⠀⠀⢀⠀⡰⠁   | |\___|_|_|\__, |_____/ \___\__,_|_| |_|
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠉⢹⡏⠙⠉⢹⢿⠉⢹⢹⠉⢫⠉⠀  _/ |          __/ |                       
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠘⡇⢰⢀⡾⡎⠀⡾⠘⡄⢸⡀⠀  |__/          |___/                        
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡀⡇⡎⢸⡇⢇⠀⡇⢰⢹⠀⡇⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢃⢷⣇⢸⡇⢸⡀⣇⡎⢸⢠⠇⠀    ${RED}Made by Youssef Kandeel ${NC} | ${YELLOW} @kandeel679 ${NC}${CYAN}
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣜⣼⢸⠘⢌⣇⡇⠱⣜⣇⣎⠞⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠈⡎⡆⠈⡏⢇⠀⢳⢹⠁⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀${NC}
"

# Check if an IP address was provided
if [ -z "$ip" ]; then
  echo -e "${RED}Error: No IP address provided.${NC}"
  exit 1
fi

echo -e "${YELLOW}[+] Top 1000 ports nmap scan on Target => ${ip}${NC}"

# Check if the results directory exists, if not create it
mkdir -p ./Results/Top1000
mkdir -p ./Results/DBoutput

# Run nmap scan in the background
nmap -T4 -A -Pn $ip -oN ./Results/Top1000/$ip.txt > /dev/null 2>&1 &
nmap_pid=$!  # Store the PID of the nmap process

# Notify that the scan is running
echo -e "${GREEN}[+] Nmap scanning started in the background with PID: $nmap_pid${NC}"

# Wait for the nmap scan to complete
wait $nmap_pid

# Notify that the scan is complete
echo -e "${GREEN}[+] Nmap scanning complete! Results saved to ./Results/Top1000/$ip.txt${NC}"
