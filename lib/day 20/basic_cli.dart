// Basic Command-Line Application Example
import 'dart:io';

void main(List<String> arguments) {
  print('=== Basic CLI Application ===');

  // Display command-line arguments
  if (arguments.isNotEmpty) {
    print('Command-line arguments received:');
    for (int i = 0; i < arguments.length; i++) {
      print('  Argument $i: ${arguments[i]}');
    }
  } else {
    print('No command-line arguments provided.');
    print('Try running: dart run basic_cli.dart hello world 123');
  }

  // Simple greeting
  stdout.write('Enter your name: ');
  String? name = stdin.readLineSync();

  if (name != null && name.isNotEmpty) {
    print('Hello, $name! Welcome to Dart CLI programming.');
  } else {
    print('Hello, Anonymous! Welcome to Dart CLI programming.');
  }

  // Demonstrate different output methods
  print('\nDifferent output methods:');
  stdout.write('This is stdout.write() - no newline');
  stdout.writeln(' - and this continues on the same line');
  print('This is print() - automatic newline');

  // Exit with success code
  exit(0);
}
