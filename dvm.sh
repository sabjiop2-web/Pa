#!/bin/bash

# Script: system_info.sh
# Purpose: Display VPS system information (Disk, RAM, CPU, Uptime)

# Colors for better UI
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${CYAN}==============================================="
echo -e "         VPS SYSTEM INFORMATION REPORT"
echo -e "===============================================${RESET}"

# 🧮 Disk Information
total_disk=$(df -h / | awk 'NR==2 {print $2}')
used_disk=$(df -h / | awk 'NR==2 {print $3}')
free_disk=$(df -h / | awk 'NR==2 {print $4}')
used_percent=$(df -h / | awk 'NR==2 {print $5}')

echo -e "${YELLOW}📦 DISK USAGE:${RESET}"
echo -e "Total Disk Space : ${GREEN}$total_disk${RESET}"
echo -e "Used Disk Space  : ${GREEN}$used_disk${RESET}"
echo -e "Free Disk Space  : ${GREEN}$free_disk${RESET}"
echo -e "Usage Percentage : ${GREEN}$used_percent${RESET}"
echo

# 🧠 RAM Information
total_ram=$(free -h | awk '/Mem:/ {print $2}')
used_ram=$(free -h | awk '/Mem:/ {print $3}')
free_ram=$(free -h | awk '/Mem:/ {print $4}')
swap_total=$(free -h | awk '/Swap:/ {print $2}')
swap_used=$(free -h | awk '/Swap:/ {print $3}')

echo -e "${YELLOW}💾 MEMORY (RAM) USAGE:${RESET}"
echo -e "Total RAM  : ${GREEN}$total_ram${RESET}"
echo -e "Used RAM   : ${GREEN}$used_ram${RESET}"
echo -e "Free RAM   : ${GREEN}$free_ram${RESET}"
echo -e "Swap Used  : ${GREEN}$swap_used / $swap_total${RESET}"
echo

# ⚙️ CPU Information
cpu_model=$(awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo | sed 's/^ //')
cpu_cores=$(nproc)
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

echo -e "${YELLOW}🧩 CPU INFORMATION:${RESET}"
echo -e "CPU Model   : ${GREEN}$cpu_model${RESET}"
echo -e "CPU Cores   : ${GREEN}$cpu_cores${RESET}"
echo -e "CPU Usage   : ${GREEN}$cpu_usage${RESET}"
echo

# ⏱️ Uptime Information
uptime_formatted=$(uptime -p)
load_avg=$(uptime | awk -F'load average:' '{print $2}' | xargs)

echo -e "${YELLOW}⏰ SYSTEM UPTIME & LOAD:${RESET}"
echo -e "Uptime       : ${GREEN}$uptime_formatted${RESET}"
echo -e "Load Average : ${GREEN}$load_avg${RESET}"
echo

echo -e "${CYAN}==============================================="
echo -e "         END OF SYSTEM REPORT"
echo -e "===============================================${RESET}"
