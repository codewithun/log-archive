#!/bin/bash

# ==========================================
# Log Archive Tool
# ==========================================

set -o pipefail

ARCHIVE_DIR="./archive"
LOG_FILE="$ARCHIVE_DIR/archive.log"

# ------------------------------------------
# Check Arguments
# ------------------------------------------

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log-directory>"
    echo "Example: $0 /var/log"
    exit 1
fi

LOG_DIR="$1"

# ------------------------------------------
# Validate Directory
# ------------------------------------------

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

if [ ! -r "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' is not readable."
    exit 1
fi

# ------------------------------------------
# Create Archive Directory
# ------------------------------------------

mkdir -p "$ARCHIVE_DIR"

# ------------------------------------------
# Generate Timestamp
# ------------------------------------------

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_NAME"

# ------------------------------------------
# Create Archive
# ------------------------------------------

echo "Creating archive..."

tar -czf "$ARCHIVE_PATH" \
    -C "$(dirname "$LOG_DIR")" \
    "$(basename "$LOG_DIR")"

if [ $? -ne 0 ]; then
    echo "Error: Failed to create archive."
    exit 1
fi

# ------------------------------------------
# Log Archive Information
# ------------------------------------------

ARCHIVE_TIME=$(date +"%Y-%m-%d %H:%M:%S")

echo "[$ARCHIVE_TIME] Archived '$LOG_DIR' -> '$ARCHIVE_PATH'" >> "$LOG_FILE"

# ------------------------------------------
# Display Result
# ------------------------------------------

echo
echo "Archive created successfully!"
echo
echo "Source      : $LOG_DIR"
echo "Archive     : $ARCHIVE_PATH"
echo "Archived at : $ARCHIVE_TIME"