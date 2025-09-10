// Experimenting with print() function and different messages

void main() {
  // Basic print statements
  print('Hello, World!');
  print('Welcome to Dart programming!');

  // Printing numbers
  print(42);
  print(3.14159);

  // Printing expressions
  print(10 + 5);
  print('The result is: ${10 * 3}');

  // Multiple lines
  print('Line 1');
  print('Line 2');
  print('Line 3');

  // Empty line
  print('');

  // Special characters
  print('Hello\nWorld'); // \n creates a new line
  print('Tab\tSeparated'); // \t creates a tab
  print('Quote: "Hello Dart"');
  print('Single quote: \'Hello Dart\'');

  // String interpolation
  String name = 'Dart';
  print('Hello, $name!');
  print('Learning $name is fun!');

  // Printing different data types
  bool isLearning = true;
  print('Am I learning Dart? $isLearning');

  List<String> languages = ['Dart', 'Flutter', 'JavaScript'];
  print('Programming languages: $languages');

  // Mathematical operations
  print('Addition: ${5 + 3}');
  print('Subtraction: ${10 - 4}');
  print('Multiplication: ${6 * 7}');
  print('Division: ${15 / 3}');

  // Fun messages
  print('🎉 Congratulations on your first Dart program!');
  print('Keep coding and have fun! 💻');
}
