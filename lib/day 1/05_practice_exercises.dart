// Practice Exercises for Day 1

void main() {
  print('=== Day 1 Practice Exercises ===\n');

  // Exercise 1: Personal Introduction
  exercise1();

  // Exercise 2: Simple Calculator
  exercise2();

  // Exercise 3: Fun with Strings
  exercise3();

  // Exercise 4: Working with Variables
  exercise4();
}

// Exercise 1: Create a personal introduction
void exercise1() {
  print('Exercise 1: Personal Introduction');
  print('--------------------------------');

  String name = 'Your Name';
  int age = 25;
  String hobby = 'Programming';

  print('Hi! My name is $name');
  print('I am $age years old');
  print('I love $hobby');
  print('I am learning Dart programming!\n');
}

// Exercise 2: Simple calculator operations
void exercise2() {
  print('Exercise 2: Simple Calculator');
  print('-----------------------------');

  int num1 = 15;
  int num2 = 7;

  print('Number 1: $num1');
  print('Number 2: $num2');
  print('Addition: $num1 + $num2 = ${num1 + num2}');
  print('Subtraction: $num1 - $num2 = ${num1 - num2}');
  print('Multiplication: $num1 × $num2 = ${num1 * num2}');
  print('Division: $num1 ÷ $num2 = ${num1 / num2}');
  print('');
}

// Exercise 3: String manipulation and formatting
void exercise3() {
  print('Exercise 3: Fun with Strings');
  print('----------------------------');

  String firstName = 'John';
  String lastName = 'Doe';
  String fullName = '$firstName $lastName';

  print('First Name: $firstName');
  print('Last Name: $lastName');
  print('Full Name: $fullName');
  print('Name Length: ${fullName.length} characters');
  print('Uppercase: ${fullName.toUpperCase()}');
  print('Lowercase: ${fullName.toLowerCase()}');
  print('');
}

// Exercise 4: Working with different data types
void exercise4() {
  print('Exercise 4: Data Types');
  print('---------------------');

  // Different data types
  String text = 'Dart is awesome!';
  int wholeNumber = 100;
  double decimalNumber = 99.99;
  bool isTrue = true;

  print('String: $text');
  print('Integer: $wholeNumber');
  print('Double: $decimalNumber');
  print('Boolean: $isTrue');

  // List example
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  print('Fruits: $fruits');
  print('First fruit: ${fruits[0]}');

  print('\n🎯 Great job completing Day 1 exercises!');
}
