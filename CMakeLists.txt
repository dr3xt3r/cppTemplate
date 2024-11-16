# Set the minimum version of CMake that can be used
cmake_minimum_required(VERSION 3.14)

# Set the project name and the language
project(CMakeTemplateExample LANGUAGES CXX C)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

# Set the C standard
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED YES)

# Enable testing
enable_testing()

# Include the sanitizer configuration
include(cmake/setSanitizers.cmake)

# Add the src directory
add_subdirectory(src)

# Add the test directory
add_subdirectory(tests)