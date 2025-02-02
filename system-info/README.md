# System Info Script

A Bash script that retrieves and displays essential system information such as uptime, memory usage, disk usage and IP address. The script supports both macOS and Linux and logs its output to a file.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Example Output](#example-output)
- [Future Tasks](#future-tasks)

## Installation

### Prerequisites
- macOS or Linux
- Bash 4.0+
- `df`, `free`, `ps`, `awk`, `uptime` and `grep` must be available

### Download & Setup
1. Clone the repository:
    ```Bash
    git clone https://github.com/joshuavaughanpalmer/bash-scripting-projects.git
    cd bash-scripting-projects/system-information
    ````
2. Make the script executable:
    ```Bash
    chmod +x system-info.sh
    ````
## Usage
1. To execute the script, run:
    ```Bash
    ./system-info.sh
    ````
    The script collects system details and logs the output to system-info.log while displaying the same information in the terminal.
    
2. To view the log file: 
    ```Bash
    cat system-info.log
    ````

## Features
- 🖥️ Detects and displays system information
- 🕒 Reports uptime in a human-readable format
- 🧠 Retrieves memory usage details
- 💾 Displays disk usage statistics
- 🔢 Shows the number of running processes
- 🌍 Retrieves the system's IP address
- 📜 Logs output to system-info.log
- ✅ Supports macOS and Linux

## Example Output
```Bash
==============================
🔷 System Information Report 🔷
==============================
Hostname: my-computer
Current User: josh
Uptime: 2 hours, 10 minutes
Operating System: macOS 12.3
Memory Usage: 3.2GB / 16GB
Disk Usage: 50GB used / 512GB total
Processes Running: 175
IP Address: 192.168.1.42
````

## Future Tasks
1. Add colour to the output
2. Detail more system information
3. Re-format the output into a different (tabular?) view.
4. Test further on Linux.