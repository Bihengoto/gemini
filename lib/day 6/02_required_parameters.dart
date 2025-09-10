// Day 6: Functions - Required Parameters
// This file covers required parameters in Dart functions

void main() {
  print('=== Required Parameters ===');

  // All parameters are required by default
  displayUserInfo('Alice', 25, 'Engineer');

  // This would cause an error if uncommented:
  // displayUserInfo('Bob'); // Error: missing required parameters

  // Required parameters must be provided in order
  double bmi = calculateBMI(70.5, 1.75);
  print('BMI: ${bmi.toStringAsFixed(2)}');

  // Multiple required parameters
  String fullName = createFullName('John', 'Doe', 'Smith');
  print('Full name: $fullName');

  // Required parameters with different types
  printProductInfo('Laptop', 999.99, true);
}

// Function with multiple required parameters
void displayUserInfo(String name, int age, String profession) {
  print('Name: $name');
  print('Age: $age');
  print('Profession: $profession');
  print('---');
}

// Required parameters with calculations
double calculateBMI(double weight, double height) {
  return weight / (height * height);
}

// Function with three required String parameters
String createFullName(String firstName, String middleName, String lastName) {
  return '$firstName $middleName $lastName';
}

// Mixed parameter types - all required
void printProductInfo(String name, double price, bool inStock) {
  print('Product: $name');
  print('Price: \$${price.toStringAsFixed(2)}');
  print('In Stock: ${inStock ? 'Yes' : 'No'}');
  print('---');
}

// Function that validates required parameters
bool validateLogin(String username, String password) {
  // In real apps, you'd have proper validation
  if (username.isEmpty || password.isEmpty) {
    print('Username and password are required!');
    return false;
  }

  if (username == 'admin' && password == 'password123') {
    print('Login successful!');
    return true;
  }

  print('Invalid credentials!');
  return false;
}

// Example of using the validation function
void testLogin() {
  print('\n=== Login Test ===');
  validateLogin('admin', 'password123');
  validateLogin('user', '');
  validateLogin('admin', 'wrongpass');
}

/*
Key Points about Required Parameters:
1. All parameters are required by default in Dart
2. Must be provided in the exact order they're defined
3. Omitting any required parameter causes a compile error
4. Can have different data types
5. Function won't execute if required parameters are missing
*/
