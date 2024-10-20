#!/bin/bash

# directory paths
PROJECT_LOG_DIR="logs"

# file names
VALGRIND_REPORT="$PROJECT_LOG_DIR/valgrind_report"

# Check the argument passed
PROJECT_EXECUTABLE="$1"

# Create directories for Valgrind report
mkdir -p "$PROJECT_LOG_DIR"

# Run Valgrind
valgrind --tool=memcheck \
         --leak-check=full \
         --show-leak-kinds=all \
         --time-stamp=yes \
         --track-origins=yes \
         --show-error-list=yes \
         "$PROJECT_EXECUTABLE" \
         2>&1 | tee "$VALGRIND_REPORT"