directory="$(pwd)/Orders"
directory2="$(pwd)/Daily_Bills"
directory3="$(pwd)/Monthly_Bills"

delete(){
    find "$directory" -type f -name "*.pdf" -mtime +7 -exec rm {} \;
    find "$directory2" -type f -name "*.pdf" -mtime +7 -exec rm {} \;
    find "$directory3" -type f -name "*.pdf" -mtime +7 -exec rm {} \;
}

delete
