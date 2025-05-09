# JellyScan

<div align="center">
  <img src="https://img.shields.io/badge/CTF-Reconnaissance-blue" alt="CTF Tool">
  <img src="https://img.shields.io/badge/Shell-Bash-green" alt="Bash">
</div>

## 🔍 Overview

JellyScan is a comprehensive CTF reconnaissance tool designed to automate the enumeration process for security enthusiasts, penetration testers, and CTF participants. It performs systematic scanning of target systems across various security levels, collecting valuable information about open ports, services, vulnerabilities, and potential attack vectors.

## ✨ Features

- **Multi-level Scanning**: Choose from 4 different scanning levels with increasing depth and thoroughness
- **Comprehensive Port Scanning**: Utilizes nmap to identify open ports and services
- **Web Server Enumeration**: Identifies and analyzes web servers using tools like WhatWeb, Nikto, and Gobuster
- **Service-specific Enumeration**: Specialized scanning for SMB, FTP, SMTP, DNS, and other services
- **SSL/TLS Configuration Analysis**: Assess SSL/TLS security configurations
- **CMS Detection**: Identifies content management systems on web servers
- **Organized Results**: Creates well-structured reports with findings and recommendations
- **Colorized Output**: Easy-to-read terminal output with color-coded status indicators

## 🚀 Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/jellyscan.git

# Change to the jellyscan directory
cd jellyscan

# Make the script executable
chmod +x jellyscan.sh
```

## 📋 Requirements

JellyScan requires the following tools to be installed:
- nmap
- gobuster
- nikto
- whatweb
- enum4linux
- smbclient
- dnsrecon

You can install most requirements on Debian-based systems with:

```bash
apt-get install nmap gobuster nikto whatweb enum4linux smbclient dnsrecon sslyze hydra
```

## 🔧 Usage

```bash
./jellyscan.sh [options] <target IP>
```

### Options:

- `-l, --level <1-4>`: Set scan level (default: 2)
  - Level 1: Basic port scanning
  - Level 2: Basic + web server and SMB enumeration
  - Level 3: Level 2 + vulnerability scanning and directory brute forcing
  - Level 4: Level 3 + comprehensive service enumeration and advanced testing

- `-h, --help`: Display help information

## 📊 Output

JellyScan creates a structured directory at `./Results/<IP>` containing:
- `summary.txt`: A comprehensive summary of all findings
- `nmap/`: Results from nmap scans
- `web/`: Web server analysis results
- `enum/`: Service enumeration results
- `dns/`: DNS reconnaissance results
- `ssl/`: SSL/TLS configuration analysis

## 📝 Example Summary Output

```
=================================================
      CTF SCAN SUMMARY REPORT FOR 192.168.1.100
=================================================
Generated on: Fri May 9 12:00:00 EDT 2025
Scan Level: 3
Elapsed Time: 00:15:23

OPEN PORTS & SERVICES:
22/tcp   open  ssh
80/tcp   open  http
445/tcp  open  microsoft-ds

WEB SERVERS:
* Port 80: Apache/2.4.41 (Ubuntu) Title: Company Intranet

SMB/SAMBA INFO:
Domain: WORKGROUP
OS: Unix
Server: Samba 4.9.5-Debian

POTENTIAL VULNERABILITIES:
Cookie PHPSESSID created without the httponly flag
...

RECOMMENDATIONS:
* SSH found: Try SSH brute forcing with hydra or check for known vulnerabilities
* Web services found: Check for default credentials, SQLi, XSS, file inclusion vulnerabilities
* SMB/Samba found: Check for EternalBlue (MS17-010) and other SMB vulnerabilities
```

## ⚠️ Disclaimer

JellyScan is designed for use in authorized security testing and Capture The Flag competitions only. Do not use this tool against systems without explicit permission. The developer assumes no liability for misuse of this software.

## 🙏 Acknowledgements

- Special thanks to the creators of the various tools utilized by JellyScan
- Inspired by numerous CTF competitions and security challenges

---

<div align="center">
  <sub>Built with ❤️ for the security community</sub>
</div>
