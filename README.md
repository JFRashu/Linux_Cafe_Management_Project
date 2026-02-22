# Linux Cafe Management Project
# A Command-Line Interface System for Efficient Cafe Operations

📄 **[View Complete Project Manual (PDF)](Project_Manual.pdf)** - Detailed documentation with screenshots and workflows

## Table of Contents
- [Course Information](#course-information)
- [Team Members](#team-members)
- [Documentation](#documentation)
- [Project Overview](#project-overview)
- [Key Features](#key-features)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Usage Guide](#usage-guide)
- [Troubleshooting](#troubleshooting)
- [Acknowledgements](#acknowledgements)

## Course Information
- **Course:** Operating System (Sessional)
- **Course Code:** CSE-336
- **Department:** Computer Science & Engineering, Chittagong University of Engineering & Technology

## Team Members
- Shougata Paul 
- Abid Al Hossain
- Arupa Barua 
- Md. Tasnimur Rahman 
- Jannatul Farzana Rashumoni 

## Project Overview
This Cafe Management System is an integrated shell script-based project designed to manage various aspects of a cafe's operations. It provides functionalities for managing orders, categories, food items, and generating bills. The system utilizes a MySQL database for data storage and retrieval, making it a robust solution for small to medium-sized cafes.

## Documentation

For comprehensive documentation including detailed workflows, screenshots, and system architecture, please refer to:

📘 **[Project Manual PDF](Project_Manual.pdf)** - Complete guide with:
- Detailed installation instructions
- Step-by-step usage workflows with screenshots
- Database structure and setup
- Troubleshooting guide
- System flowcharts and diagrams
- Example outputs and bills

## Key Features
- **Order Management:** Create and process customer orders with itemized billing
- **Category Management:** Add and organize food categories
- **Food Item Management:** Add new menu items with pricing
- **Daily Bill Calculation:** Generate comprehensive daily sales reports
- **Monthly Bill Calculation:** Track monthly revenue and order statistics
- **PDF Bill Generation:** Automatic conversion of bills to professional PDF format
- **Automatic Storage Management:** Delete old PDF files (older than 7 days) to optimize storage

## Technologies Used
- Bash shell scripting
- MySQL database
- XAMPP (for MySQL and Apache)
- wkhtmltopdf (for PDF generation)
- dos2unix (for script file conversion)

## Prerequisites
- Bash shell
- MySQL database
- XAMPP (for MySQL and Apache)
- wkhtmltopdf (for PDF generation)
- All Shell Script files should be made executable using "dos2unix"

## Installation

### Step 1: Install XAMPP
Install XAMPP on your system to provide MySQL and Apache services.

### Step 2: Install wkhtmltopdf
Install wkhtmltopdf and ensure it's added to your system's PATH.

### Step 3: Download Project Files
Clone or download the project files to your local machine.

### Step 4: Database Setup
1. Open phpMyAdmin through XAMPP
2. Create a new database named **"os_project"**
3. Import the `os_project.sql` file into this database

The database includes the following tables:
- **category:** Stores food categories
- **food_items:** Stores individual food items
- **included_in:** Links orders with food items
- **order:** Stores order information

## Project Structure

```
cafe-management-system/
├── Main_Menu.sh                    # Main interface script
├── Set An Order.sh                 # Order creation handler
├── Set_A_Category.sh               # Category addition script
├── Set_A_Food_Item.sh              # Food item addition script
├── create Current Month bill.sh    # Monthly bill generator
├── create Total bill.sh            # Daily bill generator
├── delete_pdf.sh                   # Storage management script
├── os_project.sql                  # Database structure file
├── Orders/                         # Individual order PDFs
├── Daily_Bills/                    # Daily sales reports
└── Monthly_Bills/                  # Monthly sales reports
```

## Features and Functionality

### Comprehensive Management System
The Cafe Management System offers a user-friendly experience designed to streamline cafe operations from the moment the user launches the main script. The system stands ready to assist with a wide array of management tasks, ensuring efficient handling of everything from customer orders to financial reporting.

### Intuitive Interface
Upon startup, users are welcomed by a clear main menu that prioritizes clarity and ease of use, allowing even novice users to navigate the system with confidence and efficiency.

### Flexible Workflow
The system's flexibility shines through in its ability to seamlessly transition between tasks. After completing one operation, users are gracefully returned to the main menu, allowing for a fluid workflow that can encompass multiple management tasks in a single session.

### Professional Billing
All bills are automatically generated in professional PDF format using wkhtmltopdf, ensuring that customer receipts and financial reports are presentation-ready.

## Troubleshooting

### Critical: XAMPP MySQL Executable Path

One of the most critical steps for this project to function correctly is ensuring the proper path to the MySQL executable is set.

**In all scripts that interact with the database, you'll find:**
```bash
DB_USER="root"
DB_PASS=""
DB_NAME="os_project"

# Full path to the MySQL client executable in XAMPP
MYSQL_EXECUTABLE="/mnt/d/xampp/mysql/bin/mysql.exe"
```

**Common issues and solutions:**
- **Incorrect path:** Verify the exact location of mysql.exe on your system
- **Different operating systems:** The path format may differ between Windows, macOS, and Linux

**To fix:**
1. Locate the mysql.exe file in your XAMPP installation directory
2. Update the MYSQL_EXECUTABLE variable in all relevant scripts with the correct path
3. Use forward slashes (/) even on Windows systems for consistency

### XAMPP Services Issues

**Before running any scripts, ensure:**
- Both Apache and MySQL services are started in the XAMPP Control Panel
- Both services show a green status indicator

**Common errors:**
- Scripts failing to connect to the database
- "Connection refused" errors

**To fix:**
1. Open XAMPP Control Panel
2. Start both Apache and MySQL services
3. Verify green status indicators before running scripts

### PDF Generation Issues

**Common problems:**
- PDF files not being created
- wkhtmltopdf command not found

**Solutions:**
- Verify wkhtmltopdf is properly installed on your system
- Check if the wkhtmltopdf executable is in your system's PATH
- Ensure you have write permissions in the directories where PDFs are being saved

### Database-Related Issues

**Common problems:**
- Connection failures
- Table not found errors
- SQL syntax errors

**Solutions:**
- Verify the database name, user, and password are correctly set in all scripts
- Ensure the "os_project" database exists and contains all necessary tables
- Check for any SQL syntax errors if you've modified database queries
- Verify that the imported SQL file created all required tables

## Conclusion

The Cafe Management System provides a comprehensive solution for managing cafe operations with an intuitive interface for order management, menu customization, and financial reporting. The system's ability to generate PDF bills and manage storage automatically enhances its utility for day-to-day cafe management.

This project demonstrates the practical application of shell scripting, database management, and system integration in creating a functional business solution. It serves as an excellent example of how command-line tools can be leveraged to create a user-friendly management system.

The modular nature of the project allows for easy expansion and customization to meet specific cafe needs, making it adaptable for various business scenarios.

**For detailed visual documentation, system flowcharts, and screenshots of the system in action, please refer to the [Project Manual PDF](Project_Manual.pdf).**

## Acknowledgements

We would like to thank our course instructors:
- **MD. Shafiul Alam Forhad**, Assistant Professor, CSE, CUET
- **Hasan Murad**, Assistant Professor, CSE, CUET

for their guidance and support throughout this project.

## License

This project was developed as part of the Operating System (Sessional) course at Chittagong University of Engineering & Technology.

---

## Additional Resources

- 📄 **[Complete Project Manual (PDF)](Project_Manual.pdf)** - Includes detailed workflows, screenshots, and troubleshooting
- 🔗 **GitHub Repository:** https://github.com/JFRashu/Linux_Cafe_Management_Project

**For issues or questions, please contact any of the team members listed above.**
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/JFRashu/Linux_Cafe_Management_Project)
