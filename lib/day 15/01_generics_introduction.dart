/*
 * Day 15: Generics - Introduction and Purpose
 * 
 * What are Generics?
 * - Generics allow you to write flexible, reusable code that can work with different types
 * - They provide type safety at compile time while maintaining code reusability
 * - Denoted by angle brackets <T> where T is a type parameter
 * 
 * Purpose of Generics:
 * 1. Type Safety: Catch type errors at compile time instead of runtime
 * 2. Code Reusability: Write once, use with multiple types
 * 3. Performance: Avoid boxing/unboxing and type casting
 * 4. Better API Design: Clear contracts about what types are expected
 */

void main() {
  print('=== Generics Introduction ===');

  // Without generics - less type safe
  var items = []; // Dynamic list
  items.add('Hello');
  items.add(42);
  items.add(true);

  // This could cause runtime errors
  // String first = items[0]; // Might fail if not a string

  // With generics - type safe
  List<String> stringList = ['Hello', 'World', 'Dart'];
  List<int> intList = [1, 2, 3, 4, 5];
  List<bool> boolList = [true, false, true];

  print('String list: $stringList');
  print('Int list: $intList');
  print('Bool list: $boolList');

  // Compile-time error prevention
  // stringList.add(42); // Error: The argument type 'int' can't be assigned to 'String'

  demonstrateTypeInference();
  demonstrateGenericMethods();
}

void demonstrateTypeInference() {
  print('\n=== Type Inference with Generics ===');

  // Dart can infer generic types
  var names = <String>['Alice', 'Bob', 'Charlie'];
  var scores = <int>[95, 87, 92];

  // Or let Dart infer from the values
  var cities = ['New York', 'London', 'Tokyo']; // List<String>
  var numbers = [1, 2, 3, 4]; // List<int>

  print('Names: $names (${names.runtimeType})');
  print('Scores: $scores (${scores.runtimeType})');
  print('Cities: $cities (${cities.runtimeType})');
  print('Numbers: $numbers (${numbers.runtimeType})');
}

void demonstrateGenericMethods() {
  print('\n=== Generic Methods ===');

  // Generic method that works with any type
  T getFirst<T>(List<T> list) {
    if (list.isEmpty) {
      throw ArgumentError('List cannot be empty');
    }
    return list.first;
  }

  // Usage with different types
  var firstString = getFirst(['apple', 'banana', 'cherry']);
  var firstNumber = getFirst([10, 20, 30]);
  var firstBool = getFirst([true, false]);

  print('First string: $firstString');
  print('First number: $firstNumber');
  print('First bool: $firstBool');
}
