#!bin/bash

PROJECT_DIR="/workspace"
BUILD_DIR="$PROJECT_DIR/build"
EXTERNAL_DIR="$PROJECT_DIR/external"
TESTS_DIR="$PROJECT_DIR/tests"
REPORT_DST_DIR="$PROJECT_DIR/logs/coverage_report"
REPORT_SRC_DIR="$BUILD_DIR/lcov_output"
REPORT_FILE_NAME="$BUILD_DIR/coverage.info"

echo -e "\nRunning $0\n"

# Delete previous coverage reports
rm -rf "$REPORT_SRC_DIR"
rm -rf "$REPORT_DST_DIR"

# Delete previous coverage counters
lcov --zerocounters --directory "$BUILD_DIR"

# Run the tests
ctest --output-on-failure --test-dir "$BUILD_DIR"

# Capture the coverage counters
lcov --capture --directory "$BUILD_DIR" --output-file "$REPORT_FILE_NAME" \
     --exclude '/usr/*' --exclude "$EXTERNAL_DIR" -exclude "$TESTS_DIR" \
     --demangle-cpp  --branch-coverage
# Stop if lcov fails
if [[ $? -ne 0 ]]; then
    echo -e "\nERROR: lcov capture FAILED.\n"
    exit 1
fi

# Generate the HTML report
genhtml "$REPORT_FILE_NAME"  --output-directory "$REPORT_SRC_DIR" \
        --demangle-cpp --branch-coverage --function-coverage --no-prefix 
# Stop if genhtml fails
if [[ $? -ne 0 ]]; then
    echo -e "\nERROR: genhtml report FAILED.\n"
    exit 1
fi

# Ensure the source directory exists
if [[ ! -d "$REPORT_SRC_DIR" ]]; then
    echo -e "\nERROR: Source directory $REPORT_SRC_DIR does not exist!\n"
    exit 1
fi

# Create destination directory if it does not exist
mkdir -p "$REPORT_DST_DIR"
if [[ $? -ne 0 ]]; then
    echo -e "\nERROR: Failed to create destination directory $REPORT_DST_DIR\n"
    exit 1
fi

# Copy the report to the destination directory
if cp -r "$REPORT_SRC_DIR" "$REPORT_DST_DIR"; then
    echo -e "\nCoverage report copied successfully to $REPORT_DST_DIR\n"
else
    echo -e "\nERROR: Failed to copy coverage report!\n"
    exit 1
fi
