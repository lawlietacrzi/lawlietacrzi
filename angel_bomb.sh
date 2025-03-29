#!/bin/bash

# Banner Name: Angel Bomb
# Purpose: Display an enhanced, professional banner in Termux
# Version: 2.0

# Function to display the enhanced Angel Bomb banner
display_banner() {
    local width=70  # Wider for a grander look
    local name="ANGEL BOMB"
    local version="v2.0"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    # Clear screen for a fresh start
    clear

    # Top border with corner accents
    echo "╔$(printf '%*s' $((width-2)) | tr ' ' '═')╗"
    echo "║$(printf '%*s' $((width-2)))║"

    # Title and version
    echo "║$(printf '%*s' $(( (width-24)/2 )))"ANGEL BOMB - $version"$(printf '%*s' $(( (width-24)/2-2 )))║"
    echo "║$(printf '%*s' $((width-2)))║"

    # Banner text with enhanced styling
    if command -v toilet &> /dev/null; then
        # Use toilet with a metallic filter for a premium look
        toilet -f smblock --filter metal "$name" | sed "s/^/║$(printf '%*s' $(( (width-40)/2 )))║/" | sed "s/$/$(printf '%*s' $(( (width-40)/2-2 )))║/"
    elif command -v figlet &> /dev/null; then
        # Fallback to figlet with a bold font
        figlet -f big "$name" | sed "s/^/║$(printf '%*s' $(( (width-40)/2 )))║/" | sed "s/$/$(printf '%*s' $(( (width-40)/2-2 )))║/"
    else
        # Plain text fallback with emphasis
        echo "║$(printf '%*s' $(( (width-${#name})/2 )))"$name"$(printf '%*s' $(( (width-${#name})/2-2 )))║"
    fi

    # Add spacing and timestamp
    echo "║$(printf '%*s' $((width-2)))║"
    echo "║$(printf '%*s' $(( (width-22)/2-2 )))"Generated: $timestamp"$(printf '%*s' $(( (width-22)/2-1 )))║"
    echo "║$(printf '%*s' $((width-2)))║"

    # Bottom border with corner accents
    echo "╚$(printf '%*s' $((width-2)) | tr ' ' '═')╝"
}

# Function to install dependencies
install_deps() {
    echo "Checking dependencies..."
    for tool in toilet figlet lolcat; do
        if ! command -v "$tool" &> /dev/null; then
            echo "$tool not found. Installing..."
            pkg install -y "$tool" &> /dev/null
            if [ $? -eq 0 ]; then
                echo "$tool installed successfully!"
            else
                echo "Failed to install $tool. Proceeding without it."
            fi
        fi
    done
}

# Simple animation effect (if lolcat is available)
animate_banner() {
    if command -v lolcat &> /dev/null; then
        for i in {1..3}; do
            clear
            display_banner | lolcat -f -a -s 50 -d 1
            sleep 0.5
        done
    else
        display_banner
    fi
}

# Main execution
echo "Initializing Angel Bomb Banner..."
echo "----------------------------------"

# Install dependencies
install_deps

# Display the banner with animation if possible
echo "Displaying enhanced banner..."
if command -v lolcat &> /dev/null; then
    animate_banner
    echo "Banner displayed with animation!" | lolcat -f
else
    display_banner
    echo "Banner displayed in plain text. Install 'lolcat' for colors and animation: pkg install lolcat"
fi

echo "Thank you for using Angel Bomb v2.0!"

# Tool Name: Angel Bomb
# Purpose: Stress test a website (for educational use with permission o

# Function to install dependencies
install_deps() {
    echo "Checking and installing dependencies..."
    for pkg in curl; do
        if ! command -v "$pkg" &> /dev/null; then
            echo "Installing $pkg..."
            pkg install -y "$pkg" || { echo "Failed to install $pkg"; exit 1; }
        fi
    done
    echo "Dependencies installed!"
}

# Function to perform the stress test
stress_test() {
    local url="$1"
    local requests="$2"
    local delay="$3"
    local count=0

    # Validate URL
    if [[ ! "$url" =~ ^https?:// ]]; then
        echo "Invalid URL format. Please include http:// or https://"
        return 1
    fi

    echo "Starting stress test on $url..."
    echo "Total requests: $requests | Delay between requests: $delay seconds"
    echo "Note: Use this tool only on servers you own or have permission to test!"

    while [ $count -lt "$requests" ]; do
        ((count++))
        echo -n "Sending request #$count... "
        response=$(curl -s -o /dev/null -w "%{http_code}" "$url" --max-time 5)
        if [ "$response" -eq 200 ]; then
            echo "Success (HTTP $response)"
        else
            echo "Failed (HTTP $response)"
        fi
        sleep "$delay"
    done

    echo "Stress test completed!"
}

# Main execution
clear
echo "Welcome to Angel Bomb - Website Stress Tester"
echo "----------------------------------------"
echo "WARNING: Use this tool responsibly and legally!"

# Display banner
if command -v lolcat &> /dev/null; then
    display_banner | lolcat -f
else
    display_banner
fi

# Install dependencies
install_deps

# Prompt for user input
echo -n "Enter the target URL (e.g., https://example.com): "
read -r url
echo -n "Enter the number of requests (e.g., 10): "
read -r requests
echo -n "Enter delay between requests in seconds (e.g., 1): "
read -r delay

# Validate input
if ! [[ "$requests" =~ ^[0-9]+$ ]] || [ "$requests" -le 0 ]; then
    echo "Error: Number of requests must be a positive integer."
    exit 1
fi
if ! [[ "$delay" =~ ^[0-9]*\.?[0-9]+$ ]] || [ "$(echo "$delay < 0" | bc)" -eq 1 ]; then
    echo "Error: Delay must be a non-negative number."
    exit 1
fi

# Run the stress test
stress_test "$url" "$requests" "$delay"

# Final message
echo -e "\nTest finished!"
if command -v lolcat &> /dev/null; then
    echo "Thanks for using Angel Bomb responsibly!" | lolcat -f
else
    echo "Thanks for using Angel Bomb responsibly!"
fi	

