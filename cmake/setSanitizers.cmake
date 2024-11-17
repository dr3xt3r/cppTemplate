# setSanitizers.cmake

# Initialize the sanitizer flags variable
set(SANITIZER_FLAGS "")

# Iterate over the list of sanitizers and add the flags to the SANITIZER_FLAGS variable
foreach(SANITIZER ${SANITIZERS})
if(${SANITIZER} STREQUAL "address")
    set(SANITIZER_FLAGS "${SANITIZER_FLAGS} -fsanitize=address")
elseif(${SANITIZER} STREQUAL "undefined")
    set(SANITIZER_FLAGS "${SANITIZER_FLAGS} -fsanitize=undefined")
elseif(${SANITIZER} STREQUAL "thread")
    set(SANITIZER_FLAGS "${SANITIZER_FLAGS} -fsanitize=thread")
endif()
endforeach()

# Only with Clang, GCC does not support memory sanitizer
#if (SANITIZERS MATCHES "memory")
#    set(SANITIZER_FLAGS "${SANITIZER_FLAGS} -fsanitize=memory")
#endif()

# Apply the sanitizer flags if they are defined
if (SANITIZER_FLAGS)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${SANITIZER_FLAGS} -fno-omit-frame-pointer")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${SANITIZER_FLAGS} -fno-omit-frame-pointer")
endif()