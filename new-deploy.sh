#!/bin/bash

# Define the paths to your CyberChef directories
CYBERCHEF_SRC_DIR="../CyberChef"
CYBERCHEF_BUILD_PATH="../CyberChef/build/prod"

# 1. Update and Build CyberChef
if [ -d "$CYBERCHEF_SRC_DIR" ]; then
    echo "Navigating to $CYBERCHEF_SRC_DIR to update and build CyberChef..."
    
    # Save the current directory path so we can return here later
    ORIGINAL_DIR=$(pwd)
    
    # Navigate to the CyberChef folder
    cd "$CYBERCHEF_SRC_DIR" || { echo "Failed to enter $CYBERCHEF_SRC_DIR"; exit 1; }
    
    # Fetch and pull the latest changes
    echo "Pulling latest changes from Git..."
    git fetch || { echo "Git fetch failed. Please check your connection or permissions."; exit 1; }
    git pull || { echo "Git pull failed. You may have merge conflicts to resolve."; exit 1; }
    
    echo "Building CyberChef using npm..."
    
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    nvm install 20
    nvm use 20
    
    # Remove old node_modules to prevent conflicts after a pull
    rm -rf node_modules
    
    npm install
    npx grunt prod
    
    # Return to the original directory
    cd "$ORIGINAL_DIR" || { echo "Failed to return to original directory"; exit 1; }
    echo "Build process complete."
else
    echo "Error: CyberChef source directory '$CYBERCHEF_SRC_DIR' does not exist."
    exit 1
fi

# 2. Delete everything in the current directory except .git, .gitignore, README.md, and this script
echo "Cleaning current directory..."
find . -mindepth 1 -maxdepth 1 \
  ! -name '.git' \
  ! -name '.gitignore' \
  ! -name 'README.md' \
  ! -name "$(basename "$0")" \
  -exec rm -rf {} +
echo "Cleanup complete."

# 3. Copy the contents of the CyberChef build folder into the current directory
if [ -d "$CYBERCHEF_BUILD_PATH" ]; then
    echo "Copying build files from $CYBERCHEF_BUILD_PATH..."
    
    # Copy all standard files and directories
    cp -r "$CYBERCHEF_BUILD_PATH"/* ./
    
    # Copy hidden files, suppressing errors if there are none
    cp -r "$CYBERCHEF_BUILD_PATH"/.[!.]* ./ 2>/dev/null || true
    
    echo "Update complete! The build files have been copied."
else
    echo "Error: Directory '$CYBERCHEF_BUILD_PATH' does not exist."
    exit 1
fi
