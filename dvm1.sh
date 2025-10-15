#!/bin/bash
# ───────────────────────────────────────────────────────────────────────────────────────
#  NEXUS VPS DASHBOARD
#  Advanced System Intelligence & Performance Monitoring
# ───────────────────────────────────────────────────────────────────────────────────────

# Color palette - Cyberpunk gradient scheme
CYBER_BLACK="\e[38;5;232m"
DEEP_BLUE="\e[38;5;20m"
NEON_BLUE="\e[38;5;27m"
ELECTRIC_BLUE="\e[38;5;81m"
CYAN="\e[38;5;51m"
NEON_GREEN="\e[38;5;46m"
MATRIX_GREEN="\e[38;5;82m"
NEON_YELLOW="\e[38;5;226m"
NEON_ORANGE="\e[38;5;208m"
NEON_RED="\e[38;5;196m"
NEON_PURPLE="\e[38;5;93m"
NEON_MAGENTA="\e[38;5;201m"
NEON_PINK="\e[38;5;199m"
HACKER_GRAY="\e[38;5;240m"
TERMINAL_WHITE="\e[38;5;255m"
BOLD="\e[1m"
RESET="\e[0m"

clear

# Cyberpunk ASCII Art Header with unique design
print_header() {
  echo -e "${DEEP_BLUE}"
  echo -e "╔═══════════════════════════════════════════════════════════════════════════════════╗"
  echo -e "║  ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${DEEP_BLUE}  ║"
  echo -e "║  ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${DEEP_BLUE}  ║"
  echo -e "║  ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${NEON_BLUE} ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄ ▄▄▄▄▄ ${NEON_PURPLE} ▄▄▄▄▄ ▄   ▄ ▄▄▄▄▄ ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${DEEP_BLUE}  ║"
  echo -e "║  ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${NEON_BLUE} █   █ █   █ █     █   █   █ ${NEON_PURPLE}   █   ██  █ █     ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${DEEP_BLUE}  ║"
  echo -e "║  ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${NEON_BLUE} █▀▀▀▀ █▀▀▀█ █▀▀▀▀ █   █   █ ${NEON_PURPLE}   █   █ █ █ █▀▀▀▀ ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${DEEP_BLUE}  ║"
  echo -e "║  ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${NEON_BLUE} █     █   █ █     █   █   █ ${NEON_PURPLE}   █   █  ██ █     ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${DEEP_BLUE}  ║"
  echo -e "║  ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${NEON_BLUE} █     █   █ █▄▄▄▄ █▄▄ █▄▄▄█ ${NEON_PURPLE}   █   █   █ █▄▄▄▄ ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓${DEEP_BLUE}  ║"
  echo -e "║  ${CYBER_BLACK}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${DEEP_BLUE}  ║"
  echo -e "║                                                                               ║"
  echo -e "║         ${BOLD}${ELECTRIC_BLUE}⟠ QUANTUM SYSTEM INTELLIGENCE • REAL-TIME TELEMETRY PLATFORM ⟠${DEEP_BLUE}            ║"
  echo -e "║                                                                               ║"
  echo -e "║${NEON_GREEN}    ███████████████████████████████████████████████████████████████████████${DEEP_BLUE}    ║"
  echo -e "╚═══════════════════════════════════════════════════════════════════════════════════╝"
  echo -e "${RESET}"
}

# Call the function
print_header
