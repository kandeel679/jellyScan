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

# Default scan level
scan_level=2

# Function to display help message
display_help() {
    echo -e "${CYAN}Usage: $0 [OPTIONS] <target_ip>${NC}"
    echo -e "${WHITE}OPTIONS:${NC}"
    echo -e "  ${GREEN}-l, --level <1-4>${NC}    Set scan level (default: 2)"
    echo -e "      ${YELLOW}Level 1:${NC} Quick Scan (nmap basic, minimal footprint)"
    echo -e "      ${YELLOW}Level 2:${NC} Standard Scan (nmap, enum4linux, basic web)"
    echo -e "      ${YELLOW}Level 3:${NC} Advanced Scan (adds more web tools, dns enum)"
    echo -e "      ${YELLOW}Level 4:${NC} Comprehensive Scan (all tools, deep scanning)"
    echo -e "  ${GREEN}-h, --help${NC}           Display this help message and exit"
    echo
    echo -e "${WHITE}EXAMPLES:${NC}"
    echo -e "  $0 192.168.1.10               # Standard scan of target"
    echo -e "  $0 -l 1 192.168.1.10          # Quick scan of target"
    echo -e "  $0 --level 4 192.168.1.10     # Full comprehensive scan"
    exit 0
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -l|--level)
            scan_level="$2"
            if ! [[ "$scan_level" =~ ^[1-4]$ ]]; then
                echo -e "${RED}Error: Scan level must be between 1 and 4${NC}"
                exit 1
            fi
            shift 2
            ;;
        -h|--help)
            display_help
            ;;
        *)
            ip="$1"
            shift
            ;;
    esac
done
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
    display_help
    exit 1
fi

# Print scan level information

echo -e "${BLUE}[*] AUTOMATE CTF SCANNING TOOL${NC}"

echo -e "${BLUE}[*] Target: ${YELLOW}$ip${NC}"
case $scan_level in
    1) echo -e "${BLUE}[*] Scan Level: ${GREEN}1 - Quick Scan${NC} (Basic port scanning only)" ;;
    2) echo -e "${BLUE}[*] Scan Level: ${YELLOW}2 - Standard Scan${NC} (Common enumeration techniques)" ;;
    3) echo -e "${BLUE}[*] Scan Level: ${YELLOW}3 - Advanced Scan${NC} (Deeper enumeration and vulnerability checks)" ;;
    4) echo -e "${BLUE}[*] Scan Level: ${RED}4 - Comprehensive Scan${NC} (Full suite of tools and techniques)" ;;
esac


# Check required tools

# Create directories for results
mkdir -p ./Results/$ip/nmap
echo -e "${BLUE}[*] Results will be saved in ./Results/$ip/${NC}"

# Create additional directories based on scan level
if [ $scan_level -ge 2 ]; then
    mkdir -p ./Results/$ip/enum
fi

if [ $scan_level -ge 2 ]; then
    mkdir -p ./Results/$ip/web
fi

if [ $scan_level -ge 3 ]; then
    mkdir -p ./Results/$ip/dns
    mkdir -p ./Results/$ip/vulnerability
fi

if [ $scan_level -ge 4 ]; then
    mkdir -p ./Results/$ip/ssl
    mkdir -p ./Results/$ip/fuzz
    mkdir -p ./Results/$ip/brute
fi

# Record scan start time
start_time=$(date +%s)

# Function to check if a port is open
check_port_open() {
    local port=$1
    nmap -T4 -p $port $ip 2>/dev/null | grep -q "open"
    return $?
}

# Function to print section divider
print_divider() {
    echo -e "${CYAN}=============================================================${NC}"
}

# Function to check for tool availability
check_tool() {
    command -v $1 >/dev/null 2>&1 || { echo -e "${RED}[-] Error: $1 is required but not installed.${NC}"; return 1; }
    return 0
}

# Check for required tools based on scan level
check_required_tools() {
    local required_tools=("nmap")
    local level2_tools=("enum4linux" "whatweb" "gobuster")
    local level3_tools=("dnsrecon" "nikto" "wget" "sqlmap")
    local level4_tools=("sslyze" "wfuzz" "smtp-user-enum" "onesixtyone" "davtest" "cmsmap")
    
    echo -e "${BLUE}[*] Checking for required tools...${NC}"
    
    # Always check for basic tools
    for tool in "${required_tools[@]}"; do
        if ! check_tool $tool; then
            echo -e "${RED}[-] Critical tool missing. Exiting.${NC}"
            exit 1
        fi
    done
    
    # Check based on scan level
    if [ $scan_level -ge 2 ]; then
        for tool in "${level2_tools[@]}"; do
            check_tool $tool || echo -e "${YELLOW}[!] Warning: $tool not found. Some scans will be skipped.${NC}"
        done
    fi
    
    if [ $scan_level -ge 3 ]; then
        for tool in "${level3_tools[@]}"; do
            check_tool $tool || echo -e "${YELLOW}[!] Warning: $tool not found. Some scans will be skipped.${NC}"
        done
    fi
    
    if [ $scan_level -ge 4 ]; then
        for tool in "${level4_tools[@]}"; do
            check_tool $tool || echo -e "${YELLOW}[!] Warning: $tool not found. Some advanced scans will be skipped.${NC}"
        done
    fi
    
    echo -e "${GREEN}[+] Tool check completed${NC}"
}

# ----------------------------------------
# NMAP Scanning
# ----------------------------------------
echo -e "${YELLOW}[+] Initiating Nmap scan on target => ${ip}${NC}"

# Configure nmap based on scan level
case $scan_level in
    1)
        # Level 1: Quick scan - just top ports and service detection
        echo -e "${BLUE}[*] Level 1 scan: Quick port scan${NC}"
        nmap -T4 --top-ports 1000 -sV $ip -oN ./Results/$ip/nmap/nmapScan.txt > /dev/null 2>&1 &
        ;;
    2)
        # Level 2: Standard scan - more comprehensive
        echo -e "${BLUE}[*] Level 2 scan: Standard comprehensive scan${NC}"
        nmap -T4 -A -Pn $ip -oN ./Results/$ip/nmap/nmapScan.txt > /dev/null 2>&1 &
        ;;
    3)
        # Level 3: Advanced scan - all ports and scripts
        echo -e "${BLUE}[*] Level 3 scan: Advanced port scan with all default scripts${NC}"
        nmap -T4 -A -Pn -p- $ip -oN ./Results/$ip/nmap/nmapScan.txt > /dev/null 2>&1 &
        ;;
    4)
        # Level 4: Comprehensive scan - all ports, all scripts, vulnerability scanning
        echo -e "${BLUE}[*] Level 4 scan: Comprehensive port scan with all scripts${NC}"
        nmap -T4 -A -Pn -p- --script=default,vuln,discovery $ip -oN ./Results/$ip/nmap/nmapScan.txt > /dev/null 2>&1 &
        # Add UDP scan for Level 4
        echo -e "${BLUE}[*] Level 4 scan: Adding UDP top ports scan${NC}"
        nmap -sU -T4 --top-ports 100 $ip -oN ./Results/$ip/nmap/udpScan.txt > /dev/null 2>&1 &
        ;;
esac
nmap_pid=$! # Store the PID of the nmap process
echo -e "${GREEN}[+] Nmap scanning started in background with PID: $nmap_pid${NC}"

# Conditional tool execution based on scan level
if [ $scan_level -ge 2 ]; then
    # ----------------------------------------
    # ENUM4LINUX Scanning (Level 2+)
    # ----------------------------------------
    echo -e "${YELLOW}[+] Using enum4linux on target => ${ip}${NC}"
    enum4linux -A $ip > ./Results/$ip/enum/enumScan.txt 2>&1 &
    enum_pid=$!
    echo -e "${GREEN}[+] enum4linux scanning started in background with PID: $enum_pid${NC}"
    
    # ----------------------------------------
    # Web Server Information with WhatWeb (Level 2+)
    # ----------------------------------------
    echo -e "${YELLOW}[+] Gathering web server information with WhatWeb => ${ip}${NC}"
    whatweb $ip -v > ./Results/$ip/web/whatweb.txt 2>&1 &
    whatweb_pid=$!
    echo -e "${GREEN}[+] WhatWeb scan started in background with PID: $whatweb_pid${NC}"
fi

if [ $scan_level -ge 3 ]; then
    # ----------------------------------------
    # DNS Enumeration with DNSRecon (Level 3+)
    # ----------------------------------------
    echo -e "${YELLOW}[+] Starting DNS reconnaissance with dnsrecon => ${ip}${NC}"
    dnsrecon -d $ip -t std -a > ./Results/$ip/dns/dnsrecon.txt 2>&1 &
    dns_pid=$!
    echo -e "${GREEN}[+] DNS reconnaissance started in background with PID: $dns_pid${NC}"
    
    # ----------------------------------------
    # Web Vulnerability Scanning with Nikto (Level 3+)
    # ----------------------------------------
    echo -e "${YELLOW}[+] Running web vulnerability scan with Nikto => ${ip}${NC}"
    nikto -h $ip -output ./Results/$ip/web/nikto.txt > /dev/null 2>&1 &
    nikto_pid=$!
    echo -e "${GREEN}[+] Nikto scan started in background with PID: $nikto_pid${NC}"
fi

if [ $scan_level -ge 4 ]; then
    # ----------------------------------------
    # SSL/TLS Scanning with SSLyze (Level 4)
    # ----------------------------------------
    echo -e "${YELLOW}[+] Checking SSL/TLS configuration with SSLyze => ${ip}${NC}"
    sslyze --regular $ip > ./Results/$ip/ssl/sslyze.txt 2>&1 &
    sslyze_pid=$!
    echo -e "${GREEN}[+] SSLyze scan started in background with PID: $sslyze_pid${NC}"

    # ----------------------------------------
    # SMTP User Enumeration (Level 4)
    # ----------------------------------------
    echo -e "${YELLOW}[+] Attempting SMTP user enumeration => ${ip}${NC}"
    smtp-user-enum -M VRFY -U /usr/share/wordlists/metasploit/unix_users.txt -t $ip > ./Results/$ip/enum/smtp_enum.txt 2>&1 &
    smtp_pid=$!
    echo -e "${GREEN}[+] SMTP enumeration started in background with PID: $smtp_pid${NC}"
    
    # ----------------------------------------
    # SNMP Enumeration (Level 4)
    # ----------------------------------------
    echo -e "${YELLOW}[+] Checking for SNMP information => ${ip}${NC}"
    onesixtyone -c /usr/share/doc/onesixtyone/dict.txt $ip > ./Results/$ip/enum/snmp.txt 2>&1 &
    snmp_pid=$!
    echo -e "${GREEN}[+] SNMP enumeration started in background with PID: $snmp_pid${NC}"
fi

# Wait for preliminary scans to complete to identify web servers
wait $nmap_pid
echo -e "${GREEN}[+] Nmap scanning complete! Results saved to ./Results/$ip/nmap/nmapScan.txt${NC}"

# Only continue with web scanning if scan level > 1
if [ $scan_level -ge 2 ]; then
    # Check for HTTP ports from Nmap results
    http_ports=$(grep "open" ./Results/$ip/nmap/nmapScan.txt | grep -E "http|www|web" | grep -oE '[0-9]+/tcp' | cut -d '/' -f1 | tr '\n' ' ')

    # If no HTTP ports found, use common ones
    if [ -z "$http_ports" ]; then
        http_ports="80 443 8080 8443"
        echo -e "${YELLOW}[+] No HTTP ports explicitly found, using common ports: $http_ports${NC}"
    else
        echo -e "${BLUE}[+] HTTP ports found: $http_ports${NC}"
    fi

    # Web scanning intensity based on scan level
    for port in $http_ports; do
        if check_port_open $port; then
            # Level 2+: Basic directory enumeration
            if [ $scan_level -ge 2 ]; then
                echo -e "${YELLOW}[+] Starting directory enumeration with Gobuster on http://${ip}:${port}${NC}"
                # Adjust wordlist size based on scan level
                wordlist="/usr/share/wordlists/dirb/common.txt"
                if [ $scan_level -ge 4 ]; then
                    wordlist="/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt"
                    echo -e "${BLUE}[*] Level 4: Using larger wordlist for thorough enumeration${NC}"
                fi
                
                gobuster dir -u http://${ip}:${port} -w $wordlist \
                    -o ./Results/$ip/web/gobuster_${port}.txt > /dev/null 2>&1 &
                gobuster_pid=$!
                echo -e "${GREEN}[+] Gobuster scan started on port $port in background with PID: $gobuster_pid${NC}"
            fi
            
            # Level 3+: SQL injection testing
            if [ $scan_level -ge 3 ]; then
                echo -e "${YELLOW}[+] Testing for SQL injection vulnerabilities on http://${ip}:${port}${NC}"
                # Download the main page for SQLMap testing
                wget -q http://${ip}:${port} -O ./Results/$ip/web/index_${port}.html
                
                # Check if the page contains any forms
                if grep -q "<form" ./Results/$ip/web/index_${port}.html; then
                    echo -e "${BLUE}[+] Forms detected on port $port, running SQLMap${NC}"
                    
                    # Configure SQLMap intensity based on scan level
                    if [ $scan_level -eq 3 ]; then
                        sqlmap -u http://${ip}:${port} --forms --batch --level=1 --risk=1 \
                               -o ./Results/$ip/vulnerability/sqlmap_${port}.txt > /dev/null 2>&1 &
                    else # Level 4
                        echo -e "${BLUE}[*] Level 4: Running comprehensive SQLMap scan${NC}"
                        sqlmap -u http://${ip}:${port} --forms --batch --crawl=3 --level=3 --risk=2 \
                               -o ./Results/$ip/vulnerability/sqlmap_${port}.txt > /dev/null 2>&1 &
                    fi
                    sqlmap_pid=$!
                    echo -e "${GREEN}[+] SQLMap scan started on port $port in background with PID: $sqlmap_pid${NC}"
                else
                    echo -e "${BLUE}[*] No forms detected on main page of port $port, skipping SQLMap${NC}"
                fi
            fi
            
            # Level 4: Additional web scanning techniques
            if [ $scan_level -ge 4 ]; then
                # Web fuzzing with wfuzz
                echo -e "${YELLOW}[+] Running web fuzzing on http://${ip}:${port}${NC}"
                wfuzz -c -w /usr/share/wordlists/wfuzz/general/common.txt --hc 404 http://${ip}:${port}/FUZZ \
                      > ./Results/$ip/fuzz/wfuzz_${port}.txt 2>&1 &
                wfuzz_pid=$!
                echo -e "${GREEN}[+] Wfuzz scan started on port $port in background with PID: $wfuzz_pid${NC}"
                
                # CMS detection with CMSmap
                echo -e "${YELLOW}[+] Checking for CMS on http://${ip}:${port}${NC}"
                cmsmap http://${ip}:${port} -o ./Results/$ip/web/cmsmap_${port}.txt > /dev/null 2>&1 &
                cmsmap_pid=$!
                echo -e "${GREEN}[+] CMS detection started on port $port in background with PID: $cmsmap_pid${NC}"
                
                # Check for WebDAV
                echo -e "${YELLOW}[+] Checking for WebDAV on http://${ip}:${port}${NC}"
                davtest -url http://${ip}:${port} > ./Results/$ip/web/webdav_${port}.txt 2>&1 &
                davtest_pid=$!
                echo -e "${GREEN}[+] WebDAV test started on port $port in background with PID: $davtest_pid${NC}"
            fi
        fi
    done
fi

# ----------------------------------------
# Wait for all scans to complete
# ----------------------------------------
echo -e "${PURPLE}[*] Waiting for all scans to complete...${NC}"
wait

# Calculate elapsed time
end_time=$(date +%s)
elapsed=$((end_time - start_time))
elapsed_formatted=$(printf "%02d:%02d:%02d" $((elapsed/3600)) $((elapsed%3600/60)) $((elapsed%60)))

# ----------------------------------------
# Create summary report
# ----------------------------------------
echo -e "${BLUE}[+] Creating summary report${NC}"
cat << EOF > ./Results/$ip/summary.txt
=================================================
      CTF SCAN SUMMARY REPORT FOR ${ip}
=================================================
Generated on: $(date)
Scan Level: $scan_level
Elapsed Time: $elapsed_formatted
OPEN PORTS & SERVICES:
$(grep "open" ./Results/$ip/nmap/nmapScan.txt 2>/dev/null | sort)
EOF
# Add conditional sections based on scan level
if [ $scan_level -ge 2 ]; then
    # Only add web server section if level 2+
    cat << EOF >> ./Results/$ip/summary.txt
WEB SERVERS:
$(for port in $http_ports 2>/dev/null; do
    if check_port_open $port 2>/dev/null; then
        echo "* Port $port: $(grep -A3 "$port" ./Results/$ip/web/whatweb.txt 2>/dev/null | grep -v "Running" || echo "No WhatWeb data")"
    fi
done)
EOF
    # Add SMB info if level 2+
    cat << EOF >> ./Results/$ip/summary.txt
SMB/SAMBA INFO:
$(grep -E "Domain|OS|Server|Groups|Users" ./Results/$ip/enum/enumScan.txt 2>/dev/null | head -n 20 || echo "No SMB info found")
EOF
fi
if [ $scan_level -ge 3 ]; then
    # Add vulnerability section if level 3+
    cat << EOF >> ./Results/$ip/summary.txt
POTENTIAL VULNERABILITIES:
$(grep -B1 -A1 "VULNERABLE" ./Results/$ip/web/nikto.txt 2>/dev/null || echo "None detected by Nikto")
INTERESTING DIRECTORIES:
$(for port in $http_ports 2>/dev/null; do
    if [ -f "./Results/$ip/web/gobuster_${port}.txt" ]; then
        echo "* Port $port:"
        grep -E "(Status:|Size:)" ./Results/$ip/web/gobuster_${port}.txt 2>/dev/null | grep -v "Status: 404" | head -n 10
    fi
done)
EOF
    # Add DNS information if level 3+
    cat << EOF >> ./Results/$ip/summary.txt
DNS INFORMATION:
$(grep -E "Name|Address" ./Results/$ip/dns/dnsrecon.txt 2>/dev/null | head -n 20 || echo "No DNS info found")
EOF
fi
if [ $scan_level -ge 4 ]; then
    # Add additional detailed information for level 4
    cat << EOF >> ./Results/$ip/summary.txt
SSL/TLS CONFIGURATION:
$(grep -E "Accepted|Rejected|Vulnerable" ./Results/$ip/ssl/sslyze.txt 2>/dev/null | head -n 15 || echo "No SSL/TLS info found")
POSSIBLE USER ACCOUNTS:
$(grep -E "exists|found|valid" ./Results/$ip/enum/smtp_enum.txt 2>/dev/null | head -n 10 || echo "No user accounts found")
SNMP INFORMATION:
$(cat ./Results/$ip/enum/snmp.txt 2>/dev/null | head -n 10 || echo "No SNMP info found")
CMS DETECTION:
$(for port in $http_ports 2>/dev/null; do
    if [ -f "./Results/$ip/web/cmsmap_${port}.txt" ]; then
        echo "* Port $port:"
        grep -E "CMS|Plugin|Theme|Version" ./Results/$ip/web/cmsmap_${port}.txt 2>/dev/null | head -n 5
    fi
done)
WEBDAV TESTING:
$(grep -E "SUCCEED|FAIL|OPEN|PUT|DELETE" ./Results/$ip/web/webdav_*.txt 2>/dev/null | head -n 10 || echo "No WebDAV info found")
EOF
fi
# Add recommendations section
cat << EOF >> ./Results/$ip/summary.txt
=================================================
RECOMMENDATIONS:
$(if grep -q "open.*22/tcp" ./Results/$ip/nmap/nmapScan.txt 2>/dev/null; then
    echo "* SSH found: Try SSH brute forcing with hydra or check for known vulnerabilities"
fi)
$(if grep -q "open.*80/tcp\|open.*443/tcp\|open.*8080/tcp" ./Results/$ip/nmap/nmapScan.txt 2>/dev/null; then
    echo "* Web services found: Check for default credentials, SQLi, XSS, file inclusion vulnerabilities"
fi)
$(if grep -q "open.*139/tcp\|open.*445/tcp" ./Results/$ip/nmap/nmapScan.txt 2>/dev/null; then
    echo "* SMB/Samba found: Check for EternalBlue (MS17-010) and other SMB vulnerabilities"
fi)
$(if grep -q "open.*21/tcp" ./Results/$ip/nmap/nmapScan.txt 2>/dev/null; then
    echo "* FTP found: Try anonymous login and brute force"
fi)
$(if grep -q "WordPress" ./Results/$ip/web/whatweb.txt 2>/dev/null; then
    echo "* WordPress found: Check for vulnerable plugins and themes with wpscan"
fi)
EOF

echo -e "${GREEN}[+] Summary report created at ./Results/$ip/summary.txt${NC}"
