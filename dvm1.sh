#!/bin/bash
# ────────────────────────────────────────────────
#  ADVANCED VPS SYSTEM INFORMATION DASHBOARD
#  Author: ChatGPT (GPT-5)
# ────────────────────────────────────────────────

# Color palette
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
MAGENTA="\e[35m"
BOLD="\e[1m"
RESET="\e[0m"

clear

# Animated divider
divider() {
  echo -ne "${MAGENTA}"
  for i in {1..50}; do echo -n "─"; sleep 0.002; done
  echo -e "${RESET}"
}

# Detect OS info
os_name=$(lsb_release -ds 2>/dev/null || grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"' 2>/dev/null || echo "Unknown OS")
kernel_version=$(uname -r)
architecture=$(uname -m)
hostname=$(hostname 2>/dev/null || cat /etc/hostname 2>/dev/null || echo "unknown")
uptime_formatted=$(uptime -p 2>/dev/null || echo "uptime command not supported")
load_avg=$(uptime 2>/dev/null | awk -F'load average:' '{print $2}' | xargs 2>/dev/null || echo "N/A")
current_time=$(date +"%Y-%m-%d %H:%M:%S")
logged_users=$(who 2>/dev/null | wc -l || echo "0")
main_iface=$(ip route 2>/dev/null | grep default | awk '{print $5}' | head -1 || echo "unknown")
public_ip=$(curl -s -4 ifconfig.me 2>/dev/null || curl -s -6 ifconfig.me 2>/dev/null || echo "Unavailable")

# Disk Info
disk_total=$(df -h / 2>/dev/null | awk 'NR==2 {print $2}' || echo "N/A")
disk_used=$(df -h / 2>/dev/null | awk 'NR==2 {print $3}' || echo "N/A")
disk_free=$(df -h / 2>/dev/null | awk 'NR==2 {print $4}' || echo "N/A")
disk_usep=$(df -h / 2>/dev/null | awk 'NR==2 {print $5}' || echo "N/A")

# RAM Info
ram_total=$(free -h 2>/dev/null | awk '/Mem:/ {print $2}' || echo "N/A")
ram_used=$(free -h 2>/dev/null | awk '/Mem:/ {print $3}' || echo "N/A")
ram_free=$(free -h 2>/dev/null | awk '/Mem:/ {print $4}' || echo "N/A")

# CPU Info
cpu_model=$(awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo 2>/dev/null | sed 's/^ //' || echo "Unknown CPU")
cpu_cores=$(nproc 2>/dev/null || grep -c ^processor /proc/cpuinfo 2>/dev/null || echo "1")
cpu_usage=$(top -bn1 2>/dev/null | grep "Cpu(s)" | awk '{print 100 - $8"%"}' || echo "N/A")

# Network Speed (brief test using /proc/net/dev)
if command -v bc >/dev/null 2>&1; then
  iface_data_before=$(cat /proc/net/dev 2>/dev/null | grep "$main_iface" || echo "")
  sleep 1
  iface_data_after=$(cat /proc/net/dev 2>/dev/null | grep "$main_iface" || echo "")
  
  if [[ -n "$iface_data_before" && -n "$iface_data_after" ]]; then
    rx_before=$(echo $iface_data_before | awk '{print $2}')
    tx_before=$(echo $iface_data_before | awk '{print $10}')
    rx_after=$(echo $iface_data_after | awk '{print $2}')
    tx_after=$(echo $iface_data_after | awk '{print $10}')
    rx_speed=$(echo "scale=2; ($rx_after - $rx_before) / 1024" | bc 2>/dev/null || echo "0")
    tx_speed=$(echo "scale=2; ($tx_after - $tx_before) / 1024" | bc 2>/dev/null || echo "0")
  else
    rx_speed="N/A"
    tx_speed="N/A"
  fi
else
  rx_speed="bc not installed"
  tx_speed="bc not installed"
fi

# ────────────────────────────────────────────────
# OS LOGO (auto style)
# ────────────────────────────────────────────────
if [[ "$os_name" == *"Ubuntu"* ]]; then
  logo="${YELLOW}
  ██╗   ██╗██████╗ ██╗   ██╗████████╗██╗   ██╗
  ██║   ██║██╔══██╗██║   ██║╚══██╔══╝██║   ██║
  ██║   ██║██████╔╝██║   ██║   ██║   ██║   ██║
  ██║   ██║██╔══██╗██║   ██║   ██║   ██║   ██║
  ╚██████╔╝██████╔╝╚██████╔╝   ██║   ╚██████╔╝
   ╚═════╝ ╚═════╝  ╚═════╝    ╚═╝    ╚═════╝ 
  ${RESET}"
elif [[ "$os_name" == *"Debian"* ]]; then
  logo="${RED}
     _____      _      _             
    |  __ \    (_)    | |            
    | |  | | __ _  ___| | ___  _ __  
    | |  | |/ _\` |/ __| |/ _ \| '_ \ 
    | |__| | (_| | (__| | (_) | | | |
    |_____/ \__,_|\___|_|\___/|_| |_|
  ${RESET}"
else
  logo="${CYAN}
   ____  ____   _____ 
  |  _ \|  _ \ / ____|
  | |_) | |_) | (___  
  |  __/|  _ < \___ \ 
  | |   | |_) |____) |
  |_|   |____/|_____/ 
  ${RESET}"
fi

# ────────────────────────────────────────────────
# DISPLAY SECTION
# ────────────────────────────────────────────────
echo -e "$logo"
divider
echo -e "${BOLD}${CYAN}Hostname:      ${RESET}$hostname"
echo -e "${BOLD}${CYAN}OS:            ${RESET}$os_name"
echo -e "${BOLD}${CYAN}Kernel:        ${RESET}$kernel_version"
echo -e "${BOLD}${CYAN}Architecture:  ${RESET}$architecture"
echo -e "${BOLD}${CYAN}Time:          ${RESET}$current_time"
echo -e "${BOLD}${CYAN}Uptime:        ${RESET}$uptime_formatted"
echo -e "${BOLD}${CYAN}Users Online:  ${RESET}$logged_users"
divider

echo -e "${YELLOW}📦 DISK:${RESET}   Total: ${GREEN}$disk_total${RESET} | Used: ${RED}$disk_used${RESET} | Free: ${GREEN}$disk_free${RESET} | Usage: ${MAGENTA}$disk_usep${RESET}"
echo -e "${YELLOW}💾 RAM:${RESET}    Total: ${GREEN}$ram_total${RESET} | Used: ${RED}$ram_used${RESET} | Free: ${GREEN}$ram_free${RESET}"
echo -e "${YELLOW}🧩 CPU:${RESET}    ${cpu_model} (${cpu_cores} cores) | Usage: ${CYAN}$cpu_usage${RESET}"
divider

echo -e "${MAGENTA}🌐 NETWORK:${RESET}"
echo -e "Interface: ${GREEN}$main_iface${RESET} | IP: ${GREEN}$public_ip${RESET}"
echo -e "Speed: ↓ ${GREEN}${rx_speed} KB/s${RESET} ↑ ${YELLOW}${tx_speed} KB/s${RESET}"
divider

echo -e "${BOLD}${CYAN}Load Average:${RESET} $load_avg"
echo
