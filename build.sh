#!/bin/bash

set -e

PROJECT_NAME="clilo"
BUILD_DIR="build"
DIST_DIR="dist"

echo "Building $PROJECT_NAME standalone binary for macOS..."

echo "Installing Python dependencies..."
pip3 install -r requirements.txt

echo "Cleaning previous build artifacts..."
rm -rf build/ dist/ *.spec

echo "Creating standalone binary with PyInstaller..."
pyinstaller --onefile --name $PROJECT_NAME clilo.py

echo "Organizing build artifacts..."
mkdir -p $BUILD_DIR

if [ -f "$DIST_DIR/$PROJECT_NAME" ]; then
    cp "$DIST_DIR/$PROJECT_NAME" "$BUILD_DIR/$PROJECT_NAME"
    echo "Build completed successfully!"
    echo "Standalone binary created: $BUILD_DIR/$PROJECT_NAME"
    echo "Binary size: $(du -h $BUILD_DIR/$PROJECT_NAME | cut -f1)"
else
    echo "Error: Binary not found in $DIST_DIR/$PROJECT_NAME"
    exit 1
fi

echo ""
echo "Cleaning up build artifacts..."
#rm -rf build/ dist/ *.spec