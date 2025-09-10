// Simple Command-Line Calculator
import 'dart:io';

void main(List<String> arguments) {
  print('=== Simple Command-Line Calculator ===\n');

  // Check if arguments are provided
  if (arguments.length == 3) {
    // Use command-line arguments
    calculateFromArguments(arguments);
  } else {
    // Interactive mode
    interactiveCalculator();
  }
}

void calculateFromArguments(List<String> arguments) {
  print('Using command-line arguments...');

  try {
    double num1 = double.parse(arguments[0]);
    String operator = arguments[1];
    double num2 = double.parse(arguments[2]);

    double? result = performCalculation(num1, operator, num2);

    if (result != null) {
      print('$num1 $operator $num2 = $result');
    } else {
      print('Error: Invalid operator "$operator"');
      printUsage();
    }
  } catch (e) {
    print('Error: Invalid number format in arguments');
    printUsage();
  }
}

void interactiveCalculator() {
  print('Interactive Calculator Mode');
  print('Enter "quit" or "exit" to stop\n');

  while (true) {
    try {
      // Get first number
      stdout.write('Enter first number: ');
      String? input1 = stdin.readLineSync();

      if (input1 == null ||
          input1.toLowerCase() == 'quit' ||
          input1.toLowerCase() == 'exit') {
        print('Goodbye!');
        break;
      }

      double num1 = double.parse(input1);

      // Get operator
      stdout.write('Enter operator (+, -, *, /): ');
      String? operator = stdin.readLineSync();

      if (operator == null ||
          operator.toLowerCase() == 'quit' ||
          operator.toLowerCase() == 'exit') {
        print('Goodbye!');
        break;
      }

      // Get second number
      stdout.write('Enter second number: ');
      String? input2 = stdin.readLineSync();

      if (input2 == null ||
          input2.toLowerCase() == 'quit' ||
          input2.toLowerCase() == 'exit') {
        print('Goodbye!');
        break;
      }

      double num2 = double.parse(input2);

      // Perform calculation
      double? result = performCalculation(num1, operator, num2);

      if (result != null) {
        print('Result: $num1 $operator $num2 = $result\n');
      } else {
        print('Error: Invalid operator "$operator"\n');
      }
    } catch (e) {
      print('Error: Please enter valid numbers\n');
    }
  }
}

double? performCalculation(double num1, String operator, double num2) {
  switch (operator) {
    case '+':
      return num1 + num2;
    case '-':
      return num1 - num2;
    case '*':
      return num1 * num2;
    case '/':
      if (num2 == 0) {
        print('Error: Division by zero is not allowed');
        return null;
      }
      return num1 / num2;
    default:
      return null;
  }
}

void printUsage() {
  print('\nUsage:');
  print('  dart run calculator.dart <number1> <operator> <number2>');
  print('  Example: dart run calculator.dart 10 + 5');
  print('\nSupported operators: +, -, *, /');
  print('Or run without arguments for interactive mode.');
}
