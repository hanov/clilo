#!/bin/bash

set -e

PROJECT_NAME="clilo"
BUILD_DIR="build"
INSTALL_DIR="/usr/local/bin"

echo "Installing $PROJECT_NAME..."

if [ ! -d "$BUILD_DIR" ]; then
    echo "Build directory not found. Please run ./build.sh first."
    exit 1
fi

BINARY="$BUILD_DIR/$PROJECT_NAME"

if [ ! -f "$BINARY" ]; then
    echo "Binary not found: $BINARY"
    echo "Please run ./build.sh first."
    exit 1
fi

echo "Installing $BINARY to $INSTALL_DIR/$PROJECT_NAME..."

sudo cp "$BINARY" "$INSTALL_DIR/$PROJECT_NAME"
sudo chmod +x "$INSTALL_DIR/$PROJECT_NAME"

echo "Installation completed successfully!"
echo "You can now use the '$PROJECT_NAME' command from anywhere."
echo ""
echo "Example usage:"
echo "  $PROJECT_NAME \"list files created from two days ago to 4 days ago\""