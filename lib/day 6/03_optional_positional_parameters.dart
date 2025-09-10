// Day 6: Functions - Optional Positional Parameters
// This file covers optional positional parameters using square brackets []

void main() {
  print('=== Optional Positional Parameters ===');

  // Calling with all parameters
  greetPerson('Alice', 'Good morning', '!');

  // Calling with some optional parameters omitted
  greetPerson('Bob', 'Hello');
  greetPerson('Charlie');

  // Mathematical functions with optional parameters
  print('Power of 2^3: ${power(2, 3)}');
  print('Power of 5^2: ${power(5)}'); // Uses default exponent of 2

  // String formatting with optional parameters
  print(formatMessage('Welcome'));
  print(formatMessage('Error', 'red'));
  print(formatMessage('Success', 'green', true));
}

// Function with optional positional parameters
// Parameters in [] are optional and positional
void greetPerson(
  String name, [
  String greeting = 'Hi',
  String punctuation = '.',
]) {
  print('$greeting $name$punctuation');
}

// Mathematical function with optional parameter
int power(int base, [int exponent = 2]) {
  int result = 1;
  for (int i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}

// String formatting with multiple optional parameters
String formatMessage(
  String message, [
  String color = 'black',
  bool bold = false,
]) {
  String formatted = message;

  if (bold) {
    formatted = '**$formatted**';
  }

  return '[$color] $formatted';
}

// Function with mixed required and optional parameters
void createUser(
  String username,
  String email, [
  int age = 18,
  String role = 'user',
]) {
  print('Creating user:');
  print('  Username: $username');
  print('  Email: $email');
  print('  Age: $age');
  print('  Role: $role');
  print('---');
}

// Example with null as optional parameter
String buildUrl(String domain, [String? path, int? port]) {
  String url = 'https://$domain';

  if (port != null) {
    url += ':$port';
  }

  if (path != null) {
    url += '/$path';
  }

  return url;
}

void demonstrateOptionalParameters() {
  print('\n=== More Examples ===');

  // User creation examples
  createUser('john_doe', 'john@email.com');
  createUser('admin', 'admin@email.com', 30);
  createUser('manager', 'manager@email.com', 35, 'manager');

  // URL building examples
  print('URL 1: ${buildUrl('example.com')}');
  print('URL 2: ${buildUrl('api.example.com', 'users')}');
  print('URL 3: ${buildUrl('localhost', 'api/users', 3000)}');
}

/*
Key Points about Optional Positional Parameters:
1. Defined using square brackets []
2. Must come after required parameters
3. Can have default values
4. Called in positional order
5. Can be omitted from right to left
6. Cannot skip middle parameters (must provide in order)
*/
