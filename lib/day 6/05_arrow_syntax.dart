// Day 6: Functions - Arrow Syntax (=>)
// This file covers arrow syntax for single-expression functions

void main() {
  print('=== Arrow Syntax Functions ===');

  // Using arrow functions
  print('Square of 5: ${square(5)}');
  print('Cube of 3: ${cube(3)}');

  // String operations
  print('Uppercase: ${toUpperCase('hello world')}');
  print('Is even: ${isEven(8)}');
  print('Is odd: ${isOdd(7)}');

  // Mathematical operations
  print('Circle area: ${circleArea(5)}');
  print('Max of 10 and 15: ${max(10, 15)}');
  print('Min of 10 and 15: ${min(10, 15)}');

  // Greeting functions
  greetUser('Alice');
  sayGoodbye('Bob');

  demonstrateArrowFunctions();
}

// Basic arrow functions
int square(int n) => n * n;
int cube(int n) => n * n * n;

// String operations with arrow syntax
String toUpperCase(String text) => text.toUpperCase();
bool isEven(int number) => number % 2 == 0;
bool isOdd(int number) => number % 2 != 0;

// Mathematical operations
double circleArea(double radius) => 3.14159 * radius * radius;
int max(int a, int b) => a > b ? a : b;
int min(int a, int b) => a < b ? a : b;

// Void functions with arrow syntax
void greetUser(String name) => print('Hello, $name!');
void sayGoodbye(String name) => print('Goodbye, $name!');

// Arrow functions with named parameters
double calculateTip({required double amount, double rate = 0.15}) =>
    amount * rate;

String formatCurrency({required double amount, String symbol = '\$'}) =>
    '$symbol${amount.toStringAsFixed(2)}';

// Arrow functions with optional positional parameters
String createMessage(String text, [String prefix = 'Info']) =>
    '[$prefix] $text';

// More complex single expressions
bool isValidEmail(String email) =>
    email.contains('@') && email.contains('.') && email.length > 5;

int factorial(int n) => n <= 1 ? 1 : n * factorial(n - 1);

// Arrow functions returning different types
List<int> getRange(int start, int end) =>
    List.generate(end - start + 1, (index) => start + index);

Map<String, dynamic> createUser(String name, int age) => {
  'name': name,
  'age': age,
  'createdAt': DateTime.now().toString(),
};

void demonstrateArrowFunctions() {
  print('\n=== More Arrow Function Examples ===');

  // Tip calculation
  double tip = calculateTip(amount: 50.0, rate: 0.18);
  print('Tip: ${formatCurrency(amount: tip)}');

  // Message formatting
  print(createMessage('System started'));
  print(createMessage('Error occurred', 'ERROR'));

  // Email validation
  print('Valid email test: ${isValidEmail('user@example.com')}');
  print('Invalid email test: ${isValidEmail('invalid-email')}');

  // Factorial
  print('Factorial of 5: ${factorial(5)}');

  // Range generation
  List<int> numbers = getRange(1, 5);
  print('Range 1-5: $numbers');

  // User creation
  Map<String, dynamic> user = createUser('John', 25);
  print('User: $user');
}

// Comparison: Regular vs Arrow syntax
// Regular function:
int addRegular(int a, int b) {
  return a + b;
}

// Arrow function (equivalent):
int addArrow(int a, int b) => a + b;

// Regular function with multiple statements (cannot use arrow):
void processDataRegular(List<int> data) {
  print('Processing ${data.length} items');
  for (int item in data) {
    print('Item: $item');
  }
  print('Processing complete');
}

// This CANNOT be converted to arrow syntax because it has multiple statements

/*
Key Points about Arrow Syntax:
1. Use => for single-expression functions
2. No need for 'return' keyword - the expression is automatically returned
3. More concise and readable for simple functions
4. Can only be used with single expressions
5. Works with all parameter types (required, optional, named)
6. Great for simple calculations, transformations, and getters
7. Cannot be used for functions with multiple statements
*/
