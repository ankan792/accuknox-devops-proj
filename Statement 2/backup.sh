# Objective 2
#!/bin/bash


LOG_FILE="$HOME/backup_logfile.log"
PRIVATE_KEY="$HOME/.ssh/id_rsa"

check_log_file() {
    if [ -e "$LOG_FILE" ]; then
        echo "Starting backup: $(date)" >> $LOG_FILE
    else
        touch $LOG_FILE
        echo "Log file created: $(date)" >> $LOG_FILE
        echo "Starting backup: $(date)" >> $LOG_FILE
    fi
}

perform_backup() {   
    check_log_file 
    read -p "Enter Source Directory to backup: " SOURCE_DIR
    read -p "Enter Remote User name: " REMOTE_USER
    read -p "Enter Remote Host IP or name: " REMOTE_HOST
    read -p "Enter location to private key for the remote server(Defaults to $PRIVATE_KEY): " PRIVATE_KEY
    DEFAULT_REMOTE_DIR="/home/$REMOTE_USER"
    read -p "Enter Remote directory to store backup(Defaults to $DEFAULT_REMOTE_DIR): " REMOTE_DIR
    REMOTE_DIR=${REMOTE_DIR:-$DEFAULT_REMOTE_DIR}

    BACKUP_FILE="backup-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
    tar -czvf "$BACKUP_FILE" "$SOURCE_DIR"

    scp -i "$PRIVATE_KEY" $BACKUP_FILE $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR/$BACKUP_FILE
    if [ $? -eq 0 ]; then
        echo "Backup completed successfully: $(date)" >> $LOG_FILE
        echo "Backup completed successfully."
    else
        echo "Backup failed: $(date)" >> $LOG_FILE
        echo "Backup failed."
    fi
}

main() {
    perform_backup
}

main