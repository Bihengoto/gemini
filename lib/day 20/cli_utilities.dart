// CLI Utility Functions and Helper Classes
import 'dart:io';

/// Utility class for common CLI operations
class CLIUtils {
  /// Get validated string input from user
  static String getStringInput(String prompt, {bool allowEmpty = false}) {
    while (true) {
      stdout.write(prompt);
      String? input = stdin.readLineSync();

      if (input != null && (input.trim().isNotEmpty || allowEmpty)) {
        return input.trim();
      }

      print('Please enter a valid input.');
    }
  }

  /// Get validated numeric input from user
  static double getNumericInput(String prompt) {
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

  /// Get integer input from user
  static int getIntegerInput(String prompt) {
    while (true) {
      stdout.write(prompt);
      String? input = stdin.readLineSync();

      if (input != null) {
        int? number = int.tryParse(input.trim());
        if (number != null) {
          return number;
        }
      }

      print('Please enter a valid integer.');
    }
  }

  /// Get yes/no confirmation from user
  static bool getConfirmation(String prompt) {
    while (true) {
      stdout.write('$prompt (y/n): ');
      String? input = stdin.readLineSync();

      if (input != null) {
        String response = input.trim().toLowerCase();
        if (response == 'y' || response == 'yes') {
          return true;
        } else if (response == 'n' || response == 'no') {
          return false;
        }
      }

      print('Please enter y/yes or n/no.');
    }
  }

  /// Display a menu and get user choice
  static int displayMenu(String title, List<String> options) {
    print('\n$title');
    print('=' * title.length);

    for (int i = 0; i < options.length; i++) {
      print('${i + 1}. ${options[i]}');
    }

    while (true) {
      stdout.write('\nChoose an option (1-${options.length}): ');
      String? input = stdin.readLineSync();

      if (input != null) {
        int? choice = int.tryParse(input.trim());
        if (choice != null && choice >= 1 && choice <= options.length) {
          return choice;
        }
      }

      print('Please enter a number between 1 and ${options.length}.');
    }
  }

  /// Print a formatted header
  static void printHeader(String title) {
    String border = '=' * (title.length + 4);
    print(border);
    print('  $title  ');
    print(border);
  }

  /// Print a formatted section
  static void printSection(String title) {
    print('\n--- $title ---');
  }

  /// Clear the screen (works on most terminals)
  static void clearScreen() {
    if (Platform.isWindows) {
      Process.runSync('cls', [], runInShell: true);
    } else {
      Process.runSync('clear', [], runInShell: true);
    }
  }

  /// Pause execution until user presses Enter
  static void pauseForUser([String message = 'Press Enter to continue...']) {
    stdout.write(message);
    stdin.readLineSync();
  }

  /// Validate email format
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Format number with specified decimal places
  static String formatNumber(double number, [int decimals = 2]) {
    return number.toStringAsFixed(decimals);
  }
}

/// Progress bar utility for long-running operations
class ProgressBar {
  final int total;
  final int width;
  int current = 0;

  ProgressBar(this.total, {this.width = 50});

  void update(int progress) {
    current = progress;
    double percentage = (current / total) * 100;
    int filled = ((current / total) * width).round();

    String bar = '█' * filled + '░' * (width - filled);
    stdout.write(
      '\r[$bar] ${percentage.toStringAsFixed(1)}% ($current/$total)',
    );

    if (current >= total) {
      print(''); // New line when complete
    }
  }

  void increment() {
    update(current + 1);
  }
}

/// Simple logging utility
class Logger {
  static void info(String message) {
    print('[INFO] ${DateTime.now().toString().substring(11, 19)} - $message');
  }

  static void warning(String message) {
    print('[WARN] ${DateTime.now().toString().substring(11, 19)} - $message');
  }

  static void error(String message) {
    stderr.writeln(
      '[ERROR] ${DateTime.now().toString().substring(11, 19)} - $message',
    );
  }

  static void debug(String message) {
    print('[DEBUG] ${DateTime.now().toString().substring(11, 19)} - $message');
  }
}

/// Example usage of CLI utilities
void main() {
  CLIUtils.printHeader('CLI Utilities Demo');

  // Menu example
  List<String> menuOptions = [
    'Test String Input',
    'Test Numeric Input',
    'Test Confirmation',
    'Test Progress Bar',
    'Test Logger',
    'Exit',
  ];

  while (true) {
    int choice = CLIUtils.displayMenu('Main Menu', menuOptions);

    switch (choice) {
      case 1:
        testStringInput();
        break;
      case 2:
        testNumericInput();
        break;
      case 3:
        testConfirmation();
        break;
      case 4:
        testProgressBar();
        break;
      case 5:
        testLogger();
        break;
      case 6:
        print('Goodbye!');
        return;
    }

    CLIUtils.pauseForUser();
  }
}

void testStringInput() {
  CLIUtils.printSection('String Input Test');
  String name = CLIUtils.getStringInput('Enter your name: ');
  String email = CLIUtils.getStringInput('Enter your email: ');

  print('Name: $name');
  print('Email: $email');
  print('Email valid: ${CLIUtils.isValidEmail(email)}');
}

void testNumericInput() {
  CLIUtils.printSection('Numeric Input Test');
  double number = CLIUtils.getNumericInput('Enter a decimal number: ');
  int integer = CLIUtils.getIntegerInput('Enter an integer: ');

  print('Decimal: ${CLIUtils.formatNumber(number)}');
  print('Integer: $integer');
  print('Sum: ${CLIUtils.formatNumber(number + integer)}');
}

void testConfirmation() {
  CLIUtils.printSection('Confirmation Test');
  bool confirmed = CLIUtils.getConfirmation('Do you like Dart programming?');

  if (confirmed) {
    print('Great! Dart is awesome!');
  } else {
    print('That\'s okay, everyone has preferences.');
  }
}

void testProgressBar() {
  CLIUtils.printSection('Progress Bar Test');
  print('Simulating a long-running task...');

  ProgressBar progress = ProgressBar(100);

  for (int i = 0; i <= 100; i++) {
    progress.update(i);
    sleep(Duration(milliseconds: 50)); // Simulate work
  }

  print('Task completed!');
}

void testLogger() {
  CLIUtils.printSection('Logger Test');

  Logger.info('This is an info message');
  Logger.warning('This is a warning message');
  Logger.error('This is an error message');
  Logger.debug('This is a debug message');
}
