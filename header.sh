#!/bin/bash

display_header() {
    clear
    echo -e "\e[1;38;5;202m"  # Set text color to orange
    echo "========================================"
    echo "             SAART Brews"
    echo "========================================"
    echo -e "\e[1;38;5;94m    Welcome to Our Cozy Coffee Corner\e[0m"  # Cyan text
    echo -e "\e[0m"  # Reset text color
    echo ""
}

# Export the function so it can be used in other scripts
export -f display_header

# Call the function to display the header
display_header