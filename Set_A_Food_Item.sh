#!/bin/bash
# Set_A_Food_Item.sh
# Database credentials
clear
DB_USER="root"
DB_PASS=""
DB_NAME="os project"

# Full path to the MySQL client executable in XAMPP
MYSQL_EXECUTABLE="/mnt/d/xampp/mysql/bin/mysql.exe"  # Adjust the path as per your XAMPP installation

# Declare arrays to store category titles and codes
declare -a category_titles
declare -a category_codes

# Function to display all food items with their details and categories
display_food_items() {
    echo "Food Items Available:"
    # Query the database to retrieve all food items and their details
    food_items=$(echo "SELECT c.Ctgr_Title, f.\`Food Name\`, f.Price, f.Food_Code 
                       FROM \`food items\` f
                       JOIN category c ON f.Category_Code = c.Ctgr_Code;" | "$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -N)
    
    # Display food items with their details and categories
    IFS=$'\n' read -ra food_item_array <<< "$food_items"
    for food_item in "${food_item_array[@]}"; do
        IFS=$'\t' read -r category_title food_name price food_code <<< "$food_item"
        echo "Category: $category_title | Food Name: $food_name | Price: $price | Code: $food_code"
    done
}

# Function to display food categories and prompt user to select one
select_category() {
    # Query the database for food categories (title and code)
    categories=$(echo "SELECT Ctgr_Title, Ctgr_Code FROM category;" | "$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -N)
    
    # Convert the result into an array
    IFS=$'\n' read -r -d '' -a category_array <<< "$categories"
    
    # Display menu of categories
    echo "Select a category for the new food item:"
    for index in "${!category_array[@]}"; do
        # Extract category title and code
        IFS=$'\t' read -r title code <<< "${category_array[index]}"
        # Trim any leading or trailing whitespace
        title=$(echo "$title" | tr -d '[:space:]')
        code=$(echo "$code" | tr -d '[:space:]')
        echo "$((index+1)). $title"
        # Store title and code in arrays
        category_titles+=("$title")
        category_codes+=("$code")
    done

    while true; do
        # Prompt user to choose a category
        read -p "Enter the number of the category: " category_number
        
        # Validate user input
        if [[ $category_number =~ ^[0-9]+$ && $category_number -ge 1 && $category_number -le ${#category_array[@]} ]]; then
            selected_index=$((category_number-1))
            selected_title="${category_titles[$selected_index]}"
            selected_code="${category_codes[$selected_index]}"
            echo "Selected category: $selected_title (Code: $selected_code)"
            break
        else
            echo "Invalid input. Please enter a valid category number."
        fi
    done
}

# Function to take input for new food item details and insert into database
take_new_food_item() {
    # User input for new product details
    read -p "Enter product name: " product_name
    read -p "Enter product price: " product_price
    
    # Construct the SQL query to insert the new product into the food table
    query="INSERT INTO \`food items\` (Category_Code, \`Food Name\`, Price) VALUES ('$selected_code', '$product_name', '$product_price');"
    
    # Execute the SQL query using the MySQL client
    result=$("$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -e "$query" 2>&1)
    
    # Check the result of the MySQL command
    if [ $? -eq 0 ]; then
        echo "New product added successfully."
        # Display the updated list of food items
        display_food_items
    else
        echo "Error: $result"
    fi
}

# Main script
display_food_items
select_category
take_new_food_item