#!/bin/bash
# Set\ An\ Order.sh
# Database credentials

#!/bin/bash
source ./header.sh
display_header

DB_USER="root"
DB_PASS=""
DB_NAME="os project"

# Full path to the MySQL client executable in XAMPP
MYSQL_EXECUTABLE="/mnt/d/xampp/mysql/bin/mysql.exe"  # Adjust the path as per your XAMPP installation

create_Bill() {
    local order_code="$1"
    local total_bill=$(echo "SELECT 
                SUM(inc.\`Amounts\` * fi.\`Price\`) 
                FROM 
                    \`food items\` fi
                JOIN 
                    \`included in\` inc ON fi.\`Food_Code\` = inc.\`Food_code\`
                JOIN 
                    \`order\` o ON inc.\`Order_code\` = o.\`Order_code\`
                WHERE 
                    DATE(o.\`time\`) = CURRENT_DATE" | "$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -N)

    local total_orders=$(echo "SELECT COUNT(*) FROM \`order\` WHERE Date(\`Time\`)= CURRENT_DATE" | "$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -N)

    while true; do
        # Prompt user for action
        echo "Options:"
        echo "1. Create Bill and print"
        echo "2. Exit"
        read -p "Enter your choice: " choice

        case $choice in 
            1)
                # Define the directory for storing the bills
                directory="Daily_Bills"
                mkdir -p "$directory"  # Create the directory if it does not exist

                # Construct the TXT file name with the correct format
                txt_file_name="${directory}/Daily_Bill_${order_code}.txt"

                # Construct the PDF file name with the correct format
                pdf_file_name="${directory}/Daily_Bill_${order_code}.pdf"

                # Perform the SQL query to retrieve bill details
                query="SELECT 
                fi.\`Food name\`,
                SUM(inc.\`Amounts\`) AS \`Food amount\`,
                fi.\`Price\` AS \`price per item\`,
                SUM(inc.\`Amounts\` * fi.\`Price\`) AS \`cost\`
                FROM 
                    \`food items\` fi
                JOIN 
                    \`included in\` inc ON fi.\`Food_Code\` = inc.\`Food_code\`
                JOIN 
                    \`order\` o ON inc.\`Order_code\` = o.\`Order_code\`
                WHERE 
                    DATE(o.\`time\`) = CURRENT_DATE
                GROUP BY 
                    fi.\`Food name\`, fi.\`Price\`"

                # Execute the SQL query and handle errors
                bill_details=$(echo "$query" | "$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -N 2>&1)
                if [ $? -ne 0 ]; then
                    echo "Error executing SQL query: $bill_details"
                    return 1
                fi

                # Debugging: Print the retrieved bill details
                echo "Retrieved bill details:"
                echo "$bill_details"

                # Generate bill content with proper alignment in the TXT file
                {
                    printf " %-20s %-5s %-10s\n\n" "Bill Date" ":" "$(date +%Y-%m-%d)"
                    printf " %-20s %-5s %-10s\n\n" "Total Orders" ":" "$total_orders"
                    printf " %s\n" "---------------------------Bill Details--------------------------"
                    printf " %s\n" "-----------------------------------------------------------------"
                    printf " | %-20s | %-10s | %-10s | %-12s |\n" "Food Name" "Amount" "Price" "Cost (Tk)"
                    printf " %s\n" "-----------------------------------------------------------------"

                    # Find maximum lengths of columns
                    max_food_name_length=20
                    max_amount_length=8
                    max_price_length=8
                    max_cost_length=10

                    while read -r food_name amount price cost; do
                        # Update maximum lengths
                        (( ${#food_name} > max_food_name_length )) && max_food_name_length=${#food_name}
                        (( ${#amount} > max_amount_length )) && max_amount_length=${#amount}
                        (( ${#price} > max_price_length )) && max_price_length=${#price}
                        (( ${#cost} > max_cost_length )) && max_cost_length=${#cost}
                    done <<< "$bill_details"

                    while read -r food_name amount price cost; do
                        # Print with dynamically calculated width
                        printf "   %-*s |   %-*s |   %-*s |   %-*s \n" \
                        "$max_food_name_length" "$food_name" \
                        "$max_amount_length" "$amount" \
                        "$max_price_length" "$price" \
                        "$max_cost_length" "$cost"
                    done <<< "$bill_details"

                    printf " %s\n" "-----------------------------------------------------------------"
                    printf " %-50s  %.2f %-3s\n" "Total Bill: " "$total_bill" "Tk"
                    printf " %s\n" "-----------------------------------------------------------------"
                } > "$txt_file_name"

                # Convert the TXT file to PDF using wkhtmltopdf
                wkhtmltopdf "$txt_file_name" "$pdf_file_name"

                # Check if wkhtmltopdf was successful
                if [ $? -ne 0 ]; then
                    echo "Error converting TXT to PDF."
                    return 1
                fi
                
                # Delete the TXT file
                rm "$txt_file_name"
                clear
                echo "Your order bill is created and order code is $order_code" 
                # Prepare the PDF file for printing
                # You can use a command such as lp (Line Printer) to send the PDF file to the printer
                # lp "$pdf_file_name"
                return;;
            2)
                return;;
            *)
                echo "Invalid choice. Please enter 1 or 2.";;
        esac
    done
}


Date=$(date +"%Y-%m-%d")

create_Bill  "$Date"
