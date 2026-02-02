#!/bin/bash

SRC="/home/ims/web-deploy"
DEST="/opt/ims/tomcat/webapps/ims"

WATCH_MODE=0

# Parse arguments
for arg in "$@"; do
    if [ "$arg" = "--watch" ]; then
        WATCH_MODE=1
    fi
    # Remove --watch from positional parameters
    if [ "$arg" != "--watch" ]; then
        ARGS+=("$arg")
    fi
done
set -- "${ARGS[@]}"

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

copy_all() {
    cp -r --update --no-preserve=ownership "$SRC/"* "$DEST/"
    echo "Files from $SRC copied to $DEST."
}

copy_one() {
    local relpath="$1"
    local srcfile="$SRC/$relpath"
    local destfile="$DEST/$relpath"
    if [ -d "$srcfile" ]; then
        mkdir -p "$destfile"
        echo "Directory $relpath created in destination."
    elif [ -f "$srcfile" ]; then
        mkdir -p "$(dirname "$destfile")"
        cp --update --no-preserve=ownership "$srcfile" "$destfile"
        echo "File $relpath copied to destination."
    fi
}

if [ "$WATCH_MODE" -eq 1 ]; then
    command -v inotifywait >/dev/null 2>&1 || { echo "inotifywait is required for --watch mode. Install inotify-tools."; exit 1; }
    echo "Watching $SRC for changes..."
    while inotifywait -r -e create -e modify -e moved_to "$SRC"; do
        # Get list of changed files/folders
        CHANGES=$(inotifywait -r -e create -e modify -e moved_to --format '%w%f' --quiet --timeout 1 "$SRC")
        if [ -z "$CHANGES" ]; then
            continue
        fi
        for changed in $CHANGES; do
            relpath="${changed#$SRC/}"
            copy_one "$relpath"
        done
    done
else
    copy_all
fi

