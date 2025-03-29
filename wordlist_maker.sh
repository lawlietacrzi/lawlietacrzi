#!/bin/bash

# Define colors for the banner and output
CYAN=$(tput setaf 6)    # Cyan for the banner
GREEN=$(tput setaf 2)   # Green for success messages
WHITE=$(tput setaf 7)   # White for prompts
RED=$(tput setaf 1)     # Red for errors
RESET=$(tput sgr0)      # Reset colors

# Clear the terminal screen
clear

# Check if figlet is installed for the banner
if ! command -v figlet &> /dev/null; then
    echo "figlet is not installed. Please install it to generate the banner."
    echo "On Debian/Ubuntu: sudo apt-get install figlet"
    echo "On Fedora: sudo dnf install figlet"
    echo "On macOS: brew install figlet"
    exit 1
fi

# Display the banner
echo "${WHITE}For the best experience, ensure your terminal is set to a dark theme.${RESET}"
echo ""
echo "${WHITE}========================================${RESET}"
echo "${CYAN}"
figlet -f slant "WORDLIST MAKER"
echo "${RESET}"
echo "${WHITE}========================================${RESET}"
SUBTITLE="CUSTOM WORDLIST GENERATOR"
SUBTITLE_LENGTH=${#SUBTITLE}
PADDING=$(( (80 - SUBTITLE_LENGTH) / 2 ))
printf "%${PADDING}s" " "
echo "${GREEN}${SUBTITLE}${RESET}"
echo "${WHITE}----------------------------------------${RESET}"
echo ""

# Prompt for target information
echo "${WHITE}Enter target's details (leave blank if unknown):${RESET}"
read -p "First Name: " first_name
read -p "Last Name: " last_name
read -p "Birth Year (e.g., 1990): " birth_year
read -p "Phone Number (last 4 digits, e.g., 1234): " phone
read -p "Favorite Number (e.g., 123): " fav_number
read -p "Nickname: " nickname
echo ""

# Convert inputs to lowercase for consistency
first_name=$(echo "$first_name" | tr '[:upper:]' '[:lower:]')
last_name=$(echo "$last_name" | tr '[:upper:]' '[:lower:]')
nickname=$(echo "$nickname" | tr '[:upper:]' '[:lower:]')

# Output file for the wordlist
output_file="wordlist_$(date +%F_%H-%M-%S).txt"
echo "${WHITE}Generating wordlist...${RESET}"

# Initialize counter for combinations
count=0
max_combinations=1000

# Function to add a combination to the wordlist if within limit
add_combination() {
    if [ $count -lt $max_combinations ]; then
        echo "$1" >> "$output_file"
        ((count++))
    fi
}

# Create the output file and start generating combinations
> "$output_file"

# Common special characters and suffixes to append
special_chars=("!" "@" "#" "\$" "%" "^" "&" "*" "123" "321" "007" "69")
years=("$birth_year" "19${birth_year:2:2}" "20${birth_year:2:2}") # e.g., 1990, 90, 20

# Base words to combine (filter out empty inputs)
base_words=()
[ ! -z "$first_name" ] && base_words+=("$first_name")
[ ! -z "$last_name" ] && base_words+=("$last_name")
[ ! -z "$nickname" ] && base_words+=("$nickname")
[ ! -z "$birth_year" ] && base_words+=("$birth_year")
[ ! -z "$phone" ] && base_words+=("$phone")
[ ! -z "$fav_number" ] && base_words+=("$fav_number")

# Generate combinations
for word1 in "${base_words[@]}"; do
    # Single word
    add_combination "$word1"

    # Word with special characters
    for char in "${special_chars[@]}"; do
        add_combination "$word1$char"
        add_combination "${word1^}$char" # Capitalize first letter
    done

    # Word with years
    for year in "${years[@]}"; do
        add_combination "$word1$year"
        add_combination "${word1^}$year" # Capitalize first letter
    done

    # Combine with other words
    for word2 in "${base_words[@]}"; do
        if [ "$word1" != "$word2" ]; then
            add_combination "$word1$word2"
            add_combination "${word1^}${word2}"
            add_combination "$word1${word2^}"
            add_combination "${word1^}${word2^}"

            # Add special characters to combinations
            for char in "${special_chars[@]}"; do
                add_combination "$word1$word2$char"
                add_combination "${word1^}${word2}$char"
            done

            # Add years to combinations
            for year in "${years[@]}"; do
                add_combination "$word1$word2$year"
                add_combination "${word1^}${word2}$year"
            done
        fi
    done

    # Check if we've reached the maximum combinations
    if [ $count -ge $max_combinations ]; then
        break
    fi
done

# Display results
echo "${GREEN}Wordlist generated successfully!${RESET}"
echo "Total combinations: $count"
echo "Saved to: $output_file"
echo ""
echo "${WHITE}Sample of the wordlist:${RESET}"
head -n 10 "$output_file"
echo "..."
