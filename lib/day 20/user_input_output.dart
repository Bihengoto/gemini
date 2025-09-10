// User Input and Output Handling Examples
import 'dart:io';

void main() {
  print('=== User Input and Output Examples ===\n');

  // Example 1: Basic input/output
  basicInputOutput();

  print('\n' + '=' * 50 + '\n');

  // Example 2: Input validation
  inputValidationExample();

  print('\n' + '=' * 50 + '\n');

  // Example 3: Menu-driven interface
  menuDrivenInterface();
}

void basicInputOutput() {
  print('1. Basic Input/Output Example');

  // Get user's name
  stdout.write('Enter your name: ');
  String? name = stdin.readLineSync();

  // Get user's age
  stdout.write('Enter your age: ');
  String? ageInput = stdin.readLineSync();

  // Process and display
  name = name?.trim() ?? 'Unknown';
  int? age = int.tryParse(ageInput ?? '');

  print('\nUser Information:');
  print('Name: $name');
  print('Age: ${age ?? 'Not provided'}');

  if (age != null) {
    if (age >= 18) {
      print('Status: Adult');
    } else {
      print('Status: Minor');
    }
  }
}

void inputValidationExample() {
  print('2. Input Validation Example');

  int? number;
  while (number == null) {
    stdout.write('Enter a valid number: ');
    String? input = stdin.readLineSync();

    if (input == null || input.trim().isEmpty) {
      print('Error: Input cannot be empty. Please try again.');
      continue;
    }

    number = int.tryParse(input.trim());
    if (number == null) {
      print('Error: "$input" is not a valid number. Please try again.');
    }
  }

  print('You entered: $number');
  print('Square of $number is: ${number * number}');
}

void menuDrivenInterface() {
  print('3. Menu-Driven Interface Example');

  while (true) {
    print('\n--- Simple Menu ---');
    print('1. Say Hello');
    print('2. Calculate Square');
    print('3. Current Time');
    print('4. Exit');
    stdout.write('Choose an option (1-4): ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter your name: ');
        String? name = stdin.readLineSync();
        print('Hello, ${name ?? 'Anonymous'}!');
        break;

      case '2':
        stdout.write('Enter a number: ');
        String? numInput = stdin.readLineSync();
        double? num = double.tryParse(numInput ?? '');
        if (num != null) {
          print('Square of $num is: ${num * num}');
        } else {
          print('Invalid number entered.');
        }
        break;

      case '3':
        print('Current time: ${DateTime.now()}');
        break;

      case '4':
        print('Goodbye!');
        return;

      default:
        print('Invalid choice. Please select 1-4.');
    }
  }
}

// Helper function for getting validated input
String getValidatedInput(
  String prompt,
  bool Function(String) validator,
  String errorMessage,
) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();

    if (input != null && validator(input)) {
      return input;
    }

    print(errorMessage);
  }
}

// Helper function for getting numeric input
double getNumericInput(String prompt) {
  while (true) {
    stdout.write(prompt);
    String? input = stdin.readLineSync();

    if (input != null) {
      double? number = double.tryParse(input.trim());
      if (number != null) {
        return number;
      }
    }

    print('Please enter a valid number.');
  }
}
