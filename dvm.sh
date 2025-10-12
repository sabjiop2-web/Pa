#!/bin/bash

# Script: disk_check.sh
# Purpose: Display total and free disk space of VPS

# Get total and available disk space from root filesystem
total_disk=$(df -h / | awk 'NR==2 {print $2}')
used_disk=$(df -h / | awk 'NR==2 {print $3}')
free_disk=$(df -h / | awk 'NR==2 {print $4}')
used_percent=$(df -h / | awk 'NR==2 {print $5}')

# Display results
echo "--------------------------------------"
echo "     VPS Disk Usage Information"
echo "--------------------------------------"
echo "Total Disk Space : $total_disk"
echo "Used Disk Space  : $used_disk"
echo "Free Disk Space  : $free_disk"
echo "Usage Percentage : $used_percent"
echo "--------------------------------------"
