#!/bin/bash

# Full path to the folder containing the website
WEBSITE_PATH="/absolute/path/to/website"

# Full path to a folder where backups will be stored 
# before being sent to Dropbox. If the upload fals, 
# you will still find your backup file in this folder
BACKUPS_PATH="/absolute/path/to/website"

# Database configuration
DB_HOST="localhost"
DB_PORT="3306"
DB_USER="user"
DB_PASSWORD="password"
DB_NAME="database_name"

# DropBox app token
DROPBOX_TOKEN=PDxApKuRW71km1CCqhMuabGmiU7u00MED8VEu71eW0fhdNm3ArH8GdiFETs9x9OS

# DropBox file path
DROPBOX_BACKUP_PATH=/backup.tar