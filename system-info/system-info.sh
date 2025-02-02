#!/usr/bin/env bash
set -euo pipefail # Enable strict mode

# Function to detect the OS
OS=""
detect_os() {
    case "$(uname -s)" in
        Darwin) OS="macOS" ;;
        Linux) OS="Linux" ;;
        *) echo "Error: Unsupported OS." >&2; exit 1 ;;
    esac
}

# Function to get uptime
get_uptime() {
    if [[ "$OS" == "macOS" ]]; then
        uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}'
    else
        uptime -p
    fi
}

# Function to retrieve OS information
get_os_info() {
    if [[ "$OS" == "macOS" ]]; then
        echo "$(sw_vers -productName) $(sw_vers -productVersion)"
    else
        echo "$(uname -s) $(uname -r)"
    fi
}

# Function to get memory usage
get_memory_usage() {
    if [[ "$OS" == "macOS" ]]; then
        mem_total=$(sysctl -n hw.memsize)
        mem_total_gb=$((mem_total / 1024 / 1024 / 1024))
        mem_used_pages=$(vm_stat | awk '/Pages active/ {print $3}' | sed 's/\.//')
        mem_used_bytes=$((mem_used_pages * 4096))
        mem_used_gb=$((mem_used_bytes / 1024 / 1024 / 1024))
        echo "${mem_used_gb}GB / ${mem_total_gb}GB"
    else
        free -h | awk 'NR==2 {print $3 "/" $2}'
    fi
}

# Function to get disk usage
get_disk_usage() {
    df -h / | awk 'NR==2 {print $3 " used / " $2 " total"}'
}

# Function to get process count
get_process_count() {
    ps -e | wc -l
}

# Function to get IP address
get_ip_address() {
    if [[ "$OS" == "macOS" ]]; then
        ifconfig | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | head -n 1
    else
        ip -4 addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d'/' -f1 | head -n 1
    fi
}

# System Info Report
    display_system_info() {
    echo "=============================="
    echo "🔷 System Information Report 🔷"
    echo "=============================="
    echo "Hostname: $(hostname)"
    echo "Current User: $(whoami)"
    echo "Uptime: $(get_uptime)"
    echo "Operating System: $(get_os_info)"
    echo "Memory Usage: $(get_memory_usage)"
    echo "Disk Usage: $(get_disk_usage)"
    echo "Processes Running: $(get_process_count)"
    echo "IP Address: $(get_ip_address)"
}


# Main Execution
main() {
    # Log file setup
    LOG_FILE="system-info.log"
    exec > "$LOG_FILE" 2>&1 # Redirect output to the log file   
    
    detect_os # Set OS variable before logging starts

    display_system_info
}

# Call the main function to initiate execution
main