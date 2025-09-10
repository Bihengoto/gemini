// Day 6: Functions - Practice Exercises
// This file contains practice exercises for functions

void main() {
  print('=== Function Practice Exercises ===');

  // Exercise 1: Basic sum function
  print('1. Sum of 10 and 20: ${sum(10, 20)}');

  // Exercise 2: Enhanced calculator
  print('2. Calculator examples:');
  print('   Add: ${calculate(15, 5, 'add')}');
  print('   Subtract: ${calculate(15, 5, 'subtract')}');
  print('   Multiply: ${calculate(15, 5, 'multiply')}');
  print('   Divide: ${calculate(15, 5, 'divide')}');

  // Exercise 3: String manipulation
  print('3. String functions:');
  print('   Reverse: ${reverseString('hello')}');
  print('   Word count: ${countWords('Hello world from Dart')}');
  print('   Capitalize: ${capitalizeWords('hello world')}');

  // Exercise 4: List operations
  print('4. List operations:');
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print('   Sum of list: ${sumList(numbers)}');
  print('   Average: ${average(numbers)}');
  print('   Even numbers: ${filterEven(numbers)}');

  // Exercise 5: User management
  print('5. User management:');
  createUserProfile('Alice', email: 'alice@email.com', age: 25);
  createUserProfile('Bob', email: 'bob@email.com');

  // Exercise 6: Advanced exercises
  print('6. Advanced exercises:');
  print('   Fibonacci(10): ${fibonacci(10)}');
  print('   Is prime(17): ${isPrime(17)}');
  print('   GCD(48, 18): ${gcd(48, 18)}');

  runAllTests();
}

// Exercise 1: Basic sum function (as requested)
int sum(int a, int b) => a + b;

// Exercise 2: Enhanced calculator with multiple operations
double calculate(double a, double b, String operation) {
  switch (operation.toLowerCase()) {
    case 'add':
      return a + b;
    case 'subtract':
      return a - b;
    case 'multiply':
      return a * b;
    case 'divide':
      return b != 0 ? a / b : double.infinity;
    default:
      throw ArgumentError('Invalid operation: $operation');
  }
}

// Exercise 3: String manipulation functions
String reverseString(String text) {
  return text.split('').reversed.join('');
}

int countWords(String text) => text.trim().split(' ').length;

String capitalizeWords(String text) {
  return text
      .split(' ')
      .map(
        (word) =>
            word.isEmpty
                ? word
                : word[0].toUpperCase() + word.substring(1).toLowerCase(),
      )
      .join(' ');
}

// Exercise 4: List operations
int sumList(List<int> numbers) {
  int total = 0;
  for (int number in numbers) {
    total += number;
  }
  return total;
}

double average(List<int> numbers) {
  if (numbers.isEmpty) return 0;
  return sumList(numbers) / numbers.length;
}

List<int> filterEven(List<int> numbers) {
  List<int> evenNumbers = [];
  for (int number in numbers) {
    if (number % 2 == 0) {
      evenNumbers.add(number);
    }
  }
  return evenNumbers;
}

// Exercise 5: User management with named parameters
void createUserProfile(
  String name, {
  required String email,
  int age = 18,
  String role = 'user',
  bool isActive = true,
}) {
  print('   User Profile Created:');
  print('     Name: $name');
  print('     Email: $email');
  print('     Age: $age');
  print('     Role: $role');
  print('     Active: $isActive');
  print('   ---');
}

// Exercise 6: Advanced mathematical functions
int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

bool isPrime(int number) {
  if (number < 2) return false;
  for (int i = 2; i <= number ~/ 2; i++) {
    if (number % i == 0) return false;
  }
  return true;
}

int gcd(int a, int b) {
  while (b != 0) {
    int temp = b;
    b = a % b;
    a = temp;
  }
  return a;
}

// Bonus: Function composition and higher-order concepts
int applyOperation(int a, int b, int Function(int, int) operation) {
  return operation(a, b);
}

List<int> transformList(List<int> numbers, int Function(int) transformer) {
  return numbers.map(transformer).toList();
}

// Test functions to verify our implementations
void runAllTests() {
  print('\n=== Running Tests ===');

  // Test sum function
  assert(sum(5, 3) == 8, 'Sum test failed');
  print('✓ Sum function test passed');

  // Test calculator
  assert(calculate(10, 5, 'add') == 15, 'Calculator add test failed');
  assert(calculate(10, 5, 'multiply') == 50, 'Calculator multiply test failed');
  print('✓ Calculator function tests passed');

  // Test string functions
  assert(reverseString('hello') == 'olleh', 'Reverse string test failed');
  assert(countWords('hello world') == 2, 'Count words test failed');
  print('✓ String function tests passed');

  // Test list functions
  assert(sumList([1, 2, 3, 4, 5]) == 15, 'Sum list test failed');
  assert(filterEven([1, 2, 3, 4, 5]).length == 2, 'Filter even test failed');
  print('✓ List function tests passed');

  // Test advanced functions
  assert(fibonacci(5) == 5, 'Fibonacci test failed');
  assert(isPrime(7) == true, 'Prime test failed');
  assert(gcd(48, 18) == 6, 'GCD test failed');
  print('✓ Advanced function tests passed');

  print('All tests completed successfully! 🎉');
}

/*
Practice Exercise Solutions:

1. Basic sum function: ✓ Implemented as requested
2. Calculator with multiple operations: ✓ Enhanced version
3. String manipulation: ✓ Multiple string functions
4. List operations: ✓ Sum, average, filtering
5. User management: ✓ Named parameters with defaults
6. Advanced math: ✓ Fibonacci, prime check, GCD

Key Learning Points:
- Functions can have different parameter types
- Arrow syntax works great for simple operations
- Named parameters improve code readability
- Functions can call other functions
- Testing functions helps verify correctness
- Higher-order functions enable powerful patterns
*/
