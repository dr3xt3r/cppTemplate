#!/bin/bash

# directory paths
CPPCHECK_DIR="cppcheck/build"
REPORT_DIR="cppcheck/cppcheck_report"
HTML_REPORT_DIR="cppcheck/html_report"

# file names
CPPCHECK_CHECKERS_REPORT="$REPORT_DIR/cppcheck_checkers_report"
CPPCHECK_ANALYSIS_REPORT="$REPORT_DIR/cppcheck_analysis_report.xml"

# Create directories for Cppcheck build and reports
mkdir -p "$CPPCHECK_DIR"
mkdir -p "$REPORT_DIR"
mkdir -p "$HTML_REPORT_DIR"

# Check the argument passed
if [ "$1" == "output_to_file" ]; then
    echo "Running Cppcheck with HTML file output"

    cppcheck --enable=all \
             --inconclusive \
             --suppress=missingIncludeSystem \
             --suppress=unmatchedSuppression \
             --cppcheck-build-dir="$CPPCHECK_DIR" \
             --project=build/compile_commands.json \
             --platform=unix64 \
             --checkers-report="$CPPCHECK_CHECKERS_REPORT" \
             --xml \
             --output-file="$CPPCHECK_ANALYSIS_REPORT"

    # Generate HTML report from the XML report
    cppcheck-htmlreport --file="$CPPCHECK_ANALYSIS_REPORT" --report-dir="$HTML_REPORT_DIR"

elif [ "$1" == "output_to_terminal" ]; then
    echo "Running Cppcheck with terminal output"
    cppcheck --enable=all \
             --inconclusive \
             --suppress=missingIncludeSystem \
             --suppress=unmatchedSuppression \
             --cppcheck-build-dir="$CPPCHECK_DIR" \
             --project=build/compile_commands.json \
             --platform=unix64 \
             --checkers-report="$CPPCHECK_CHECKERS_REPORT"

else
    echo "Invalid argument. Please use 'generate_report' or 'print_to_terminal'."
fi