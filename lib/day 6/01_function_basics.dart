// Day 6: Functions - Basic Function Definition and Calling
// This file covers the fundamentals of defining and calling functions in Dart

void main() {
  print('=== Function Basics ===');

  // Calling functions
  greetUser();

  String message = getWelcomeMessage();
  print(message);

  int result = addNumbers(5, 3);
  print('5 + 3 = $result');

  // Function with return type
  double area = calculateCircleArea(5.0);
  print('Area of circle with radius 5: $area');
}

// Basic function with no parameters and no return value
void greetUser() {
  print('Hello! Welcome to Dart functions.');
}

// Function with return type but no parameters
String getWelcomeMessage() {
  return 'Welcome to Day 6 of Dart learning!';
}

// Function with parameters and return value
int addNumbers(int a, int b) {
  return a + b;
}

// Function with double parameters and return
double calculateCircleArea(double radius) {
  const double pi = 3.14159;
  return pi * radius * radius;
}

// Function that calls other functions
void demonstrateFunctionCalls() {
  print('\n=== Function Calls Demo ===');

  // Functions can call other functions
  int sum = addNumbers(10, 20);
  print('Sum: $sum');

  // Nested function calls
  double circleArea = calculateCircleArea(addNumbers(2, 3).toDouble());
  print('Circle area with radius 5: $circleArea');
}

/*
Key Points:
1. Functions are defined using return_type function_name(parameters) { }
2. void means the function doesn't return anything
3. Functions must be called to execute their code
4. Return values can be stored in variables
5. Functions can call other functions
*/
