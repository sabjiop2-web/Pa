#!/bin/bash
# ────────────────────────────────────────────────
#  NEXUS VPS DASHBOARD
#  Advanced System Monitoring Interface
# ────────────────────────────────────────────────

# Color palette - Professional gradient scheme
DARK_BLUE="\e[38;5;24m"
BLUE="\e[38;5;39m"
LIGHT_BLUE="\e[38;5;51m"
TEAL="\e[38;5;43m"
GREEN="\e[38;5;48m"
YELLOW="\e[38;5;227m"
ORANGE="\e[38;5;215m"
RED="\e[38;5;203m"
PURPLE="\e[38;5;129m"
MAGENTA="\e[38;5;207m"
GRAY="\e[38;5;245m"
LIGHT_GRAY="\e[38;5;252m"
WHITE="\e[38;5;255m"
BOLD="\e[1m"
RESET="\e[0m"

clear

# Professional ASCII Art Header
print_header() {
  echo -e "${DARK_BLUE}"
  echo -e "╔══════════════════════════════════════════════════════════════════════════════╗"
  echo -e "║                                                                              ║"
  echo -e "║  ${BOLD}${WHITE}╦╔═╔═╗╦╔═╦ ╦╔═╗╦  ╔═╗  ╦╔═╔═╗╦═╗╔═╗╔═╗╔═╗╦╔═╔═╗╦═╗${DARK_BLUE}                   ║"
  echo -e "║  ${BOLD}${WHITE}╠╩╗║╣ ╠╩╗║ ║╠═╝║  ║ ║  ╠╩╗║ ║╠╦╝╚═╗║ ║║ ║╠╩╗║╣ ╠╦╝${DARK_BLUE}                   ║"
  echo -e "║  ${BOLD}${WHITE}╩ ╩╚═╝╩ ╩╚═╝╩  ╩═╝╚═╝  ╩ ╩╚═╝╩╚═╚═╝╚═╝╚═╝╩ ╩╚═╝╩╚═${DARK_BLUE}                   ║"
  echo -e "║                                                                              ║"
  echo -e "║            ${BOLD}${LIGHT_BLUE}SYSTEM INTELLIGENCE PLATFORM • REAL-TIME ANALYTICS${DARK_BLUE}                 ║"
  echo -e "║                                                                              ║"
  echo -e "╚══════════════════════════════════════════════════════════════════════════════╝${RESET}"
  echo
}

# Animated progress divider
animated_divider() {
  local chars=("▰" "▱")
  echo -ne "${BLUE}${BOLD}┣"
  for i in {1..48}; do
    echo -ne "${TEAL}${chars[$((RANDOM % 2))]}"
    sleep 0.001
  done
  echo -e "${BLUE}┫${RESET}"
}

# Status indicator with color coding
status_indicator() {
  local value=$1
  local type=$2
  
  case $type in
    "cpu")
      if [[ $value -gt 80 ]]; then
        echo -e "${RED}▊${RESET}"
      elif [[ $value -gt 60 ]]; then
        echo -e "${ORANGE}▊${RESET}"
      else
        echo -e "${GREEN}▊${RESET}"
      fi
      ;;
    "memory")
      if [[ $value -gt 85 ]]; then
        echo -e "${RED}▊${RESET}"
      elif [[ $value -gt 70 ]]; then
        echo -e "${ORANGE}▊${RESET}"
      else
        echo -e "${GREEN}▊${RESET}"
      fi
      ;;
    "disk")
      if [[ $value -gt 90 ]]; then
        echo -e "${RED}▊${RESET}"
      elif [[ $value -gt 80 ]]; then
        echo -e "${ORANGE}▊${RESET}"
      else
        echo -e "${GREEN}▊${RESET}"
      fi
      ;;
  esac
}

# Progress bar function
progress_bar() {
  local value=$1
  local max=100
  local width=20
  local filled=$((value * width / max))
  local empty=$((width - filled))
  
  echo -ne "${BLUE}[${RESET}"
  for ((i=0; i<filled; i++)); do
    echo -ne "${GREEN}█${RESET}"
  done
  for ((i=0; i<empty; i++)); do
    echo -ne "${GRAY}░${RESET}"
  done
  echo -ne "${BLUE}]${RESET}"
}

# Get system information with enhanced formatting
get_system_info() {
  # OS and Kernel
  os_name=$(lsb_release -ds 2>/dev/null || grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"' 2>/dev/null || echo "Unknown OS")
  kernel_version=$(uname -r)
  architecture=$(uname -m)
  hostname=$(hostname 2>/dev/null || cat /etc/hostname 2>/dev/null || echo "unknown")
  
  # Time and Uptime
  current_time=$(date +"%Y-%m-%d %H:%M:%S")
  uptime_seconds=$(awk '{print int($1)}' /proc/uptime 2>/dev/null || echo "0")
  days=$((uptime_seconds/86400))
  hours=$(( (uptime_seconds%86400)/3600 ))
  minutes=$(( (uptime_seconds%3600)/60 ))
  if [ $days -gt 0 ]; then
    uptime_formatted="${days}d ${hours}h ${minutes}m"
  elif [ $hours -gt 0 ]; then
    uptime_formatted="${hours}h ${minutes}m"
  else
    uptime_formatted="${minutes}m"
  fi
  
  # Users and Load
  logged_users=$(who 2>/dev/null | wc -l || echo "0")
  load_avg=$(uptime 2>/dev/null | awk -F'load average:' '{print $2}' | xargs 2>/dev/null || echo "N/A")
}

# Get resource usage with percentages
get_resource_usage() {
  # Disk Info with percentage
  disk_info=$(df -h / 2>/dev/null | awk 'NR==2')
  disk_total=$(echo "$disk_info" | awk '{print $2}')
  disk_used=$(echo "$disk_info" | awk '{print $3}')
  disk_free=$(echo "$disk_info" | awk '{print $4}')
  disk_usep=$(echo "$disk_info" | awk '{print $5}' | sed 's/%//')
  
  # RAM Info with percentage
  ram_info=$(free 2>/dev/null | awk '/Mem:/')
  ram_total=$(echo "$ram_info" | awk '{printf "%.1fG", $2/1024/1024}')
  ram_used=$(echo "$ram_info" | awk '{printf "%.1fG", $3/1024/1024}')
  ram_free=$(echo "$ram_info" | awk '{printf "%.1fG", $4/1024/1024}')
  ram_percent=$(echo "$ram_info" | awk '{printf "%.0f", $3/$2*100}')
  
  # CPU Info
  cpu_model=$(awk -F: '/model name/ {print $2; exit}' /proc/cpuinfo 2>/dev/null | sed 's/^ //' | cut -c1-40 || echo "Unknown CPU")
  cpu_cores=$(nproc 2>/dev/null || grep -c ^processor /proc/cpuinfo 2>/dev/null || echo "1")
  cpu_percent=$(top -bn1 2>/dev/null | grep "Cpu(s)" | awk '{printf "%.0f", 100 - $8}' || echo "0")
}

# Get network information
get_network_info() {
  main_iface=$(ip route 2>/dev/null | grep default | awk '{print $5}' | head -1 || echo "unknown")
  public_ip=$(curl -s -4 ifconfig.me 2>/dev/null || curl -s -6 ifconfig.me 2>/dev/null || echo "Unavailable")
  local_ip=$(ip addr show $main_iface 2>/dev/null | grep 'inet ' | awk '{print $2}' | cut -d/ -f1 | head -1 || echo "Unknown")
}

# Display system overview
display_system_overview() {
  echo -e "${BOLD}${WHITE}📊 SYSTEM OVERVIEW${RESET}"
  animated_divider
  echo -e "  ${BLUE}🏠 ${WHITE}Hostname:     ${LIGHT_GRAY}$hostname${RESET}"
  echo -e "  ${BLUE}🖥️  ${WHITE}OS:           ${LIGHT_GRAY}$os_name${RESET}"
  echo -e "  ${BLUE}⚙️  ${WHITE}Kernel:       ${LIGHT_GRAY}$kernel_version${RESET}"
  echo -e "  ${BLUE}🏗️  ${WHITE}Architecture: ${LIGHT_GRAY}$architecture${RESET}"
  echo -e "  ${BLUE}🕐 ${WHITE}System Time:  ${LIGHT_GRAY}$current_time${RESET}"
  echo -e "  ${BLUE}⏱️  ${WHITE}Uptime:       ${LIGHT_GRAY}$uptime_formatted${RESET}"
  echo -e "  ${BLUE}👥 ${WHITE}Users:        ${LIGHT_GRAY}$logged_users connected${RESET}"
  echo -e "  ${BLUE}📈 ${WHITE}Load Avg:     ${LIGHT_GRAY}$load_avg${RESET}"
  animated_divider
}

# Display resource metrics
display_resource_metrics() {
  echo -e "${BOLD}${WHITE}📈 RESOURCE METRICS${RESET}"
  animated_divider
  
  # CPU Section
  echo -e "  ${ORANGE}⚡ CPU${RESET}"
  echo -e "    ${LIGHT_GRAY}$cpu_model${RESET}"
  echo -e "    Cores: ${GREEN}$cpu_cores${RESET} | Usage: $(progress_bar $cpu_percent) ${YELLOW}$cpu_percent%${RESET} $(status_indicator $cpu_percent "cpu")"
  
  # Memory Section
  echo -e "  ${PURPLE}💾 MEMORY${RESET}"
  echo -e "    Total: ${GREEN}$ram_total${RESET} | Used: ${RED}$ram_used${RESET} | Free: ${GREEN}$ram_free${RESET}"
  echo -e "    Usage: $(progress_bar $ram_percent) ${YELLOW}$ram_percent%${RESET} $(status_indicator $ram_percent "memory")"
  
  # Disk Section
  echo -e "  ${TEAL}💿 STORAGE${RESET}"
  echo -e "    Total: ${GREEN}$disk_total${RESET} | Used: ${RED}$disk_used${RESET} | Free: ${GREEN}$disk_free${RESET}"
  echo -e "    Usage: $(progress_bar $disk_usep) ${YELLOW}$disk_usep%${RESET} $(status_indicator $disk_usep "disk")"
  
  animated_divider
}

# Display network information
display_network_info() {
  echo -e "${BOLD}${WHITE}🌐 NETWORK STATUS${RESET}"
  animated_divider
  echo -e "  ${GREEN}🔗 Interface:   ${LIGHT_GRAY}$main_iface${RESET}"
  echo -e "  ${GREEN}🌍 Public IP:   ${LIGHT_GRAY}$public_ip${RESET}"
  echo -e "  ${GREEN}🏠 Local IP:    ${LIGHT_GRAY}$local_ip${RESET}"
  
  # Network activity (simplified)
  rx_bytes=$(cat /sys/class/net/$main_iface/statistics/rx_bytes 2>/dev/null || echo "0")
  tx_bytes=$(cat /sys/class/net/$main_iface/statistics/tx_bytes 2>/dev/null || echo "0")
  
  rx_mb=$(echo "scale=2; $rx_bytes/1024/1024" | bc 2>/dev/null || echo "0")
  tx_mb=$(echo "scale=2; $tx_bytes/1024/1024" | bc 2>/dev/null || echo "0")
  
  echo -e "  ${GREEN}📊 Data Usage:  ${LIGHT_GRAY}↓ ${CYAN}${rx_mb}MB${LIGHT_GRAY} ↑ ${MAGENTA}${tx_mb}MB${RESET}"
  animated_divider
}

# Display service status (simplified)
display_service_status() {
  echo -e "${BOLD}${WHITE}🛡️  SERVICE STATUS${RESET}"
  animated_divider
  
  # Check common services
  services=("sshd" "nginx" "apache2" "httpd" "mysql" "mariadb" "postgresql" "docker")
  
  for service in "${services[@]}"; do
    if systemctl is-active --quiet "$service" 2>/dev/null; then
      echo -e "  ${GREEN}✅ $service${RESET} ${LIGHT_GRAY}is running${RESET}"
    elif command -v $service >/dev/null 2>&1; then
      echo -e "  ${YELLOW}⚡ $service${RESET} ${LIGHT_GRAY}available but not running${RESET}"
    fi
  done
  animated_divider
}

# Main execution
main() {
  print_header
  get_system_info
  get_resource_usage
  get_network_info
  
  display_system_overview
  display_resource_metrics
  display_network_info
  display_service_status
  
  # Footer
  echo -e "${BOLD}${DARK_BLUE}╔══════════════════════════════════════════════════════════════════════════════╗${RESET}"
  echo -e "${BOLD}${DARK_BLUE}║${WHITE}                        System monitoring is active • $(date +%H:%M:%S)                      ${DARK_BLUE}║${RESET}"
  echo -e "${BOLD}${DARK_BLUE}╚══════════════════════════════════════════════════════════════════════════════╝${RESET}"
  echo
}

# Run the dashboard
main
