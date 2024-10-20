#!/bin/bash

# directory paths
CPPCHECK_DIR="cppcheck/build"
REPORT_DIR="cppcheck/cppcheck_report"
HTML_REPORT_DIR="cppcheck/html_report"
PROJECT_REPORT_DIR="report"

# file names
CPPCHECK_CHECKERS_REPORT="$REPORT_DIR/cppcheck_checkers_report"
CPPCHECK_ANALYSIS_REPORT_XML="$REPORT_DIR/cppcheck_analysis_report.xml"
CPPCHECK_ANALYSIS_REPORT_HTML="$HTML_REPORT_DIR/index.html"


# Create directories for Cppcheck build and reports
mkdir -p "$CPPCHECK_DIR"
mkdir -p "$REPORT_DIR"
mkdir -p "$HTML_REPORT_DIR"
mkdir -p "$PROJECT_REPORT_DIR"

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
             --output-file="$CPPCHECK_ANALYSIS_REPORT_XML"

    # Generate HTML report from the XML report
    cppcheck-htmlreport --file="$CPPCHECK_ANALYSIS_REPORT_XML" --report-dir="$HTML_REPORT_DIR"

    cp "$CPPCHECK_ANALYSIS_REPORT_HTML" "$PROJECT_REPORT_DIR"/cppcheck_report.html
    cp "$CPPCHECK_CHECKERS_REPORT" "$PROJECT_REPORT_DIR"/cppcheck_checkers_report.txt


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