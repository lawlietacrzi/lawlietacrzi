#!/bin/bash

# Define Colors
GREEN="\e[32m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

# Clear Screen
clear

# Display Banner
echo -e "${CYAN}"
figlet -c -f slant "Hash Identifier"
echo -e "${RESET}"

# Disclaimer
echo -e "${RED}=============================================${RESET}"
echo -e "${RED}⚠️  Use this tool for ethical purposes only! ⚠️${RESET}"
echo -e "${RED}Unauthorized use may have legal consequences.${RESET}"
echo -e "${RED}=============================================${RESET}"

# Function to identify hash
identify_hash() {
    hash=$1
    length=${#hash}

    case $length in
        32)
            echo -e "${GREEN}[+] Possible Hash Type: MD5${RESET}"
            ;;
        40)
            echo -e "${GREEN}[+] Possible Hash Type: SHA-1${RESET}"
            ;;
        56)
            echo -e "${GREEN}[+] Possible Hash Type: SHA-224${RESET}"
            ;;
        64)
            echo -e "${GREEN}[+] Possible Hash Type: SHA-256${RESET}"
            ;;
        96)
            echo -e "${GREEN}[+] Possible Hash Type: SHA-384${RESET}"
            ;;
        128)
            echo -e "${GREEN}[+] Possible Hash Type: SHA-512${RESET}"
            ;;
        *)
            echo -e "${RED}[-] Hash type not recognized!${RESET}"
            ;;
    esac
}

# User Input
echo -e "${CYAN}Enter the hash to identify:${RESET}"
read -r input_hash

# Identify Hash
identify_hash "$input_hash"

