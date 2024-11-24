# cppTemplate
Simple C++ development template repo using VS Code dev-containers.

### Toolchain
- **CMake**:
  - Build and configure using `cmake`.
- **GCC**:
  - Used as the compiler.
- **GDB**:
  - Debug using `launch.json` configuration.
  - Alternatively, use the CMake-provided Debug and Run options in the CMake Toolbar.

  ### Code Analysis
- **clangd**:
  - Integrated tools:
    - **clang-tidy**:
      - Runs automatically in the background, reporting issues in the "Problems" pane.
    - **clang-format**:
      - Use "Format Document" to apply formatting rules.
- **Cppcheck**:
    - Run as a VS Code task
    - Output shown in the terminal or generated as an HTML file.

### Memory Analysis
- **Valgrind**:
  - Run as a VS Code task for memory analysis.

### Sanitizers
- **AddressSanitizer (ASAN)**, **LeakSanitizer (LSAN)**, **UndefinedBehaviorSanitizer (UBSAN)**, and **ThreadSanitizer (TSAN)**:
  - Build configurations and presets provided in CMakePresets.json
  - Notes:
    - Debugging does not work when LSAN is enabled. LSAN is integrated into ASAN and can be enabled/disabled via chosen preset.
    - `-fsanitize=address` cannot be combined with `-fsanitize=thread`.
    - MemorySanitizer (MSAN) is not supported on GCC (Clang only).

### Unit Testing
- **GoogleTest**:
  - Added as a submodule.
  - To include GoogleTest in the project:
    1. Clone the repository with submodules:
       ```bash
       git clone --recurse-submodules <repository-url>
       ```
    2. Alternatively, if the repo is already cloned, initialize submodules only:
       ```bash
       git submodule update --init --recursive
       ```
  - **TODO**: Alternatively set up CppUTest (preferred for embedded systems).

#### Usage Options for Tests
1. **CMake Toolbar**:
   - Click "Run CTest", results printed to terminal in CTest style output.
   - Click "Launch Debugger" or "Launch Target", GoogleTest style output in the terminal with debugging via CMake Debugger.
2. **Testing Activity Bar**:
   - Click "Run Tests", alternative to "Run CTest" from CMake Toolbar
   - **Note**: "Debug Tests" is a buggy feature, best to avoid
3. **Tasks**:
   - `CTest -VV`: Outputs verbose results of all tests in the terminal.
   - `CTest --output-on-failure`: Outputs verbose results of only failed tests in the terminal.
4. **Debug Session**:
   - Start a `(gdb) Debug` session for default GoogleTest style output (colorized) in the terminal, with launch.json definned debugging.

- **Note**: When using "Run CTest" in CMake Toolbar or "Run Tests" in Testing Activity bar, GoogleTest style output (no colorizing) is available in the Testing Activity Bar -> Show Output.

### Code Coverage
- **Coverage Target**:
  - Build dependencies and run `coverage.sh` script that executes tests,runs `lcov` to generate coverage data and generates an HTML report using `genhtml`.
- **TODO**:
  - Add Coverage Gutters to display coverage data in the IDE.
  - Use C++ TestMate as an alternative interactive test runner in the IDE.

### General
- **clean**: as `clean_project.sh` and VS Code task