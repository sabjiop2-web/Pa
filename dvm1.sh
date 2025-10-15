⁴#!/bin/bash
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

