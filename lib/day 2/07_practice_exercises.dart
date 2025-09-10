// Practice: Variables, Data Types, and String Interpolation

void main() {
  print('=== Day 2 Practice Exercises ===\n');

  // Exercise 1: Basic Variable Declaration
  print('--- Exercise 1: Basic Variable Declaration ---');

  // TODO: Declare variables of different types
  int age = 25;
  double height = 5.9;
  String name = 'Sarah';
  bool isStudent = true;

  print('Name: $name');
  print('Age: $age years old');
  print('Height: $height feet');
  print('Is student: $isStudent\n');

  // Exercise 2: String Interpolation Practice
  print('--- Exercise 2: String Interpolation ---');

  String firstName = 'John';
  String lastName = 'Doe';
  int birthYear = 1995;
  double salary = 75000.50;

  // Simple interpolation
  String greeting = 'Hello, $firstName!';
  print(greeting);

  // Expression interpolation
  String fullInfo = 'Full name: $firstName $lastName';
  print(fullInfo);

  // Complex expression interpolation
  int currentYear = DateTime.now().year;
  String ageCalculation = '$firstName is ${currentYear - birthYear} years old';
  print(ageCalculation);

  // Formatting numbers in strings
  String salaryInfo =
      '$firstName earns \$${salary.toStringAsFixed(2)} per year';
  print(salaryInfo);

  // Multi-line string with interpolation
  String profile = '''
  Employee Profile:
  - Name: $firstName $lastName
  - Age: ${currentYear - birthYear}
  - Salary: \$${salary.toStringAsFixed(2)}
  - Status: ${isStudent ? 'Student Employee' : 'Regular Employee'}
  ''';
  print(profile);

  // Exercise 3: var, final, const Practice
  print('--- Exercise 3: Variable Keywords ---');

  // Using var (mutable)
  var city = 'New York';
  var population = 8000000;
  print('Original: $city has $population people');

  city = 'Los Angeles';
  population = 4000000;
  print('Updated: $city has $population people');

  // Using final (immutable reference, runtime value)
  final String country = 'USA';
  final DateTime registrationTime = DateTime.now();
  print('Country: $country');
  print('Registered at: ${registrationTime.toString().split('.')[0]}');

  // Using const (compile-time constant)
  const String appName = 'MyDartApp';
  const double version = 1.0;
  const List<String> supportedLanguages = ['English', 'Spanish', 'French'];

  String appInfo =
      '$appName v$version supports: ${supportedLanguages.join(', ')}';
  print(appInfo);

  // Exercise 4: Nullable Variables Practice
  print('\n--- Exercise 4: Nullable Variables ---');

  String? userEmail; // Nullable
  String? phoneNumber;
  int? score;

  // Using null-aware operators
  String emailDisplay = userEmail ?? 'No email provided';
  String phoneDisplay = phoneNumber ?? 'No phone provided';
  String scoreDisplay = score?.toString() ?? 'No score yet';

  print('Email: $emailDisplay');
  print('Phone: $phoneDisplay');
  print('Score: $scoreDisplay');

  // Assigning values
  userEmail = 'user@example.com';
  phoneNumber = '+1-555-0123';
  score = 95;

  // Updated display with null-aware access
  String emailDomain = userEmail?.split('@').last ?? 'unknown';
  int? phoneLength = phoneNumber?.length;
  bool? isHighScore = score != null ? score > 90 : null;

  print('\nAfter assignment:');
  print('Email domain: $emailDomain');
  print('Phone length: $phoneLength characters');
  print('High score: ${isHighScore ?? 'Unknown'}');

  // Exercise 5: Real-world Example - Student Record
  print('\n--- Exercise 5: Student Record System ---');

  // Student information
  const String schoolName = 'Dart University';
  final String studentId =
      'STU${DateTime.now().millisecondsSinceEpoch % 10000}';

  var studentName = 'Alice Johnson';
  var major = 'Computer Science';
  var gpa = 3.85;
  var graduationYear = 2024;
  var isInternational = false;

  // Optional information (nullable)
  String? dormRoom;
  String? advisor;
  double? scholarshipAmount;

  // Create student record using string interpolation
  String studentRecord = '''
  ╔══════════════════════════════════════╗
  ║           STUDENT RECORD             ║
  ╠══════════════════════════════════════╣
  ║ School: $schoolName
  ║ Student ID: $studentId
  ║ Name: $studentName
  ║ Major: $major
  ║ GPA: ${gpa.toStringAsFixed(2)}
  ║ Graduation Year: $graduationYear
  ║ International: ${isInternational ? 'Yes' : 'No'}
  ║ Dorm Room: ${dormRoom ?? 'Not assigned'}
  ║ Advisor: ${advisor ?? 'Not assigned'}
  ║ Scholarship: ${scholarshipAmount != null ? '\$${scholarshipAmount!.toStringAsFixed(2)}' : 'None'}
  ╚══════════════════════════════════════╝
  ''';

  print(studentRecord);

  // Update some information
  dormRoom = 'Building A, Room 205';
  advisor = 'Dr. Smith';
  scholarshipAmount = 5000.0;

  print('--- After Updates ---');
  print('Dorm: ${dormRoom ?? 'Not assigned'}');
  print('Advisor: ${advisor ?? 'Not assigned'}');
  print('Scholarship: \$${scholarshipAmount?.toStringAsFixed(2) ?? '0.00'}');

  // Exercise 6: Practice Challenges
  print('\n--- Practice Challenges ---');

  // Challenge 1: Create a product catalog entry
  String productName = 'Wireless Headphones';
  double price = 199.99;
  int stockQuantity = 15;
  bool isOnSale = true;
  double? discountPercent = isOnSale ? 20.0 : null;

  String catalogEntry = '''
  Product: $productName
  Price: \$${price.toStringAsFixed(2)}${discountPercent != null ? ' (${discountPercent.toInt()}% off!)' : ''}
  Stock: $stockQuantity units
  Final Price: \$${(price * (1 - (discountPercent ?? 0) / 100)).toStringAsFixed(2)}
  ''';

  print(catalogEntry);

  // Challenge 2: Weather report
  String location = 'San Francisco';
  int temperature = 72;
  String condition = 'Sunny';
  double? humidity;
  int? windSpeed;

  String weatherReport = '''
  Weather Report for $location:
  Temperature: ${temperature}°F
  Condition: $condition
  Humidity: ${humidity?.toStringAsFixed(1) ?? 'N/A'}%
  Wind Speed: ${windSpeed ?? 'N/A'} mph
  ''';

  print(weatherReport);

  print('\n=== Practice Complete! ===');
}

// Additional practice function
void practiceStringInterpolation() {
  print('\n--- Additional String Interpolation Practice ---');

  // Mathematical expressions
  int a = 10;
  int b = 5;

  print('$a + $b = ${a + b}');
  print('$a - $b = ${a - b}');
  print('$a * $b = ${a * b}');
  print('$a / $b = ${a / b}');
  print('$a % $b = ${a % b}');

  // String methods in interpolation
  String message = 'hello world';
  print('Original: $message');
  print('Uppercase: ${message.toUpperCase()}');
  print('Length: ${message.length}');
  print('First word: ${message.split(' ')[0]}');

  // Conditional expressions
  int score = 85;
  print(
    'Grade: ${score >= 90
        ? 'A'
        : score >= 80
        ? 'B'
        : score >= 70
        ? 'C'
        : 'F'}',
  );

  // Date and time formatting
  DateTime now = DateTime.now();
  print('Current time: ${now.hour}:${now.minute.toString().padLeft(2, '0')}');
  print('Today is: ${now.day}/${now.month}/${now.year}');
}
