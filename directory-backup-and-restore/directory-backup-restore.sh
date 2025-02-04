#!/usr/bin/env bash

## Environment Variables
BACKUP_DIRECTORY="$HOME/Documents"
DESTINATION_DIRECTORY="$HOME/Backups"

# Ensure backup directory exists
mkdir -p "$DESTINATION_DIRECTORY"

## Backup Function
backup_directory() {
    read -r -p "Enter the directory to back up (default: $BACKUP_DIRECTORY): " user_backup_directory
    backup_source="${user_backup_directory:-$BACKUP_DIRECTORY}"
    timestamp=$(date +"%Y-%m-%d")
    backup_filename="$DESTINATION_DIRECTORY/backup-$timestamp.tar.gz"

    echo "Backing up $backup_source to $backup_filename..."
    tar -czf "$backup_filename" "$backup_source"
    echo "Backup complete!"
}

## List Backups Function
get_backups() {
    echo "Available backups:"
    ls "$DESTINATION_DIRECTORY"
}

## Restore Function
restore_backup() {
    get_backups
    local restore_choice
    read -r -p "Enter the filename of the backup to restore: " restore_choice

    if [[ ! -f "$DESTINATION_DIRECTORY/$restore_choice" ]]; then
        echo "Error: Backup file does not exist!"
        return
    fi

    # Create a temporary restore directory
    restore_temp_dir="$HOME/RestoreTemp"
    mkdir -p "$restore_temp_dir"

    echo "Extracting to $restore_temp_dir..."
    tar -xzf "$DESTINATION_DIRECTORY/$restore_choice" -C "$restore_temp_dir"
    echo "Restore complete! Files are in $restore_temp_dir"
}

## Run Program and get user input
while true; do
    echo "Please select an option:"
    echo "1. Backup a directory"
    echo "2. List backups"
    echo "3. Restore a backup"

    read -r -p "-> " MENU_CHOICE

    case $MENU_CHOICE in 
        1)
            backup_directory
            exit 0
            ;;
        2)
            get_backups
            exit 0
            ;;
        3)
            restore_backup
            exit 0
            ;;
        *)
            echo "Invalid choice, please choose option 1, 2 or 3."
            exit 1
            ;;
    esac
done

