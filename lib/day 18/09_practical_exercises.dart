/*
Practical Extensions Exercises
==============================

This file contains practical exercises to practice creating and using extensions.
Each exercise includes the problem statement, solution, and explanation.
*/

/*
EXERCISE 1: String Capitalize Extension (Required)
==================================================
Create an extension on String that adds a capitalize() method.
The method should capitalize the first letter and make the rest lowercase.

Requirements:
- Handle empty strings
- Handle single character strings
- Make the rest of the string lowercase
*/

// Solution for Exercise 1
extension StringCapitalize on String {
  /// Capitalizes the first letter and makes the rest lowercase.
  /// Returns empty string if the original string is empty.
  String capitalize() {
    if (isEmpty) return this;
    if (length == 1) return toUpperCase();
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

/*
EXERCISE 2: List Utility Extensions
===================================
Create extensions for List<T> that add the following methods:
- secondOrNull: Get the second element or null if not available
- penultimate: Get the second-to-last element or null if not available
- swap(int i, int j): Swap elements at indices i and j
- rotate(int positions): Rotate the list by given positions
*/

// Solution for Exercise 2
extension ListUtilities<T> on List<T> {
  /// Gets the second element or null if the list has fewer than 2 elements.
  T? get secondOrNull => length >= 2 ? this[1] : null;

  /// Gets the second-to-last element or null if the list has fewer than 2 elements.
  T? get penultimate => length >= 2 ? this[length - 2] : null;

  /// Swaps elements at indices i and j.
  /// Throws RangeError if indices are out of bounds.
  void swap(int i, int j) {
    if (i < 0 || i >= length || j < 0 || j >= length) {
      throw RangeError('Index out of bounds');
    }
    if (i != j) {
      T temp = this[i];
      this[i] = this[j];
      this[j] = temp;
    }
  }

  /// Rotates the list by the specified number of positions.
  /// Positive values rotate right, negative values rotate left.
  void rotate(int positions) {
    if (isEmpty || positions == 0) return;

    int actualPositions = positions % length;
    if (actualPositions < 0) actualPositions += length;

    if (actualPositions == 0) return;

    List<T> temp = List.from(this);
    for (int i = 0; i < length; i++) {
      this[(i + actualPositions) % length] = temp[i];
    }
  }
}

/*
EXERCISE 3: DateTime Utility Extensions
=======================================
Create extensions for DateTime that add:
- isWeekend: Check if the date falls on a weekend
- addBusinessDays(int days): Add business days (skip weekends)
- daysDifference(DateTime other): Get difference in days
- formatShort(): Format as "MM/dd/yyyy"
*/

// Solution for Exercise 3
extension DateTimeUtilities on DateTime {
  /// Checks if the date falls on a weekend (Saturday or Sunday).
  bool get isWeekend =>
      weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// Adds the specified number of business days (excluding weekends).
  DateTime addBusinessDays(int days) {
    DateTime result = this;
    int addedDays = 0;
    int direction = days.sign;
    int remainingDays = days.abs();

    while (addedDays < remainingDays) {
      result = result.add(Duration(days: direction));
      if (!result.isWeekend) {
        addedDays++;
      }
    }

    return result;
  }

  /// Calculates the difference in days between this date and another date.
  int daysDifference(DateTime other) {
    return difference(other).inDays.abs();
  }

  /// Formats the date as MM/dd/yyyy.
  String formatShort() {
    return '${month.toString().padLeft(2, '0')}/'
        '${day.toString().padLeft(2, '0')}/'
        '$year';
  }
}

/*
EXERCISE 4: Map Enhancement Extensions
=====================================
Create extensions for Map<K, V> that add:
- getOrPut(K key, V Function() defaultValue): Get value or put and return default
- filterValues(bool Function(V) test): Filter map by values
- mapBoth<K2, V2>(MapEntry<K2, V2> Function(K, V) transform): Transform both keys and values
*/

// Solution for Exercise 4
extension MapEnhancements<K, V> on Map<K, V> {
  /// Gets the value for the key, or puts and returns the default value if key doesn't exist.
  V getOrPut(K key, V Function() defaultValue) {
    if (containsKey(key)) {
      return this[key] as V;
    } else {
      V value = defaultValue();
      this[key] = value;
      return value;
    }
  }

  /// Filters the map by values that match the test predicate.
  Map<K, V> filterValues(bool Function(V) test) {
    Map<K, V> result = {};
    for (MapEntry<K, V> entry in entries) {
      if (test(entry.value)) {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }

  /// Transforms both keys and values using the provided function.
  Map<K2, V2> mapBoth<K2, V2>(MapEntry<K2, V2> Function(K, V) transform) {
    Map<K2, V2> result = {};
    for (MapEntry<K, V> entry in entries) {
      MapEntry<K2, V2> transformed = transform(entry.key, entry.value);
      result[transformed.key] = transformed.value;
    }
    return result;
  }
}

/*
EXERCISE 5: Numeric Range Extensions
===================================
Create extensions for num that add:
- isInRange(num min, num max): Check if number is in range (inclusive)
- percentageOf(num total): Calculate what percentage this number is of total
- roundToNearest(num multiple): Round to nearest multiple
- toRomanNumeral(): Convert to Roman numeral (1-3999)
*/

// Solution for Exercise 5
extension NumericRange on num {
  /// Checks if the number is within the specified range (inclusive).
  bool isInRange(num min, num max) {
    return this >= min && this <= max;
  }

  /// Calculates what percentage this number is of the total.
  double percentageOf(num total) {
    if (total == 0) return 0;
    return (this / total) * 100;
  }

  /// Rounds the number to the nearest multiple of the specified value.
  num roundToNearest(num multiple) {
    if (multiple == 0) return this;
    return (this / multiple).round() * multiple;
  }

  /// Converts the number to Roman numeral representation (1-3999).
  String toRomanNumeral() {
    int number = toInt();
    if (number < 1 || number > 3999) {
      throw ArgumentError('Roman numerals only support numbers 1-3999');
    }

    const values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    const symbols = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I',
    ];

    String result = '';
    for (int i = 0; i < values.length; i++) {
      while (number >= values[i]) {
        result += symbols[i];
        number -= values[i];
      }
    }

    return result;
  }
}

/*
EXERCISE 6: Custom Class Extensions
==================================
Create a Person class and extensions that add:
- fullName: Get full name from first and last name
- initials: Get initials
- ageGroup: Get age group (Child, Teen, Adult, Senior)
- isAdult: Check if person is 18 or older
*/

// Person class for Exercise 6
class Person {
  final String firstName;
  final String lastName;
  final int age;

  Person({required this.firstName, required this.lastName, required this.age});

  @override
  String toString() => '$firstName $lastName ($age)';
}

// Solution for Exercise 6
extension PersonExtensions on Person {
  /// Gets the full name by combining first and last name.
  String get fullName => '$firstName $lastName';

  /// Gets the initials from first and last name.
  String get initials => '${firstName[0]}${lastName[0]}';

  /// Gets the age group based on age.
  String get ageGroup {
    if (age < 13) return 'Child';
    if (age < 20) return 'Teen';
    if (age < 65) return 'Adult';
    return 'Senior';
  }

  /// Checks if the person is an adult (18 or older).
  bool get isAdult => age >= 18;
}

// Test functions for all exercises
void testExercise1() {
  print('=== Exercise 1: String Capitalize ===');

  List<String> testStrings = ['hello', 'WORLD', 'dArT', 'a', ''];

  for (String str in testStrings) {
    print('"$str".capitalize() = "${str.capitalize()}"');
  }
  print();
}

void testExercise2() {
  print('=== Exercise 2: List Utilities ===');

  List<int> numbers = [1, 2, 3, 4, 5];
  print('Original list: $numbers');
  print('Second element: ${numbers.secondOrNull}');
  print('Penultimate element: ${numbers.penultimate}');

  // Test swap
  List<int> swapTest = [1, 2, 3, 4, 5];
  swapTest.swap(0, 4);
  print('After swapping indices 0 and 4: $swapTest');

  // Test rotate
  List<int> rotateTest = [1, 2, 3, 4, 5];
  rotateTest.rotate(2);
  print('After rotating right by 2: $rotateTest');

  List<int> rotateTest2 = [1, 2, 3, 4, 5];
  rotateTest2.rotate(-1);
  print('After rotating left by 1: $rotateTest2');
  print();
}

void testExercise3() {
  print('=== Exercise 3: DateTime Utilities ===');

  DateTime now = DateTime.now();
  DateTime weekend = DateTime(2024, 1, 6); // Saturday
  DateTime weekday = DateTime(2024, 1, 8); // Monday

  print('Today: ${now.formatShort()}');
  print('Is weekend: ${now.isWeekend}');
  print(
    'Weekend date (${weekend.formatShort()}) is weekend: ${weekend.isWeekend}',
  );
  print(
    'Weekday date (${weekday.formatShort()}) is weekend: ${weekday.isWeekend}',
  );

  DateTime futureDate = now.addBusinessDays(5);
  print('5 business days from now: ${futureDate.formatShort()}');

  int daysDiff = now.daysDifference(DateTime(2024, 1, 1));
  print('Days difference from Jan 1, 2024: $daysDiff');
  print();
}

void testExercise4() {
  print('=== Exercise 4: Map Enhancements ===');

  Map<String, int> scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};
  print('Original scores: $scores');

  // Test getOrPut
  int defaultScore = scores.getOrPut('David', () => 80);
  print('David\'s score (with default): $defaultScore');
  print('Updated scores: $scores');

  // Test filterValues
  Map<String, int> highScores = scores.filterValues((score) => score > 90);
  print('High scores (>90): $highScores');

  // Test mapBoth
  Map<String, String> transformed = scores.mapBoth(
    (name, score) => MapEntry(name.toUpperCase(), 'Score: $score'),
  );
  print('Transformed map: $transformed');
  print();
}

void testExercise5() {
  print('=== Exercise 5: Numeric Range ===');

  num value = 75;
  print('Value: $value');
  print('Is in range 50-100: ${value.isInRange(50, 100)}');
  print('Is in range 80-90: ${value.isInRange(80, 90)}');
  print('Percentage of 300: ${value.percentageOf(300).toStringAsFixed(1)}%');
  print('Rounded to nearest 10: ${value.roundToNearest(10)}');
  print('As Roman numeral: ${value.toRomanNumeral()}');

  // Test other numbers
  List<int> testNumbers = [1, 4, 9, 27, 49, 99, 500, 1994, 2023];
  print('\nRoman numerals:');
  for (int num in testNumbers) {
    print('$num = ${num.toRomanNumeral()}');
  }
  print();
}

void testExercise6() {
  print('=== Exercise 6: Person Extensions ===');

  List<Person> people = [
    Person(firstName: 'John', lastName: 'Doe', age: 25),
    Person(firstName: 'Jane', lastName: 'Smith', age: 17),
    Person(firstName: 'Bob', lastName: 'Johnson', age: 70),
    Person(firstName: 'Alice', lastName: 'Brown', age: 8),
  ];

  for (Person person in people) {
    print('Person: ${person.fullName}');
    print('  Initials: ${person.initials}');
    print('  Age group: ${person.ageGroup}');
    print('  Is adult: ${person.isAdult}');
    print();
  }
}

void runAllExercises() {
  print('🎯 PRACTICAL EXTENSIONS EXERCISES\n');
  print('=' * 50);

  testExercise1();
  testExercise2();
  testExercise3();
  testExercise4();
  testExercise5();
  testExercise6();

  print('✅ All exercises completed successfully!');
}

void main() {
  runAllExercises();
}
