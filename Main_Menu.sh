#!/bin/bash
# Main_Menu.sh
clear
while true; do
    # Display menu options
    clear
    echo "Main Menu:"
    echo "1. Set an order"
    echo "2. Set a new category"
    echo "3. Set a new food item"
    echo "4. Calculate total bill for today"
    echo "5. Calculate total bill for current month"
    echo "6. Delete Order PDF"
    echo "7. Exit"

    # Read user choice
    read -p "Enter your choice: " choice

    # Perform action based on user choice
    case $choice in
        1)
            # Call Set An Order.sh
            ./Set\ An\ Order.sh
            ;;
        2)
            # Call Set a Category.sh
            ./Set_A_Category.sh
            ;;
        3)
            # Call Set A Food Items.sh
            ./Set_A_Food_Item.sh
            ;;
        4)
            # Call create Total bill.sh
            ./create\ Total\ bill.sh
            ;;
        5)
            # Call create Current Month bill.sh
            ./create\ Current\ Month\ bill.sh
            ;;
        6)
           ./delete_pdf.sh
            ;;
        7)
            echo "Exiting program."
            clear
            exit 
            ;;
        *)
            echo "Invalid choice. Please enter a number between 1 and 7."
            ;;
    esac
done
