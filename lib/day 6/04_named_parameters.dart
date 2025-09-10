// Day 6: Functions - Named Parameters
// This file covers named parameters using curly braces {}

void main() {
  print('=== Named Parameters ===');

  // Named parameters can be called in any order
  createAccount(username: 'alice123', email: 'alice@email.com', age: 25);

  // Different order - same result
  createAccount(age: 30, username: 'bob456', email: 'bob@email.com');

  // Optional named parameters can be omitted
  createAccount(username: 'charlie', email: 'charlie@email.com');

  // Required named parameters must be provided
  sendEmail(to: 'user@email.com', subject: 'Welcome!', body: 'Hello there!');

  // Using named parameters for clarity
  drawRectangle(width: 100, height: 50, color: 'blue', filled: true);
  drawRectangle(height: 75, width: 150, filled: false, color: 'red');
}

// Function with optional named parameters
void createAccount({
  required String username,
  required String email,
  int age = 18,
  String role = 'user',
  bool isActive = true,
}) {
  print('Account created:');
  print('  Username: $username');
  print('  Email: $email');
  print('  Age: $age');
  print('  Role: $role');
  print('  Active: $isActive');
  print('---');
}

// Function with all required named parameters
void sendEmail({
  required String to,
  required String subject,
  required String body,
  String? from,
  bool isHtml = false,
}) {
  print('Sending email:');
  print('  To: $to');
  print('  From: ${from ?? 'system@email.com'}');
  print('  Subject: $subject');
  print('  HTML: $isHtml');
  print('  Body: $body');
  print('---');
}

// Function demonstrating named parameters for clarity
void drawRectangle({
  required double width,
  required double height,
  String color = 'black',
  bool filled = false,
  double x = 0,
  double y = 0,
}) {
  print('Drawing rectangle:');
  print('  Position: ($x, $y)');
  print('  Size: ${width}x$height');
  print('  Color: $color');
  print('  Filled: $filled');
  print('---');
}

// Mixed positional and named parameters
void processOrder(
  String orderId, {
  required String customerName,
  double discount = 0.0,
  bool expressShipping = false,
  String? notes,
}) {
  print('Processing order: $orderId');
  print('  Customer: $customerName');
  print('  Discount: ${discount * 100}%');
  print('  Express: $expressShipping');
  if (notes != null) {
    print('  Notes: $notes');
  }
  print('---');
}

// Function returning a value with named parameters
double calculatePrice({
  required double basePrice,
  double taxRate = 0.1,
  double discount = 0.0,
  bool includeTax = true,
}) {
  double price = basePrice - (basePrice * discount);

  if (includeTax) {
    price += price * taxRate;
  }

  return price;
}

void demonstrateNamedParameters() {
  print('\n=== More Named Parameter Examples ===');

  // Mixed parameters
  processOrder('ORD-001', customerName: 'John Doe');
  processOrder(
    'ORD-002',
    customerName: 'Jane Smith',
    discount: 0.15,
    expressShipping: true,
    notes: 'Handle with care',
  );

  // Price calculations
  double price1 = calculatePrice(basePrice: 100.0);
  double price2 = calculatePrice(
    basePrice: 100.0,
    discount: 0.2,
    taxRate: 0.15,
  );

  print('Price 1: \$${price1.toStringAsFixed(2)}');
  print('Price 2: \$${price2.toStringAsFixed(2)}');
}

/*
Key Points about Named Parameters:
1. Defined using curly braces {}
2. Can be called in any order
3. Use 'required' keyword for mandatory named parameters
4. Very readable and self-documenting
5. Great for functions with many parameters
6. Can mix with positional parameters (positional must come first)
7. Optional named parameters can have default values
*/
