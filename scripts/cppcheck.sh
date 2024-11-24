#!/bin/bash

# directory paths
PROJECT_ROOT_DIR="/workspace"
PROJECT_BUILD_DIR="$PROJECT_ROOT_DIR/build"
PROJECT_LOG_DIR="$PROJECT_ROOT_DIR/logs"
PROJECT_EXTERNAL_DIR="$PROJECT_ROOT_DIR/external"

CPPCHECK_DIR="$PROJECT_BUILD_DIR/cppcheck"
CPPCHECK_BUILD_DIR="$CPPCHECK_DIR/build"
CPPCHECK_REPORT_DIR="$CPPCHECK_DIR/cppcheck_report"
CPPCHECK_REPORT_HTML_DIR="$CPPCHECK_DIR/cppcheck_report_html"

# file names
CPPCHECK_CHECKERS_REPORT="$CPPCHECK_REPORT_DIR/cppcheck_checkers_report"
CPPCHECK_CHECKERS_REPORT_DST="$PROJECT_LOG_DIR/cppcheck_checkers_report"
CPPCHECK_ANALYSIS_REPORT_XML="$CPPCHECK_REPORT_DIR/cppcheck_analysis_report.xml"
CPPCHECK_ANALYSIS_REPORT_HTML="$CPPCHECK_REPORT_HTML_DIR/index.html"
CPPCHECK_ANALYSIS_REPORT_HTML_DST="$PROJECT_LOG_DIR/cppcheck_report.html"
COMPILE_COMMANDS_JSON="$PROJECT_BUILD_DIR/compile_commands.json"

# Remove previous reports and build files. Stop script if it fails
rm -rf "$CPPCHECK_DIR/*" || { echo "Failed to remove $CPPCHECK_DIR/*"; exit 1; }
rm -f "$CPPCHECK_CHECKERS_REPORT_DST" || { echo "Failed to remove $CPPCHECK_CHECKERS_REPORT_DST"; exit 1; }
rm -f "$CPPCHECK_ANALYSIS_REPORT_HTML_DST" || { echo "Failed to remove $CPPCHECK_ANALYSIS_REPORT_HTML_DST"; exit 1; }

# Create directories, stop script if it fails
create_dir() {
    local dir=$1
    mkdir -p "$dir" || { echo "Failed to create: $dir"; exit 1; }
}

create_dir "$CPPCHECK_BUILD_DIR"
create_dir "$CPPCHECK_REPORT_DIR"
create_dir "$CPPCHECK_REPORT_HTML_DIR"
create_dir "$PROJECT_LOG_DIR"

# Check the argument passed
if [ "$1" == "output_to_file" ]; then
    echo "Running Cppcheck with HTML file output"
    # Run Cppcheck with XML output, stop script if it fails
    cppcheck --enable=all \
             --inconclusive \
             --suppress=missingIncludeSystem \
             --suppress=unmatchedSuppression \
             --cppcheck-build-dir="$CPPCHECK_BUILD_DIR" \
             --project="$COMPILE_COMMANDS_JSON" \
             --platform=unix64 \
             --checkers-report="$CPPCHECK_CHECKERS_REPORT" \
             --xml \
             --output-file="$CPPCHECK_ANALYSIS_REPORT_XML" \
             -i "$PROJECT_EXTERNAL_DIR"

    if [ $? -ne 0 ]; then
        echo "Cppcheck analysis failed."
        exit 1
    fi         

    # Generate HTML report from the XML report, stop script if it fails
    cppcheck-htmlreport --file="$CPPCHECK_ANALYSIS_REPORT_XML" --report-dir="$CPPCHECK_REPORT_HTML_DIR"
    if [ $? -ne 0 ]; then
        echo "Cppcheck HTML report generation failed."
        exit 1
    fi

    # Copy the HTML report to the destination directory, stop script if it fails
    cp "$CPPCHECK_ANALYSIS_REPORT_HTML" "$CPPCHECK_ANALYSIS_REPORT_HTML_DST"
    if [ $? -ne 0 ]; then
        echo "Failed to copy HTML report to destination."
        exit 1
    fi

    # Copy the checkers report to the destination directory, stop script if it fails
    cp "$CPPCHECK_CHECKERS_REPORT" "$CPPCHECK_CHECKERS_REPORT_DST"
    if [ $? -ne 0 ]; then
        echo "Failed to copy checkers report to destination."
        exit 1
    fi

elif [ "$1" == "output_to_terminal" ]; then
    echo "Running Cppcheck with terminal output"
    # Run Cppcheck with terminal output, stop script if it fails
    cppcheck --enable=all \
             --inconclusive \
             --suppress=missingIncludeSystem \
             --suppress=unmatchedSuppression \
             --cppcheck-build-dir="$CPPCHECK_BUILD_DIR" \
             --project="$COMPILE_COMMANDS_JSON" \
             --platform=unix64 \
             --checkers-report="$CPPCHECK_CHECKERS_REPORT" \
             -i "$PROJECT_EXTERNAL_DIR"

    if [ $? -ne 0 ]; then
        echo "Cppcheck analysis failed."
        exit 1
    fi           

else
    echo "Invalid argument. Please use 'generate_report' or 'print_to_terminal'."
fi