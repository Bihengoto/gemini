/*
 * Day 15: Generics with Collections
 * 
 * This file demonstrates how to use generics with:
 * - List<T>
 * - Map<K, V>
 * - Set<T>
 * - Other collection types
 */

void main() {
  print('=== Generic Collections ===');

  demonstrateGenericLists();
  demonstrateGenericMaps();
  demonstrateGenericSets();
  demonstrateNestedGenerics();
  demonstrateCollectionOperations();
}

void demonstrateGenericLists() {
  print('\n--- Generic Lists ---');

  // Different ways to create generic lists
  List<String> fruits = ['apple', 'banana', 'orange'];
  List<int> numbers = [1, 2, 3, 4, 5];
  List<double> prices = [9.99, 15.50, 23.75];

  // Using var with explicit generic type
  var colors = <String>['red', 'green', 'blue'];

  // Empty lists with specific types
  List<String> emptyStrings = <String>[];
  var emptyInts = <int>[];

  print('Fruits: $fruits');
  print('Numbers: $numbers');
  print('Prices: $prices');
  print('Colors: $colors');

  // Type-safe operations
  fruits.add('grape');
  numbers.add(6);
  // fruits.add(42); // Compile error!

  print('After adding: Fruits = $fruits, Numbers = $numbers');
}

void demonstrateGenericMaps() {
  print('\n--- Generic Maps ---');

  // Map<Key, Value> - both key and value can be generic
  Map<String, int> studentGrades = {'Alice': 95, 'Bob': 87, 'Charlie': 92};

  Map<int, String> idToName = {1: 'John', 2: 'Jane', 3: 'Jack'};

  Map<String, List<String>> countryToCities = {
    'USA': ['New York', 'Los Angeles', 'Chicago'],
    'UK': ['London', 'Manchester', 'Birmingham'],
    'Japan': ['Tokyo', 'Osaka', 'Kyoto'],
  };

  print('Student grades: $studentGrades');
  print('ID to name: $idToName');
  print('Country to cities: $countryToCities');

  // Type-safe operations
  studentGrades['David'] = 88;
  idToName[4] = 'Jill';
  countryToCities['Canada'] = ['Toronto', 'Vancouver', 'Montreal'];

  // studentGrades['Eve'] = 'A+'; // Compile error!
  // idToName['5'] = 'Jim'; // Compile error!

  print('After updates:');
  print('Student grades: $studentGrades');
  print('ID to name: $idToName');
}

void demonstrateGenericSets() {
  print('\n--- Generic Sets ---');

  Set<String> uniqueNames = {
    'Alice',
    'Bob',
    'Charlie',
    'Alice',
  }; // Duplicates removed
  Set<int> primeNumbers = {2, 3, 5, 7, 11, 13};

  var uniqueColors = <String>{'red', 'green', 'blue', 'red'}; // Type inferred

  print('Unique names: $uniqueNames');
  print('Prime numbers: $primeNumbers');
  print('Unique colors: $uniqueColors');

  // Set operations
  uniqueNames.add('David');
  primeNumbers.add(17);

  print('After adding: Names = $uniqueNames, Primes = $primeNumbers');
}

void demonstrateNestedGenerics() {
  print('\n--- Nested Generics ---');

  // List of Lists
  List<List<int>> matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ];

  // Map of Lists
  Map<String, List<String>> categories = {
    'fruits': ['apple', 'banana', 'orange'],
    'vegetables': ['carrot', 'broccoli', 'spinach'],
    'grains': ['rice', 'wheat', 'oats'],
  };

  // List of Maps
  List<Map<String, dynamic>> users = [
    {'name': 'Alice', 'age': 25, 'active': true},
    {'name': 'Bob', 'age': 30, 'active': false},
    {'name': 'Charlie', 'age': 35, 'active': true},
  ];

  print('Matrix: $matrix');
  print('Categories: $categories');
  print('Users: $users');
}

void demonstrateCollectionOperations() {
  print('\n--- Generic Collection Operations ---');

  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // Generic methods that preserve type safety
  List<int> evenNumbers = numbers.where((n) => n % 2 == 0).toList();
  List<String> numberStrings = numbers.map((n) => 'Number: $n').toList();
  List<int> doubledNumbers = numbers.map((n) => n * 2).toList();

  print('Original: $numbers');
  print('Even numbers: $evenNumbers');
  print('Number strings: $numberStrings');
  print('Doubled: $doubledNumbers');

  // Reduce operation
  int sum = numbers.reduce((a, b) => a + b);
  print('Sum: $sum');

  // Any and every
  bool hasEven = numbers.any((n) => n % 2 == 0);
  bool allPositive = numbers.every((n) => n > 0);

  print('Has even: $hasEven');
  print('All positive: $allPositive');
}
