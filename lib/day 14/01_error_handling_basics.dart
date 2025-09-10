// Day 14: Error Handling Basics
// Understanding try, catch, on, and finally blocks

void main() {
  print('=== Error Handling Basics ===\n');

  // Basic try-catch example
  basicTryCatch();

  print('\n' + '=' * 40 + '\n');

  // Specific exception handling with 'on'
  specificExceptionHandling();

  print('\n' + '=' * 40 + '\n');

  // Using finally block
  finallyBlockExample();

  print('\n' + '=' * 40 + '\n');

  // Multiple exception types
  multipleExceptionTypes();
}

/// Basic try-catch example
void basicTryCatch() {
  print('1. Basic Try-Catch:');

  try {
    int result = 10 ~/ 0; // This will throw an exception
    print('Result: $result');
  } catch (e) {
    print('Caught an exception: $e');
  }

  print('Program continues after exception handling\n');
}

/// Handling specific exception types with 'on'
void specificExceptionHandling() {
  print('2. Specific Exception Handling with "on":');

  try {
    List<int> numbers = [1, 2, 3];
    print('Accessing index 5: ${numbers[5]}');
  } on RangeError catch (e) {
    print('Range Error caught: ${e.message}');
  } catch (e) {
    print('Other exception: $e');
  }

  print('');
}

/// Using finally block - always executes
void finallyBlockExample() {
  print('3. Finally Block Example:');

  try {
    print('Executing risky operation...');
    throw Exception('Something went wrong!');
  } catch (e) {
    print('Exception caught: $e');
  } finally {
    print('Finally block always executes - cleanup code here');
  }

  print('');
}

/// Handling multiple exception types
void multipleExceptionTypes() {
  print('4. Multiple Exception Types:');

  List<Function> riskyOperations = [
    () => 10 ~/ 0, // IntegerDivisionByZeroException
    () => [1, 2, 3][10], // RangeError
    () => int.parse('not_a_number'), // FormatException
  ];

  for (int i = 0; i < riskyOperations.length; i++) {
    try {
      print('Operation ${i + 1}:');
      riskyOperations[i]();
    } on IntegerDivisionByZeroException {
      print('  → Division by zero error');
    } on RangeError catch (e) {
      print('  → Range error: ${e.message}');
    } on FormatException catch (e) {
      print('  → Format error: ${e.message}');
    } catch (e) {
      print('  → Unknown error: $e');
    }
  }
}
