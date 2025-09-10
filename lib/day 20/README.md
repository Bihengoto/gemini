# Day 20: Command-Line Applications

This folder contains comprehensive examples and practice materials for building command-line applications in Dart.

## Files Overview

### 📝 Documentation
- **`notes.md`** - Comprehensive notes on CLI development concepts and best practices

### 🔧 Basic Examples
- **`basic_cli.dart`** - Simple CLI application demonstrating basic concepts
- **`user_input_output.dart`** - Examples of handling user input and output

### 🧮 Calculator Implementations
- **`calculator.dart`** - Simple command-line calculator (main practice project)
- **`advanced_calculator.dart`** - Enhanced calculator with more features

### 🛠️ Utilities
- **`cli_utilities.dart`** - Reusable utility functions and classes for CLI development

## How to Run

### Basic CLI Example
```bash
dart run gemini/lib/day\ 20/basic_cli.dart
# Or with arguments:
dart run gemini/lib/day\ 20/basic_cli.dart hello world 123
```

### User Input/Output Examples
```bash
dart run gemini/lib/day\ 20/user_input_output.dart
```

### Simple Calculator
```bash
# Interactive mode:
dart run gemini/lib/day\ 20/calculator.dart

# Command-line mode:
dart run gemini/lib/day\ 20/calculator.dart 10 + 5
dart run gemini/lib/day\ 20/calculator.dart 15 / 3
```

### Advanced Calculator
```bash
# Interactive mode:
dart run gemini/lib/day\ 20/advanced_calculator.dart

# Command-line mode:
dart run gemini/lib/day\ 20/advanced_calculator.dart 16 sqrt
dart run gemini/lib/day\ 20/advanced_calculator.dart 2 ^ 8
dart run gemini/lib/day\ 20/advanced_calculator.dart --help
```

### CLI Utilities Demo
```bash
dart run gemini/lib/day\ 20/cli_utilities.dart
```

## Learning Objectives

By working through these examples, you'll learn:

1. **Basic CLI Structure** - How to create command-line applications in Dart
2. **Argument Handling** - Processing command-line arguments
3. **User Input** - Reading and validating user input from stdin
4. **Output Formatting** - Different ways to display output
5. **Error Handling** - Proper error handling in CLI applications
6. **Interactive Interfaces** - Creating menu-driven applications
7. **Utility Functions** - Building reusable CLI components

## Practice Exercises

1. **Extend the Calculator** - Add more mathematical operations
2. **File Operations** - Create a CLI tool that works with files
3. **Data Processing** - Build a tool that processes CSV or JSON data
4. **System Information** - Create a tool that displays system information
5. **Task Manager** - Build a simple todo list manager

## Key Concepts Covered

- `dart:io` library usage
- Standard input/output streams
- Command-line argument parsing
- Input validation and error handling
- Menu-driven interfaces
- Progress indicators
- Logging utilities
- Cross-platform considerations