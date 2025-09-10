// Advanced Command-Line Calculator with Enhanced Features
import 'dart:io';
import 'dart:math' as math;

void main(List<String> arguments) {
  print('=== Advanced Command-Line Calculator ===\n');

  if (arguments.isNotEmpty && arguments[0] == '--help') {
    printHelp();
    return;
  }

  if (arguments.length >= 3) {
    calculateFromArguments(arguments);
  } else {
    advancedInteractiveCalculator();
  }
}

void calculateFromArguments(List<String> arguments) {
  print('Command-line mode...');

  try {
    double num1 = double.parse(arguments[0]);
    String operator = arguments[1];

    if (isUnaryOperator(operator)) {
      double? result = performUnaryOperation(num1, operator);
      if (result != null) {
        print('$operator($num1) = $result');
      } else {
        print('Error: Invalid unary operator "$operator"');
      }
    } else {
      if (arguments.length < 3) {
        print('Error: Binary operator requires two numbers');
        printHelp();
        return;
      }

      double num2 = double.parse(arguments[2]);
      double? result = performBinaryOperation(num1, operator, num2);

      if (result != null) {
        print('$num1 $operator $num2 = $result');
      } else {
        print('Error: Invalid operator "$operator"');
      }
    }
  } catch (e) {
    print('Error: Invalid number format');
    printHelp();
  }
}

void advancedInteractiveCalculator() {
  print('Advanced Interactive Calculator');
  print('Type "help" for available operations');
  print('Type "quit" or "exit" to stop\n');

  List<double> history = [];

  while (true) {
    try {
      stdout.write('Calculator> ');
      String? input = stdin.readLineSync();

      if (input == null ||
          input.toLowerCase() == 'quit' ||
          input.toLowerCase() == 'exit') {
        print('Goodbye!');
        break;
      }

      input = input.trim().toLowerCase();

      if (input == 'help') {
        printOperations();
        continue;
      }

      if (input == 'history') {
        printHistory(history);
        continue;
      }

      if (input == 'clear') {
        history.clear();
        print('History cleared.');
        continue;
      }

      // Parse and execute calculation
      double? result = parseAndCalculate(input);

      if (result != null) {
        print('Result: $result');
        history.add(result);

        // Keep only last 10 results
        if (history.length > 10) {
          history.removeAt(0);
        }
      }

      print('');
    } catch (e) {
      print('Error: Invalid input. Type "help" for usage.\n');
    }
  }
}

double? parseAndCalculate(String input) {
  // Handle simple expressions like "5 + 3" or "sqrt 16"
  List<String> parts = input.split(' ');

  if (parts.length == 1) {
    // Single number
    return double.tryParse(parts[0]);
  } else if (parts.length == 2) {
    // Unary operation like "sqrt 16"
    String operator = parts[0];
    double? num = double.tryParse(parts[1]);

    if (num != null) {
      return performUnaryOperation(num, operator);
    }
  } else if (parts.length == 3) {
    // Binary operation like "5 + 3"
    double? num1 = double.tryParse(parts[0]);
    String operator = parts[1];
    double? num2 = double.tryParse(parts[2]);

    if (num1 != null && num2 != null) {
      return performBinaryOperation(num1, operator, num2);
    }
  }

  return null;
}

double? performBinaryOperation(double num1, String operator, double num2) {
  switch (operator) {
    case '+':
      return num1 + num2;
    case '-':
      return num1 - num2;
    case '*':
    case 'x':
      return num1 * num2;
    case '/':
      if (num2 == 0) {
        print('Error: Division by zero');
        return null;
      }
      return num1 / num2;
    case '%':
    case 'mod':
      return num1 % num2;
    case '^':
    case 'pow':
      return math.pow(num1, num2).toDouble();
    default:
      return null;
  }
}

double? performUnaryOperation(double num, String operator) {
  switch (operator) {
    case 'sqrt':
      if (num < 0) {
        print('Error: Cannot calculate square root of negative number');
        return null;
      }
      return math.sqrt(num);
    case 'sin':
      return math.sin(num);
    case 'cos':
      return math.cos(num);
    case 'tan':
      return math.tan(num);
    case 'log':
      if (num <= 0) {
        print('Error: Cannot calculate logarithm of non-positive number');
        return null;
      }
      return math.log(num);
    case 'abs':
      return num.abs();
    case 'ceil':
      return num.ceilToDouble();
    case 'floor':
      return num.floorToDouble();
    case 'round':
      return num.roundToDouble();
    default:
      return null;
  }
}

bool isUnaryOperator(String operator) {
  return [
    'sqrt',
    'sin',
    'cos',
    'tan',
    'log',
    'abs',
    'ceil',
    'floor',
    'round',
  ].contains(operator);
}

void printHistory(List<double> history) {
  if (history.isEmpty) {
    print('No calculation history.');
    return;
  }

  print('Recent calculations:');
  for (int i = 0; i < history.length; i++) {
    print('  ${i + 1}. ${history[i]}');
  }
}

void printOperations() {
  print('Available operations:');
  print('');
  print('Binary operations (format: num1 operator num2):');
  print('  +       Addition');
  print('  -       Subtraction');
  print('  * or x  Multiplication');
  print('  /       Division');
  print('  %       Modulo');
  print('  ^ or pow Power');
  print('');
  print('Unary operations (format: operator num):');
  print('  sqrt    Square root');
  print('  sin     Sine');
  print('  cos     Cosine');
  print('  tan     Tangent');
  print('  log     Natural logarithm');
  print('  abs     Absolute value');
  print('  ceil    Ceiling');
  print('  floor   Floor');
  print('  round   Round');
  print('');
  print('Commands:');
  print('  help    Show this help');
  print('  history Show calculation history');
  print('  clear   Clear history');
  print('  quit    Exit calculator');
}

void printHelp() {
  print('Advanced Calculator Help');
  print('');
  print('Usage:');
  print('  dart run advanced_calculator.dart [arguments]');
  print('');
  print('Examples:');
  print('  dart run advanced_calculator.dart 10 + 5');
  print('  dart run advanced_calculator.dart sqrt 16');
  print('  dart run advanced_calculator.dart 2 ^ 3');
  print('');
  print('Run without arguments for interactive mode.');
  print('Use --help to show this message.');
}
