#!/bin/bash
# Set_A_Category.sh
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

# Function to display current food categories
display_categories() {
    # Query the database for food categories (title and code)
    categories=$(echo "SELECT Ctgr_Title, Ctgr_Code FROM category;" | "$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -N)
    
    # Convert the result into an array
    IFS=$'\n' read -r -d '' -a category_array <<< "$categories"
    
    # Display current categories
    echo "Current Categories:"
    for index in "${!category_array[@]}"; do
        # Extract category title and code
        IFS=$'\t' read -r title code <<< "${category_array[index]}"
        # Trim any leading or trailing whitespace
        title=$(echo "$title" | tr -d '[:space:]')
        code=$(echo "$code" | tr -d '[:space:]')
        echo "$((index+1)). $title (Code: $code)"
        # Store title and code in arrays
        category_titles+=("$title")
        category_codes+=("$code")
    done
}

echo "Current Food Category"
display_categories

# User input for new category name
read -p "Enter new category name: " new_category_name

# Construct the SQL query to insert the new category into the category table
query="INSERT INTO \`category\` (\`Ctgr_Title\`) VALUES ('$new_category_name');"

# Execute the SQL query using the MySQL client
result=$("$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -e "$query" 2>&1)

# Check the result of the MySQL command
if [ $? -eq 0 ]; then
    echo "New Category added successfully."
    
    # Display the updated category list
    echo ""
    display_categories
    
    echo ""
    read -p "Press Enter to exit the program..." -r
else
    echo "Error: $result"
fi