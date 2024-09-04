#!/bin/bash
# Set\ An\ Order.sh
# Database credentials
clear
DB_USER="root"
DB_PASS=""
DB_NAME="os project"

# Full path to the MySQL client executable in XAMPP
MYSQL_EXECUTABLE="/mnt/d/xampp/mysql/bin/mysql.exe"  # Adjust the path as per your XAMPP installation

# Function to display all food items with their details
display_food_items() {
    echo "Food Items Available:"
    # Query the database to retrieve all food items and their details
    food_items=$(echo "SELECT Food_Code, \`Food Name\`, Price FROM \`food items\`;" | "$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -N)
    # Display food items with their details
    echo "$food_items"
}
# Create Bill 
create_Bill() 
{   
    local order_code="$1"
    local total_bill="$2"
    local customer_name="$3"
    local order_time="$4"  
    query_total_orders="SELECT COUNT(*) AS total_orders FROM \`order\` WHERE DATE(\`time\`) = CURDATE();"

    total_orders=$(echo "$query_total_orders" | "$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -N 2>&1)
    if [ $? -ne 0 ]; then
        echo "Error executing SQL query: $total_orders"
        return 1
    fi

    while true; do
        # Prompt user for action
        echo "Options:"
        echo "1. Create Bill and print"
        echo "2. Exit"
        read -p "Enter your choice: " choice

        case $choice in 
            1)
                # Ensure the Orders directory exists
                directory="Orders"
                mkdir -p "$directory"

                # Construct the TXT file name with the correct format
                txt_file_name="${directory}/order_${order_code}.txt"

                # Construct the PDF file name with the correct format
                pdf_file_name="${directory}/order_${order_code}.pdf"

                # Perform the SQL query to retrieve bill details
                query="SELECT \`Food Name\`, Amounts, Price, Amounts * Price AS Cost
                        FROM \`food items\` AS f, \`included in\` AS i
                        WHERE f.Food_Code = i.Food_Code AND i.Order_Code = '$order_code';"

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
                    printf " %-20s %-5s %s\n" "Order No" ":" "$order_code"
                    printf " %-20s %-5s %-10s\n" "Customer Name" ":" "$customer_name"
                    printf " %-20s %-5s %-10s\n\n" "Order Time" ":" "$order_time"
                    printf " %s\n" "---------------------------Bill Details--------------------------"  
                    printf " %s\n" "-----------------------------------------------------------------"  
                    printf " | %-20s | %-10s | %-10s | %-12s |\n" "Food Name" "Amount" "Price" "Cost (Tk)" 
                    printf " %s\n" "-----------------------------------------------------------------"  

                    # Find maximum lengths of columns
                    max_food_name_length=20
                    max_amount_length=8
                    max_price_length=8
                    max_cost_length=8

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

 # Calculate total bill
                order_code=$(echo "SELECT MAX(Order_Code) FROM \`order\`;" | "$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -N)
                total_bill=0
                
                query2="SELECT sum(i.Amounts*f.Price) as \"\"
                        FROM \`food items\` AS f,\`included in\` as i
                        WHERE f.Food_Code=i.Food_Code AND i.Order_Code='$order_code';"
                result2=$("$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -e "$query2" 2>&1)

                 if [ $? -ne 0 ]; then
                    echo "Error updating total bill in the order table: $result2"
                    exit 1
                fi

                total_bill=$("$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -e "$query2" 2>&1);

                # Update the total bill in the "order" table
                query="UPDATE \`order\` SET Bill='$total_bill' WHERE Order_Code='$order_code';"
                result=$("$MYSQL_EXECUTABLE" -u "$DB_USER" "$DB_NAME" -e "$query" 2>&1)
                if [ $? -ne 0 ]; then
                    echo "Error updating total bill in the order table: $result"
                    exit 1
                fi
                
                echo "Order completed. Order Code is $order_code";
                printf "Total bill: %s\n" "$total_bill"

                create_Bill "$order_code" "$total_bill" "$customer_name" "$order_time"