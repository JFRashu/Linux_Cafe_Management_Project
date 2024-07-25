#!/bin/bash
# Set A Category.sh
# Database credentials
clear
DB_USER="root"
DB_PASS=""
DB_NAME="os project"

# User input for new product details
# read -p "Enter product code: " product_code
read -p "Enter category name: " Ctgr_Name

# Full path to the MySQL client executable in XAMPP
MYSQL_EXECUTABLE="/mnt/d/xampp/mysql/bin/mysql.exe"  # Adjust the path as per your XAMPP installation

# Construct the SQL query to insert the new product into the food table
query="INSERT INTO \`category\` (\`Ctgr_Title\`) VALUES ('$Ctgr_Name');"

# Execute the SQL query using the MySQL client
result=$("$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -e "$query" 2>&1)

# Check the result of the MySQL command
if [ $? -eq 0 ]; then
    echo "New Category added successfully."
else
    echo "Error: $result"
fi
