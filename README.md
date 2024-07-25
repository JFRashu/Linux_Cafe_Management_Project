# Linux Cafe Management Project
# A Command-Line Interface System for Efficient Cafe Operations

## Course Information
- **Course:** Operating System (Sessional)
- **Course Code:** CSE-336
- **Department:** Computer Science & Engineering, Chittagong University of Engineering & Technology

## Team Members
- Shougata Paul (ID: 2004087)
- Abid Al Hossain (ID: 2004088)
- Arupa Barua (ID: 2004089)
- Jannatul Farzana Rashumoni (ID: 2004090)
- Md. Tasnimur Rahman (ID: 2004091)

## Project Overview
This Cafe Management System is a shell script-based project designed to manage various aspects of cafe operations. It provides functionalities for managing orders, categories, food items, and generating bills, utilizing a MySQL database for data storage and retrieval.

## Key Features
- Order management
- Category and food item addition
- Daily and monthly bill calculation
- PDF bill generation
- Automatic old bill deletion

## Technologies Used
- Bash shell scripting
- MySQL database
- XAMPP (for MySQL and Apache)
- wkhtmltopdf (for PDF generation)

## Prerequisites
- Bash shell
- MySQL database
- XAMPP (for MySQL and Apache)
- wkhtmltopdf (for PDF generation)

## Installation
1. Install XAMPP on your system.
2. Install wkhtmltopdf and ensure it's added to system's PATH.
3. Clone or download the project files to local machine.
4. Import the os_project.sql file into MySQL database using phpMyAdmin or MySQL command line.

## Project Structure
- Main_Menu.sh: The main script that provides the user interface.
- Set An Order.sh: Handles the process of creating new orders.
- Set_A_Category.sh: Allows adding new food categories.
- Set_A_Food_Item.sh: Enables adding new food items to the menu.
- create bill.sh: Generates bills for individual orders.
- create Current Month bill.sh: Generates a bill for the current month.
- create Total bill.sh: Generates a bill for the current day.
- delete_pdf.sh: Manages storage by deleting old PDF files.
- os_project.sql: SQL file containing the database structure.

## Usage Guide
Run ./Main_Menu.sh and follow the on-screen prompts to navigate through different functionalities.

## Future Enhancements
- Graphical user interface
- Integration with point-of-sale systems
- Advanced reporting features

## Acknowledgements
We would like to thank our course instructors:
- MD. Shafiul Alam Forhad, Assistant Professor, CSE, CUET
- Hasan Murad, Assistant Professor, CSE, CUET

for their guidance and support throughout this project.
