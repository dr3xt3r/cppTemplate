# Set the minimum version of CMake that can be used
cmake_minimum_required(VERSION 3.10)

# Set the project name and the language
project(CMakeTemplateExample LANGUAGES CXX C)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED YES)

# Set the C standard
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED YES)

# Include directories
include_directories(src/include)

# Collect all source files in the src directory
file(GLOB_RECURSE SOURCES "src/src/*.cpp")

# Include the sanitizer configuration
include(cmake/setSanitizers.cmake)

# Executable
add_executable(${PROJECT_NAME} ${SOURCES})

