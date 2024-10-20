#!/bin/bash

# Function to clear a folder but keep the folder itself
clear_folder() {
# specify local variable 'folder' as the first argument passed to the function
  local folder=$1
  if [ -d "$folder" ]; then
    echo "Clearing contents of $folder..."
# remove all files, hidden files and directories in the specified folder
    rm -rf "$folder"/*
    rm -rf "$folder"/.[!.]*
    echo "$folder cleared!"
  else
    echo "$folder does not exist"
  fi
}

# Clear build directory
clear_folder "build"

# Clear bin directory
clear_folder "bin"

# Clear .cache directory
clear_folder ".cache"

# Clear cppcheck directory
clear_folder "cppcheck"

# Clear report directory
clear_folder "logs"

# Optionally, clear any additional folders here
echo "All folders cleaned!"
