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

# Change to build directory and run cmake
if [ -d "build" ]; then
    cd build
    echo -e "\nSwitched to $(pwd)" 
    echo -e "Perform a fresh configuration of the CMake build tree...\n"
    cmake --fresh ..
    echo -e "\nCMake reconfiguration complete, optionally consider running command 'CMake: Delete Cache and Reconfigure' for in depth reconfiguration.\n" 
else
  echo "Error: 'build' directory does not exist"
  exit 1
fi