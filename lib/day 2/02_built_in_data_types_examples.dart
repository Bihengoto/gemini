// Built-in Data Types Examples

void main() {
  // Integer examples
  int studentCount = 30;
  int temperature = -5;
  int hexValue = 0xFF; // Hexadecimal

  print('Student count: $studentCount');
  print('Temperature: ${temperature}°C');
  print('Hex value: $hexValue');

  // Double examples
  double price = 29.99;
  double scientificNotation = 1.42e5; // 142000.0
  double percentage = 85.5;

  print('Price: \$${price}');
  print('Scientific notation: $scientificNotation');
  print('Percentage: $percentage%');

  // String examples
  String firstName = 'Alice';
  String lastName = "Johnson";
  String fullName = '$firstName $lastName';
  String multiLine = '''
  This is a
  multi-line
  string
  ''';

  print('Full name: $fullName');
  print('Multi-line:$multiLine');

  // Boolean examples
  bool isLoggedIn = true;
  bool hasPermission = false;
  bool isAdult = studentCount > 18;

  print('Logged in: $isLoggedIn');
  print('Has permission: $hasPermission');
  print('Is adult: $isAdult');

  // Type checking
  print('studentCount is int: ${studentCount is int}');
  print('price is double: ${price is double}');
  print('fullName is String: ${fullName is String}');
  print('isLoggedIn is bool: ${isLoggedIn is bool}');
}
