// Day 25: Dart Fundamentals Review
// This file covers the core concepts of Dart programming

void main() {
  print('=== DART FUNDAMENTALS REVIEW ===\n');

  // Variables and Data Types
  variablesAndDataTypes();

  // Control Flow
  controlFlowExamples();

  // Functions
  functionExamples();

  // Collections
  collectionExamples();

  // Object-Oriented Programming
  oopExamples();
}

// 1. Variables and Data Types
void variablesAndDataTypes() {
  print('1. VARIABLES AND DATA TYPES');
  print('----------------------------');

  // Variable declarations
  var name = 'Dart'; // Type inferred
  String language = 'Dart'; // Explicit type
  final version = '3.0'; // Runtime constant
  const pi = 3.14159; // Compile-time constant

  // Nullable types
  String? nullableString;
  int? nullableInt = null;

  // Late variables
  late String lateVariable;
  lateVariable = 'Initialized later';

  print('Language: $language');
  print('Version: $version');
  print('Pi: $pi');
  print('Late variable: $lateVariable');
  print('Nullable int: ${nullableInt ?? "null"}');

  // Type checking
  print('name is String: ${name is String}');
  print('pi is double: ${pi is double}');
  print('');
}

// 2. Control Flow Structures
void controlFlowExamples() {
  print('2. CONTROL FLOW');
  print('----------------');

  // If-else statements
  int score = 85;
  if (score >= 90) {
    print('Grade: A');
  } else if (score >= 80) {
    print('Grade: B');
  } else {
    print('Grade: C or below');
  }

  // Switch statements
  String day = 'Monday';
  switch (day) {
    case 'Monday':
    case 'Tuesday':
      print('Start of work week');
      break;
    case 'Friday':
      print('TGIF!');
      break;
    default:
      print('Regular day');
  }

  // Loops
  print('For loop:');
  for (int i = 1; i <= 3; i++) {
    print('  Iteration $i');
  }

  print('While loop:');
  int count = 0;
  while (count < 3) {
    print('  Count: $count');
    count++;
  }

  print('For-in loop:');
  List<String> fruits = ['apple', 'banana', 'orange'];
  for (String fruit in fruits) {
    print('  Fruit: $fruit');
  }
  print('');
}

// 3. Functions
void functionExamples() {
  print('3. FUNCTIONS');
  print('-------------');

  // Regular function
  int add(int a, int b) => a + b;
  print('Add 5 + 3 = ${add(5, 3)}');

  // Optional parameters
  String greet(String name, [String? title]) {
    return title != null ? 'Hello, $title $name' : 'Hello, $name';
  }

  print(greet('Alice'));
  print(greet('Bob', 'Dr.'));

  // Named parameters
  void printInfo({required String name, int age = 0, String? city}) {
    print('Name: $name, Age: $age, City: ${city ?? "Unknown"}');
  }

  printInfo(name: 'Charlie', age: 25, city: 'New York');

  // Higher-order functions
  List<int> numbers = [1, 2, 3, 4, 5];
  List<int> doubled = numbers.map((n) => n * 2).toList();
  print('Doubled numbers: $doubled');

  // Anonymous functions
  numbers.where((n) => n % 2 == 0).forEach((n) => print('Even: $n'));
  print('');
}

// 4. Collections
void collectionExamples() {
  print('4. COLLECTIONS');
  print('---------------');

  // Lists
  List<String> dynamicList = ['a', 'b', 'c'];
  List<int> fixedList = List.filled(3, 0);
  print('Dynamic list: $dynamicList');
  print('Fixed list: $fixedList');

  // Sets
  Set<int> uniqueNumbers = {1, 2, 3, 2, 1}; // Duplicates removed
  print('Set: $uniqueNumbers');

  // Maps
  Map<String, int> ages = {'Alice': 25, 'Bob': 30, 'Charlie': 35};
  print('Ages: $ages');

  // Collection operations
  List<int> nums = [1, 2, 3, 4, 5];
  print('Sum: ${nums.reduce((a, b) => a + b)}');
  print('Even numbers: ${nums.where((n) => n % 2 == 0).toList()}');
  print('');
}

// 5. Object-Oriented Programming
void oopExamples() {
  print('5. OBJECT-ORIENTED PROGRAMMING');
  print('-------------------------------');

  // Create objects
  Person person = Person('Alice', 25);
  Student student = Student('Bob', 20, 'Computer Science');

  person.introduce();
  student.introduce();
  student.study();

  // Polymorphism
  List<Person> people = [person, student];
  for (Person p in people) {
    p.introduce();
  }
  print('');
}

// Base class
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void introduce() {
    print('Hi, I\'m $name and I\'m $age years old.');
  }
}

// Inheritance
class Student extends Person {
  String major;

  Student(String name, int age, this.major) : super(name, age);

  @override
  void introduce() {
    super.introduce();
    print('I\'m studying $major.');
  }

  void study() {
    print('$name is studying $major.');
  }
}
