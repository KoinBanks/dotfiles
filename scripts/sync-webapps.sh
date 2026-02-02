#!/bin/bash

SRC="/home/ims/web-deploy"
DEST="/opt/ims/tomcat/webapps/ims"

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Root privileges are required. Re-running with sudo..."
    exec sudo "$0" "$@"
fi

# Ensure source exists
if [ ! -d "$SRC" ]; then
    echo "Source directory $SRC does not exist."
    exit 1
fi

# Ensure destination exists
if [ ! -d "$DEST" ]; then
    echo "Destination directory $DEST does not exist."
    exit 1
fi

# Copy files recursively, overwrite only files present in SRC
cp -r --update --no-preserve=ownership "$SRC/"* "$DEST/"

echo "Files from $SRC copied to $DEST."
