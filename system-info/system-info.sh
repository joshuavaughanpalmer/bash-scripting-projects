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
if [[ "$OS" == "macOS" ]]; then
    echo "Uptime: $(uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}')"
else
    echo "Uptime: $(uptime -p)"
fi

# Operating System
if [[ "$OS" == "macOS" ]]; then
    echo "Operating System: $(sw_vers -productName) $(sw_vers -productVersion)"
else
    echo "Operating System: $(uname -s) $(uname -r)"
fi

# Memory Usage
if [[ "$OS" == "macOS" ]]; then
    # Get total memory in GB
    MEM_TOTAL=$(sysctl -n hw.memsize)
    MEM_TOTAL_GB=$((MEM_TOTAL / 1024 / 1024 / 1024))

    # Get used memory from vm_stat
    MEM_USED_PAGES=$(vm_stat | awk '/Pages active/ {print $3}' | sed 's/\.//')
    MEM_USED_BYTES=$((MEM_USED_PAGES * 4096))
    MEM_USED_GB=$((MEM_USED_BYTES / 1024 / 1024 / 1024))

    echo "Memory Usage: ${MEM_USED_GB}GB / ${MEM_TOTAL_GB}GB"
else
    # Linux: Use free -h wth formatting
    echo "Memory Usage: $(free -h | awk 'NR==2 {print $3 "/" $2}')"
fi

# Disk Usage
if [[ "$OS" == "macOS" ]]; then
    DISK_TOTAL=$(df -H / | awk 'NR==2 {print $2}') # Total space
    DISK_USED=$(df -H / | awk 'NR==2 {print $3}') # Used space
else
    DISK_TOTAL=$(df -h --si / | awk 'NR==2') # Linux alternative
    DISK_USED=$(df -h --si / | awk 'NR==2') # Linux alternative
fi

echo "Disk Usage: ${DISK_USED} used / ${DISK_TOTAL} total"

# No. of active processes running
if [[ "$OS" == "macOS" ]]; then
    PROCESS_COUNT=$(ps -e | wc -l)
else
    PROCESS_COUNT=$(ps aux --no-heading | wc -l)
fi

echo "Processes Running: $PROCESS_COUNT"

# Display system IP address
if [[ "$OS" == "macOS" ]]; then
    IP_ADDRESS=$(ifconfig | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | head -n 1)
else
    IP_ADDRESS=$(ip -4 addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d'/' -f1 | head -n 1)
fi

echo "IP Address: $IP_ADDRESS"