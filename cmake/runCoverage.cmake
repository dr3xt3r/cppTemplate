# runCoverage.cmake

#Add a custom target for coverage
add_custom_target(Coverage
    DEPENDS hello_test
    COMMAND bash ${CMAKE_SOURCE_DIR}/scripts/coverage.sh
)