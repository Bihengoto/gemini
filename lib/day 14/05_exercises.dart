// Day 14: Error Handling Exercises
// Practice problems to master exception handling

void main() {
  print('=== Error Handling Exercises ===\n');

  // Run all exercises
  exercise1();
  print('\n' + '=' * 50 + '\n');

  exercise2();
  print('\n' + '=' * 50 + '\n');

  exercise3();
  print('\n' + '=' * 50 + '\n');

  exercise4();
  print('\n' + '=' * 50 + '\n');

  exercise5();
}

/// Exercise 1: Basic Exception Handling
/// Create a function that divides two numbers and handles division by zero
void exercise1() {
  print('Exercise 1: Safe Division Function');
  print('Create a function that safely divides two numbers\n');

  // Test cases
  List<List<double>> testCases = [
    [10, 2], // Normal case
    [15, 3], // Normal case
    [10, 0], // Division by zero
    [-8, 2], // Negative numbers
    [0, 5], // Zero dividend
  ];

  for (var testCase in testCases) {
    double a = testCase[0];
    double b = testCase[1];

    try {
      double result = safeDivision(a, b);
      print('$a ÷ $b = $result');
    } catch (e) {
      print('Error dividing $a by $b: $e');
    }
  }
}

/// TODO: Implement this function
/// Should throw an appropriate exception for division by zero
/// Should return the result for valid divisions
double safeDivision(double a, double b) {
  // Your implementation here
  if (b == 0) {
    throw ArgumentError('Division by zero is not allowed');
  }
  return a / b;
}

/// Exercise 2: Custom Exception for Bank Account
/// Create a BankAccount class with custom exceptions
void exercise2() {
  print('Exercise 2: Bank Account with Custom Exceptions');
  print('Implement a bank account with withdrawal and deposit validation\n');

  BankAccount account = BankAccount('John Doe', 1000.0);

  // Test scenarios
  List<Map<String, dynamic>> transactions = [
    {'type': 'deposit', 'amount': 500.0},
    {'type': 'withdraw', 'amount': 200.0},
    {'type': 'withdraw', 'amount': 2000.0}, // Insufficient funds
    {'type': 'deposit', 'amount': -100.0}, // Negative deposit
    {'type': 'withdraw', 'amount': -50.0}, // Negative withdrawal
  ];

  for (var transaction in transactions) {
    try {
      if (transaction['type'] == 'deposit') {
        account.deposit(transaction['amount']);
      } else {
        account.withdraw(transaction['amount']);
      }
      print(
        '✓ ${transaction['type'].toString().toUpperCase()}: \$${transaction['amount']} - Balance: \$${account.balance}',
      );
    } on InsufficientFundsException catch (e) {
      print('✗ Transaction failed: $e');
    } on InvalidAmountException catch (e) {
      print('✗ Invalid amount: $e');
    } catch (e) {
      print('✗ Unexpected error: $e');
    }
  }
}

/// Custom exceptions for banking operations
class InsufficientFundsException implements Exception {
  final double requestedAmount;
  final double availableBalance;

  InsufficientFundsException(this.requestedAmount, this.availableBalance);

  @override
  String toString() =>
      'Insufficient funds: Requested \$${requestedAmount.toStringAsFixed(2)}, '
      'Available \$${availableBalance.toStringAsFixed(2)}';
}

class InvalidAmountException implements Exception {
  final double amount;
  final String operation;

  InvalidAmountException(this.amount, this.operation);

  @override
  String toString() =>
      'Invalid amount for $operation: \$${amount.toStringAsFixed(2)} (must be positive)';
}

/// TODO: Complete the BankAccount class implementation
class BankAccount {
  final String accountHolder;
  double _balance;

  BankAccount(this.accountHolder, this._balance);

  double get balance => _balance;

  void deposit(double amount) {
    // TODO: Implement deposit with validation
    // Throw InvalidAmountException for negative amounts
    if (amount <= 0) {
      throw InvalidAmountException(amount, 'deposit');
    }
    _balance += amount;
  }

  void withdraw(double amount) {
    // TODO: Implement withdrawal with validation
    // Throw InvalidAmountException for negative amounts
    // Throw InsufficientFundsException if balance is insufficient
    if (amount <= 0) {
      throw InvalidAmountException(amount, 'withdrawal');
    }
    if (amount > _balance) {
      throw InsufficientFundsException(amount, _balance);
    }
    _balance -= amount;
  }
}

/// Exercise 3: File Processing with Error Recovery
/// Create a function that processes multiple files with error recovery
void exercise3() {
  print('Exercise 3: File Processing with Error Recovery');
  print('Process multiple files and handle various file-related errors\n');

  List<String> filePaths = [
    'gemini/lib/day 14/data1.txt',
    'gemini/lib/day 14/data2.txt',
    'gemini/lib/day 14/nonexistent.txt',
    'gemini/lib/day 14/data3.txt',
  ];

  FileProcessor processor = FileProcessor();
  Map<String, String> results = processor.processFiles(filePaths);

  print('Processing Results:');
  results.forEach((file, result) {
    print('$file: $result');
  });
}

/// TODO: Complete the FileProcessor class
class FileProcessor {
  Map<String, String> processFiles(List<String> filePaths) {
    Map<String, String> results = {};

    for (String filePath in filePaths) {
      try {
        String content = _readFile(filePath);
        results[filePath] = 'Success: ${content.length} characters';
      } on FileNotFoundException catch (e) {
        results[filePath] = 'File not found: ${e.message}';
      } on PermissionDeniedException catch (e) {
        results[filePath] = 'Permission denied: ${e.message}';
      } catch (e) {
        results[filePath] = 'Unexpected error: $e';
      }
    }

    return results;
  }

  String _readFile(String filePath) {
    // Simulate file reading with various error conditions
    if (filePath.contains('nonexistent')) {
      throw FileNotFoundException('File does not exist', filePath);
    }
    if (filePath.contains('protected')) {
      throw PermissionDeniedException('Access denied', filePath);
    }

    // Simulate successful file reading
    return 'Sample content from $filePath';
  }
}

/// Custom file-related exceptions
class FileNotFoundException implements Exception {
  final String message;
  final String filePath;

  FileNotFoundException(this.message, this.filePath);

  @override
  String toString() => 'FileNotFoundException: $message ($filePath)';
}

class PermissionDeniedException implements Exception {
  final String message;
  final String filePath;

  PermissionDeniedException(this.message, this.filePath);

  @override
  String toString() => 'PermissionDeniedException: $message ($filePath)';
}

/// Exercise 4: Input Validation Chain
/// Create a user registration system with comprehensive validation
void exercise4() {
  print('Exercise 4: User Registration with Validation Chain');
  print('Validate user registration data with multiple validation rules\n');

  List<Map<String, String>> userRegistrations = [
    {
      'username': 'john_doe',
      'email': 'john@example.com',
      'password': 'SecurePass123!',
      'age': '25',
    },
    {
      'username': 'ab', // Too short
      'email': 'john@example.com',
      'password': 'SecurePass123!',
      'age': '25',
    },
    {
      'username': 'jane_smith',
      'email': 'invalid-email', // Invalid format
      'password': 'SecurePass123!',
      'age': '30',
    },
    {
      'username': 'bob_wilson',
      'email': 'bob@example.com',
      'password': '123', // Too weak
      'age': '28',
    },
    {
      'username': 'alice_brown',
      'email': 'alice@example.com',
      'password': 'StrongPassword456!',
      'age': '17', // Too young
    },
  ];

  UserValidator validator = UserValidator();

  for (int i = 0; i < userRegistrations.length; i++) {
    print('Validating user ${i + 1}:');
    try {
      validator.validateRegistration(userRegistrations[i]);
      print('✓ Registration valid');
    } on ValidationException catch (e) {
      print('✗ Validation failed: $e');
    }
    print('');
  }
}

/// TODO: Complete the UserValidator class
class UserValidator {
  void validateRegistration(Map<String, String> userData) {
    // TODO: Implement validation chain
    // Validate username, email, password, and age
    // Throw ValidationException with appropriate field and message

    _validateUsername(userData['username']);
    _validateEmail(userData['email']);
    _validatePassword(userData['password']);
    _validateAge(userData['age']);
  }

  void _validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      throw ValidationException('username', 'Username is required');
    }
    if (username.length < 3) {
      throw ValidationException(
        'username',
        'Username must be at least 3 characters',
      );
    }
    if (username.length > 20) {
      throw ValidationException(
        'username',
        'Username must be less than 20 characters',
      );
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      throw ValidationException(
        'username',
        'Username can only contain letters, numbers, and underscores',
      );
    }
  }

  void _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      throw ValidationException('email', 'Email is required');
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      throw ValidationException('email', 'Invalid email format');
    }
  }

  void _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      throw ValidationException('password', 'Password is required');
    }
    if (password.length < 8) {
      throw ValidationException(
        'password',
        'Password must be at least 8 characters',
      );
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(password)) {
      throw ValidationException(
        'password',
        'Password must contain at least one lowercase letter',
      );
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      throw ValidationException(
        'password',
        'Password must contain at least one uppercase letter',
      );
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(password)) {
      throw ValidationException(
        'password',
        'Password must contain at least one number',
      );
    }
    if (!RegExp(r'(?=.*[!@#$%^&*])').hasMatch(password)) {
      throw ValidationException(
        'password',
        'Password must contain at least one special character',
      );
    }
  }

  void _validateAge(String? ageStr) {
    if (ageStr == null || ageStr.isEmpty) {
      throw ValidationException('age', 'Age is required');
    }

    int age;
    try {
      age = int.parse(ageStr);
    } catch (e) {
      throw ValidationException('age', 'Age must be a valid number');
    }

    if (age < 18) {
      throw ValidationException('age', 'Must be at least 18 years old');
    }
    if (age > 120) {
      throw ValidationException('age', 'Age must be realistic (under 120)');
    }
  }
}

/// Exercise 5: Async Error Handling (Bonus)
/// Handle errors in asynchronous operations
void exercise5() {
  print('Exercise 5: Async Error Handling');
  print('Handle errors in asynchronous operations\n');

  // Note: This is a simplified sync version for demonstration
  // In real async code, you would use Future<T> and async/await

  ApiClient client = ApiClient();

  List<String> endpoints = [
    '/users',
    '/posts',
    '/invalid-endpoint',
    '/timeout-endpoint',
  ];

  for (String endpoint in endpoints) {
    try {
      String response = client.fetchData(endpoint);
      print('✓ $endpoint: $response');
    } on ApiException catch (e) {
      print('✗ API Error for $endpoint: $e');
    } on TimeoutException catch (e) {
      print('✗ Timeout for $endpoint: $e');
    } catch (e) {
      print('✗ Unexpected error for $endpoint: $e');
    }
  }
}

/// Simulated API client with error handling
class ApiClient {
  String fetchData(String endpoint) {
    // Simulate different API responses
    switch (endpoint) {
      case '/users':
        return 'User data retrieved successfully';
      case '/posts':
        return 'Posts data retrieved successfully';
      case '/invalid-endpoint':
        throw ApiException('Endpoint not found', 404);
      case '/timeout-endpoint':
        throw TimeoutException('Request timed out', Duration(seconds: 30));
      default:
        throw ApiException('Unknown endpoint', 400);
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException [$statusCode]: $message';
}

// Reusing TimeoutException from previous example
