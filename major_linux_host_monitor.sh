#INFO
#comprehensive bash script that monitors the five major issues (memory leaks, overloaded services, disk space exhaustion, high I/O wait, and system resource mismanagement) on a Debian system.
#This script continually checks the system and outputs the status. It also provides instructions to stop the script.

#script for monitoring
#1. Memory leaks: Uses free -h to show memory usage.
#2. System Load: Uses top to display the load and top processes.
#3. Disk Space: Uses df -h to monitor disk usage.
#4. I/O Wait: Uses iostat to check disk I/O performance.
#5. Swap usage: Uses swapon --show to display swap usage


#IMP- on How to
# follow README file for detail usesage

#!/bin/bash

# Check if script is run as root, otherwise inform the user
if [ "$(id -u)" -ne 0 ]; then
    echo "This script should be run as root for complete system monitoring."
    exit 1
fi

# Function to check memory usage and detect leaks
check_memory_leaks() {
    echo "Checking memory usage..."
    free -h | grep Mem
    echo ""
}

# Function to monitor system load and overloaded services
check_system_load() {
    echo "Checking system load and processes..."
    top -n 1 | head -20
    echo ""
}

# Function to monitor disk space
check_disk_space() {
    echo "Checking disk space usage..."
    df -h | grep -E 'Filesystem|/dev'
    echo ""
}

# Function to monitor high I/O wait
check_io_wait() {
    echo "Checking I/O wait..."
    iostat -x 1 2 | grep -A 6 'avg-cpu'
    echo ""
}

# Function to check swap and resource mismanagement
check_swap_usage() {
    echo "Checking swap usage..."
    swapon --show
    echo ""
}

# Display script instructions
echo "System Health Monitoring Script"
echo "Press [CTRL+C] to stop the monitoring."
echo "----------------------------------"
echo ""

# Continuous monitoring loop
while true; do
    check_memory_leaks
    check_system_load
    check_disk_space
    check_io_wait
    check_swap_usage
    sleep 5
done
