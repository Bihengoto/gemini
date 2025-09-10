# Day 20: Command-Line Applications in Dart

## Overview
Command-line applications are programs that run in a terminal or command prompt, accepting input and providing output through text-based interfaces. Dart provides excellent support for building CLI tools.

## Key Concepts

### 1. Command-Line Arguments
- Access via `List<String> arguments` parameter in main()
- Use `dart:io` library for advanced I/O operations
- Arguments are passed when running: `dart run program.dart arg1 arg2`

### 2. Standard Input/Output
- `stdin` - Standard input stream
- `stdout` - Standard output stream  
- `stderr` - Standard error stream

### 3. User Input Handling
- `stdin.readLineSync()` - Read a line from user
- `stdin.readByteSync()` - Read single byte
- Always handle null returns from readLineSync()

### 4. Output Formatting
- `print()` - Basic output with newline
- `stdout.write()` - Output without newline
- `stdout.writeln()` - Output with newline

## Best Practices

1. **Error Handling**: Always validate user input
2. **Help Messages**: Provide usage instructions
3. **Exit Codes**: Use appropriate exit codes (0 for success, non-zero for errors)
4. **Input Validation**: Check for null and invalid inputs
5. **User Experience**: Provide clear prompts and error messages

## Common Patterns

### Basic CLI Structure
```dart
import 'dart:io';

void main(List<String> arguments) {
  // Handle command-line arguments
  // Process user input
  // Provide output
  // Exit with appropriate code
}
```

### Input Validation Pattern
```dart
String? getUserInput(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync();
}

double? parseNumber(String? input) {
  if (input == null || input.isEmpty) return null;
  return double.tryParse(input);
}
```

## File Organization
- `basic_cli.dart` - Simple CLI example
- `user_input_output.dart` - Input/output handling examples
- `calculator.dart` - Command-line calculator implementation
- `advanced_calculator.dart` - Enhanced calculator with error handling