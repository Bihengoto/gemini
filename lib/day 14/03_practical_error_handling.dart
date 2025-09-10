// Day 14: Practical Error Handling
// Real-world examples and best practices

import 'dart:io';
import 'dart:convert';
import 'dart:math';

void main() {
  print('=== Practical Error Handling ===\n');

  // File operations with error handling
  fileOperationsExample();

  print('\n' + '=' * 40 + '\n');

  // Network simulation with error handling
  networkOperationExample();

  print('\n' + '=' * 40 + '\n');

  // Calculator with comprehensive error handling
  calculatorExample();

  print('\n' + '=' * 40 + '\n');

  // User input validation
  userInputValidationExample();
}

/// File operations with proper error handling
void fileOperationsExample() {
  print('1. File Operations with Error Handling:');

  // Safe file reading
  String content = safeReadFile('gemini/lib/day 14/sample.txt');
  print('File content: $content\n');

  // Safe file writing
  bool success = safeWriteFile(
    'gemini/lib/day 14/output.txt',
    'Hello, Error Handling!',
  );
  print('File write success: $success\n');
}

String safeReadFile(String filePath) {
  try {
    File file = File(filePath);
    if (!file.existsSync()) {
      print('File does not exist, creating sample content...');
      return 'Sample file content for error handling demo';
    }
    return file.readAsStringSync();
  } on FileSystemException catch (e) {
    print('File system error: ${e.message}');
    return 'Error reading file';
  } catch (e) {
    print('Unexpected error reading file: $e');
    return 'Unknown error';
  }
}

bool safeWriteFile(String filePath, String content) {
  try {
    File file = File(filePath);
    file.writeAsStringSync(content);
    print('Successfully wrote to: $filePath');
    return true;
  } on FileSystemException catch (e) {
    print('Failed to write file: ${e.message}');
    return false;
  } catch (e) {
    print('Unexpected error writing file: $e');
    return false;
  }
}

/// Network operation simulation
class NetworkException implements Exception {
  final String message;
  final int statusCode;

  const NetworkException(this.message, this.statusCode);

  @override
  String toString() => 'NetworkException [$statusCode]: $message';
}

void networkOperationExample() {
  print('2. Network Operation Simulation:');

  List<String> urls = [
    'https://api.example.com/users',
    'https://api.example.com/invalid',
    'https://timeout.example.com/data',
  ];

  for (String url in urls) {
    try {
      String result = simulateNetworkRequest(url);
      print('✓ Success: $result');
    } on NetworkException catch (e) {
      print('✗ Network error: $e');
    } on TimeoutException catch (e) {
      print('✗ Timeout: ${e.message}');
    } catch (e) {
      print('✗ Unexpected error: $e');
    }
  }
  print('');
}

String simulateNetworkRequest(String url) {
  // Simulate different types of network errors
  Random random = Random();
  int scenario = random.nextInt(4);

  switch (scenario) {
    case 0:
      return 'Data received from $url';
    case 1:
      throw NetworkException('Not Found', 404);
    case 2:
      throw NetworkException('Server Error', 500);
    case 3:
      throw TimeoutException('Request timeout', Duration(seconds: 30));
    default:
      return 'Success';
  }
}

class TimeoutException implements Exception {
  final String message;
  final Duration timeout;

  const TimeoutException(this.message, this.timeout);

  @override
  String toString() => 'TimeoutException: $message (${timeout.inSeconds}s)';
}

/// Calculator with comprehensive error handling
class CalculatorException implements Exception {
  final String message;
  final String operation;

  const CalculatorException(this.message, this.operation);

  @override
  String toString() => 'CalculatorException in $operation: $message';
}

void calculatorExample() {
  print('3. Calculator with Error Handling:');

  Calculator calc = Calculator();

  // Test various operations
  List<Map<String, dynamic>> operations = [
    {'op': 'divide', 'a': 10.0, 'b': 2.0},
    {'op': 'divide', 'a': 10.0, 'b': 0.0}, // Division by zero
    {'op': 'sqrt', 'a': 16.0},
    {'op': 'sqrt', 'a': -4.0}, // Negative square root
    {'op': 'log', 'a': 10.0},
    {'op': 'log', 'a': 0.0}, // Log of zero
  ];

  for (var op in operations) {
    try {
      double result;
      switch (op['op']) {
        case 'divide':
          result = calc.divide(op['a'], op['b']);
          break;
        case 'sqrt':
          result = calc.squareRoot(op['a']);
          break;
        case 'log':
          result = calc.logarithm(op['a']);
          break;
        default:
          continue;
      }
      print(
        '✓ ${op['op']}(${op['a']}${op['b'] != null ? ', ${op['b']}' : ''}) = $result',
      );
    } on CalculatorException catch (e) {
      print('✗ Calculator error: $e');
    }
  }
  print('');
}

class Calculator {
  double divide(double a, double b) {
    if (b == 0) {
      throw CalculatorException('Division by zero is not allowed', 'divide');
    }
    return a / b;
  }

  double squareRoot(double a) {
    if (a < 0) {
      throw CalculatorException(
        'Cannot calculate square root of negative number',
        'sqrt',
      );
    }
    return sqrt(a);
  }

  double logarithm(double a) {
    if (a <= 0) {
      throw CalculatorException(
        'Logarithm undefined for non-positive numbers',
        'log',
      );
    }
    return log(a);
  }
}

/// User input validation example
class ValidationException implements Exception {
  final String field;
  final String message;

  const ValidationException(this.field, this.message);

  @override
  String toString() => 'ValidationException [$field]: $message';
}

void userInputValidationExample() {
  print('4. User Input Validation:');

  // Simulate user inputs
  List<Map<String, String>> userInputs = [
    {'email': 'user@example.com', 'age': '25', 'phone': '+1234567890'},
    {'email': 'invalid-email', 'age': '25', 'phone': '+1234567890'},
    {'email': 'user@example.com', 'age': '-5', 'phone': '+1234567890'},
    {'email': 'user@example.com', 'age': '25', 'phone': 'invalid-phone'},
  ];

  for (int i = 0; i < userInputs.length; i++) {
    print('Validating user ${i + 1}:');
    try {
      validateUserInput(userInputs[i]);
      print('✓ All validations passed');
    } on ValidationException catch (e) {
      print('✗ Validation failed: $e');
    } catch (e) {
      print('✗ Unexpected validation error: $e');
    }
    print('');
  }
}

void validateUserInput(Map<String, String> input) {
  // Email validation
  String? email = input['email'];
  if (email == null || email.isEmpty) {
    throw ValidationException('email', 'Email is required');
  }
  if (!email.contains('@') || !email.contains('.')) {
    throw ValidationException('email', 'Invalid email format');
  }

  // Age validation
  String? ageStr = input['age'];
  if (ageStr == null || ageStr.isEmpty) {
    throw ValidationException('age', 'Age is required');
  }

  int age;
  try {
    age = int.parse(ageStr);
  } catch (e) {
    throw ValidationException('age', 'Age must be a valid number');
  }

  if (age < 0 || age > 150) {
    throw ValidationException('age', 'Age must be between 0 and 150');
  }

  // Phone validation
  String? phone = input['phone'];
  if (phone == null || phone.isEmpty) {
    throw ValidationException('phone', 'Phone number is required');
  }
  if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(phone)) {
    throw ValidationException('phone', 'Invalid phone number format');
  }
}
