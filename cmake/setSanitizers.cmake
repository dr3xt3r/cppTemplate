# setSanitizers.cmake

# Initialize the sanitizer flags variable
set(SANITIZER_FLAGS "")

# Add sanitizer flags if specified
if (SANITIZERS MATCHES "address")
    set(SANITIZER_FLAGS "${SANITIZER_FLAGS} -fsanitize=address")
endif()

if (SANITIZERS MATCHES "thread")
    set(SANITIZER_FLAGS "${SANITIZER_FLAGS} -fsanitize=thread")
endif()

if (SANITIZERS MATCHES "undefined")
    set(SANITIZER_FLAGS "${SANITIZER_FLAGS} -fsanitize=undefined")
endif()

# Only with Clang, GCC does not support memory sanitizer
#if (SANITIZERS MATCHES "memory")
#    set(SANITIZER_FLAGS "${SANITIZER_FLAGS} -fsanitize=memory")
#endif()

if (LSAN_ENABLED)
    set(SANITIZER_FLAGS "${SANITIZER_FLAGS} -DASAN_OPTIONS=detect_leaks=1")
endif()

# Apply the sanitizer flags if they are defined
if (SANITIZER_FLAGS)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SANITIZER_FLAGS} -fno-omit-frame-pointer")
endif()