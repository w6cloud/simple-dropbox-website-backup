#!/bin/bash

##########################################
#
# INIT
#
##########################################

# Source configuration file
. config.sh

# Create backup dir
mkdir -p $BACKUPS_PATH

##########################################
#
# TASKS
#
##########################################

#---------------------
# DATABASE DUMP
#--------------------- 

# Database dump path
DUMP_PATH=$BACKUPS_PATH/bdd.sql.gz

# Export DB dump
args=(--host=$DB_HOST
      --port=$DB_PORT
      --user=$DB_USER
      --skip-lock-tables
      --single-transaction
      --add-drop-table
      --add-locks
      --create-options
      --set-charset
      --extended-insert
      --quick
      $DB_NAME)
MYSQL_PWD="$DB_PASSWORD" mysqldump "${args[@]}" | gzip > $DUMP_PATH

#---------------------
# WEBSITE ARCHIVE
#--------------------- 

# Archive path
ARCHIVE_PATH=$BACKUPS_PATH/backup.tar

# Remove old archive if it exists (to avoid error messages on next command)
if [ -f "$ARCHIVE_PATH" ]; then
    rm -f $ARCHIVE_PATH
fi

# Create archive with website files and database dump
args=(--create
      --directory /
      --file $ARCHIVE_PATH
      $WEBSITE_PATH
      $DUMP_PATH)
tar "${args[@]}"

#---------------------
# UPLOAD DROPBOX
#--------------------- 

# DropBox uploader executable path
DU_EXECUTABLE="./dropbox_uploader.sh"

# DropBox uploader configuration file path
DU_CONF_PATH="./.dropbox_uploader"

# On first execution install DropBox downloader
if [ ! -f "$DU_EXECUTABLE" ]; then
    # Download
    curl "https://raw.githubusercontent.com/andreafabrizi/Dropbox-Uploader/master/dropbox_uploader.sh" -o dropbox_uploader.sh
    chmod +x dropbox_uploader.sh
    # Create configuration file
    echo "OAUTH_ACCESS_TOKEN=$DROPBOX_TOKEN" > $DU_CONF_PATH
fi

# Upload the archive
$DU_EXECUTABLE -f $DU_CONF_PATH -q upload $ARCHIVE_PATH $DROPBOX_BACKUP_PATH

##########################################
#
# FINALIZE
#
##########################################

# Cleanup

rm -Rf $BACKUPS_PATH
