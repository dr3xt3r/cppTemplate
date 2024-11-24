# cppTemplate
Simple C++ template repo using dev containers

clean - as clean_project.sh and vs code task
cmake
gcc
gdb - using launch config, alternatively use cmake provided debug and run
clangd
  -clang-tidy (integrated into clangd -> analyzer runs in the background and reports on 'Problems" pane)
  -clang-format (integrated into clangd -> use 'Format Document')
cppcheck - run as task - either in terminal or with HTML output file
Valgrind - run as task
Sanitizers - build configurations and presets for ASAN,LSAN, UBSAN and TSAN
           - Debug does not work when Leak Sanitizer is turned on -> LSAN is integrated into ASAN and can be enabled or disabled with presets
           - [-fsanitize=address] The option cannot be combined with [-fsanitize=thread]
           - MSAN does not work on gcc, only clang
googletest - added as submodule
           - to add googletest either clone entire repo with: git clone --recurse-submodules <repository-url>
             or after git clone <repository-url> run: git submodule update --init --recursive
           - TODO: alternatively set up cpputest(preffered for embedded)  
           - USAGE OPTIONS:
                1. Clicking "Run CTest" in CMake Toolbar - results are printed to CMake output window
                2. Clicking "Launch Debugger" or "Launch Target" in CMake Toolbar - results printed to terminal CTest style, offers debugging via CMake
                3. Clicking "Run Tests" or "Debug Tests" in Testing activity bar - results printed to CMake output window CTest style, offers debugging via CTest
                4. Usings tasks "CTest -VV" (more verbose output of ALL tests) or "CTest --output-on-failure" (more verbose output of ONLY failed tests) - results printed to terminal in google style (with colorizing)
                5. Start a "(gdb) Debug" session - default results printed to terminal in google style (with colorizing), offers debugging via IDE
                NOTE: for 2 and 3 the google style output (no colorizing) can be checked via Testing activity bar -> Show Output
code coverage - run CMake target "Coverage". It will build dependencies and run the coverage.sh script that runs tests,lcov and genhtml
              - TODO: alternatively add Coverage Gutters to display coverage in IDE
              - TODO: alternatively add C++ TestMate instead of CTest as an IDE interactive test runner