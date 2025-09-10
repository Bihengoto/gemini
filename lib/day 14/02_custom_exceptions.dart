// Day 14: Custom Exceptions
// Learn how to create and throw custom exceptions

void main() {
  print('=== Custom Exceptions ===\n');

  // Using built-in exceptions
  builtInExceptions();

  print('\n' + '=' * 40 + '\n');

  // Creating and using custom exceptions
  customExceptionExample();

  print('\n' + '=' * 40 + '\n');

  // Advanced custom exception with additional data
  advancedCustomException();
}

/// Using built-in exceptions
void builtInExceptions() {
  print('1. Built-in Exceptions:');

  try {
    validateAge(-5);
  } catch (e) {
    print('Caught: $e');
  }

  try {
    validateEmail('invalid-email');
  } catch (e) {
    print('Caught: $e');
  }
}

void validateAge(int age) {
  if (age < 0) {
    throw ArgumentError('Age cannot be negative: $age');
  }
  if (age > 150) {
    throw RangeError('Age seems unrealistic: $age');
  }
  print('Valid age: $age');
}

void validateEmail(String email) {
  if (!email.contains('@')) {
    throw FormatException('Invalid email format: $email');
  }
  print('Valid email: $email');
}

/// Custom exception classes
class InvalidUserException implements Exception {
  final String message;
  final String username;

  const InvalidUserException(this.message, this.username);

  @override
  String toString() => 'InvalidUserException: $message (User: $username)';
}

class InsufficientFundsException implements Exception {
  final double requestedAmount;
  final double availableBalance;

  const InsufficientFundsException(this.requestedAmount, this.availableBalance);

  @override
  String toString() =>
      'InsufficientFundsException: Requested \$${requestedAmount.toStringAsFixed(2)}, '
      'but only \$${availableBalance.toStringAsFixed(2)} available';
}

/// Using custom exceptions
void customExceptionExample() {
  print('2. Custom Exception Example:');

  try {
    authenticateUser('', 'password123');
  } on InvalidUserException catch (e) {
    print('Authentication failed: $e');
  }

  try {
    withdrawMoney(1000.0, 500.0);
  } on InsufficientFundsException catch (e) {
    print('Transaction failed: $e');
  }
}

void authenticateUser(String username, String password) {
  if (username.isEmpty) {
    throw InvalidUserException('Username cannot be empty', username);
  }
  if (password.length < 8) {
    throw InvalidUserException('Password too short', username);
  }
  print('User authenticated successfully: $username');
}

void withdrawMoney(double amount, double balance) {
  if (amount > balance) {
    throw InsufficientFundsException(amount, balance);
  }
  print('Withdrawal successful: \$${amount.toStringAsFixed(2)}');
}

/// Advanced custom exception with error codes and stack trace
class DatabaseException implements Exception {
  final String message;
  final int errorCode;
  final String? query;
  final StackTrace? stackTrace;

  const DatabaseException(
    this.message,
    this.errorCode, {
    this.query,
    this.stackTrace,
  });

  @override
  String toString() {
    String result = 'DatabaseException [$errorCode]: $message';
    if (query != null) {
      result += '\nQuery: $query';
    }
    return result;
  }
}

void advancedCustomException() {
  print('3. Advanced Custom Exception:');

  try {
    executeQuery('SELECT * FROM non_existent_table');
  } on DatabaseException catch (e, stackTrace) {
    print('Database error occurred: $e');
    print('Stack trace available: ${stackTrace.toString().split('\n').first}');
  }
}

void executeQuery(String query) {
  // Simulate database error
  throw DatabaseException(
    'Table does not exist',
    404,
    query: query,
    stackTrace: StackTrace.current,
  );
}
