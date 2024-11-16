# src/CMakeLists.txt

# Collect all source files in the src directory
file(GLOB_RECURSE SOURCES "*.cpp")

# Executable
add_executable(${PROJECT_NAME} ${SOURCES})

# Include directories
target_include_directories(${PROJECT_NAME} PUBLIC include)