#!/bin/bash

directory="$(pwd)/Orders"
directory2="$(pwd)/Daily_Bills"
directory3="$(pwd)/Monthly_Bills"

delete() {
    local dir="$1"
    if [ -d "$dir" ]; then
        find "$dir" -type f -name "*.pdf" -mtime +7 -exec rm {} \;
        echo "Deleted files from $dir"
    else
        echo "Directory $dir does not exist. Skipping."
    fi
}

# Main execution
delete "$directory"
delete "$directory2"
delete "$directory3"
