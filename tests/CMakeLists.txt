# tests/CMakeLists.txt

# Add the GoogleTest library subdirectory
add_subdirectory(${CMAKE_SOURCE_DIR}/external/googletest ${CMAKE_BINARY_DIR}/googletest_build)

# Include GoogleTest module to use its utilities, such as gtest_discover_tests()
include(GoogleTest)

# Include CTest module
include(CTest)

# Add your test executable (ensure the paths are correct)
add_executable(hello_test hello_test.cpp ${CMAKE_SOURCE_DIR}/src/src/calculator.cpp)

# Include directories to find calculator.h
target_include_directories(hello_test PUBLIC ${CMAKE_SOURCE_DIR}/src/include)

# Link GoogleTest to your test executable
target_link_libraries(hello_test PRIVATE gtest gtest_main)

# Discover GoogleTest-based tests
gtest_discover_tests(hello_test)
