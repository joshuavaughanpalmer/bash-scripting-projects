#!/bin/bash

# Detect OS
OS=$(uname -s)
if [[ "$OS" != "Darwin" && "$OS" != "Linux" ]]; then
    echo "Error: This script only supports macOS and Linux."
    exit 1
fi

# System Info Report
echo "============================"
echo "🔷 System Information Report"
echo "============================"
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"

# Uptime Handling
echo "Uptime: $(uptime -p 2>/dev/null || uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}')"

# Operating System
if [[ "$OS" == "Darwin" ]]; then
    OS_NAME="$(sw_vers -productName) $(sw_vers -productVersion)"
else
    OS_NAME="$(uname -s) $(uname -r)"
fi

echo "Operating System: $OS_NAME"


# Memory Usage
if [[ "$OS" == "Darwin" ]]; then
    MEM_TOTAL_GB=$(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 ))
    MEM_USED_GB=$(( $(vm_stat | awk '/Pages active/ {print $3}' | sed 's/\.//') * 4096 / 1024 / 1024 / 1024 ))
    echo "Memory Usage: ${MEM_USED_GB}GB / ${MEM_TOTAL_GB}GB"
else
    echo "Memory Usage: $(free -h | awk 'NR==2 {print $3 "/" $2}')"
fi

# Disk Usage
echo "Disk Usage: $(df -H / | awk 'NR==2 {print $3 " used / " $2 " total"}' 2>/dev/null || df -h --si / | awk 'NR==2 {print $3 " used / " $2 " total"}')"

# No. of active processes running
echo "Processes Running: $(ps -e | wc -l 2>/dev/null || ps aux --no-heading | wc -l)"

# Display system IP address
echo "IP Address: $(ifconfig 2>/dev/null | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | head -n 1 || ip -4 addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d'/' -f1 | head -n 1)"