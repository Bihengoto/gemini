# Day 25: Comprehensive Dart Review

## Overview
This document provides a comprehensive review of all Dart concepts covered, serving as a quick reference and study guide.

## 1. Dart Fundamentals

### Variables and Data Types
```dart
// Variable declarations
var name = 'Dart';           // Type inferred
String language = 'Dart';    // Explicit type
final version = '3.0';       // Runtime constant
const pi = 3.14159;         // Compile-time constant

// Nullable types
String? nullableString;
int? nullableInt = null;

// Late variables
late String lateVariable;
lateVariable = 'Initialized later';
```

### Control Flow
```dart
// If-else
if (condition) {
  // code
} else if (anotherCondition) {
  // code
} else {
  // code
}

// Switch
switch (value) {
  case 'option1':
    // code
    break;
  case 'option2':
    // code
    break;
  default:
    // code
}

// Loops
for (int i = 0; i < 10; i++) { }
while (condition) { }
do { } while (condition);
for (var item in collection) { }
```

### Functions
```dart
// Basic function
int add(int a, int b) => a + b;

// Optional parameters
String greet(String name, [String? title]) { }

// Named parameters
void printInfo({required String name, int age = 0}) { }

// Higher-order functions
List<int> doubled = numbers.map((n) => n * 2).toList();
```

## 2. Object-Oriented Programming

### Classes and Objects
```dart
class Person {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  void introduce() {
    print('Hi, I\'m $name, age $age');
  }
}
```

### Inheritance
```dart
class Student extends Person {
  String major;
  
  Student(String name, int age, this.major) : super(name, age);
  
  @override
  void introduce() {
    super.introduce();
    print('I\'m studying $major');
  }
}
```

### Abstract Classes and Interfaces
```dart
abstract class Shape {
  double area();
  void draw();
}

class Circle implements Shape {
  final double radius;
  Circle(this.radius);
  
  @override
  double area() => 3.14159 * radius * radius;
  
  @override
  void draw() => print('Drawing circle');
}
```

### Mixins
```dart
mixin Flyable {
  void fly() => print('Flying');
}

mixin Swimmable {
  void swim() => print('Swimming');
}

class Duck with Flyable, Swimmable {
  void quack() => print('Quack!');
}
```

## 3. Collections

### Lists
```dart
List<String> fruits = ['apple', 'banana', 'orange'];
fruits.add('grape');
fruits.remove('banana');
fruits.forEach((fruit) => print(fruit));
```

### Sets
```dart
Set<int> numbers = {1, 2, 3, 2, 1}; // Duplicates removed
numbers.add(4);
numbers.remove(1);
```

### Maps
```dart
Map<String, int> ages = {
  'Alice': 25,
  'Bob': 30,
};
ages['Charlie'] = 35;
ages.remove('Bob');
```

## 4. Null Safety

### Key Concepts
- All types are non-nullable by default
- Use `?` to make types nullable
- Use null-aware operators for safe access

### Null-Aware Operators
```dart
String? name;

// Null-aware access
int? length = name?.length;

// Null coalescing
String displayName = name ?? 'Anonymous';

// Null assignment
name ??= 'Default';

// Null assertion (use carefully!)
String definitelyNotNull = name!;
```

## 5. Asynchronous Programming

### Futures
```dart
// Creating futures
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Data fetched';
}

// Using futures
String data = await fetchData();

// Error handling
try {
  String result = await riskyOperation();
} catch (e) {
  print('Error: $e');
}

// Multiple futures
List<String> results = await Future.wait([
  fetchData(),
  fetchData(),
  fetchData(),
]);
```

### Streams
```dart
// Creating streams
Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

// Consuming streams
await for (int number in numberStream) {
  print(number);
}

// Stream transformations
Stream<String> transformed = numberStream
    .where((n) => n % 2 == 0)
    .map((n) => 'Even: $n');

// Stream subscription
StreamSubscription subscription = stream.listen(
  (data) => print('Data: $data'),
  onError: (error) => print('Error: $error'),
  onDone: () => print('Done'),
);
```

## 6. Generics

### Generic Classes
```dart
class Box<T> {
  final T value;
  Box(this.value);
  T getValue() => value;
}

Box<String> stringBox = Box<String>('Hello');
Box<int> intBox = Box<int>(42);
```

### Generic Methods
```dart
T getFirst<T>(List<T> list) {
  return list.first;
}

String first = getFirst<String>(['a', 'b', 'c']);
```

### Bounded Generics
```dart
class NumberBox<T extends num> {
  final T value;
  NumberBox(this.value);
  T double() => (value * 2) as T;
}
```

## 7. Error Handling

### Try-Catch
```dart
try {
  int result = int.parse('not a number');
} on FormatException catch (e) {
  print('Format error: $e');
} catch (e) {
  print('Other error: $e');
} finally {
  print('Always executed');
}
```

### Custom Exceptions
```dart
class CustomException implements Exception {
  final String message;
  CustomException(this.message);
  
  @override
  String toString() => 'CustomException: $message';
}
```

## 8. Extension Methods

### Extending Existing Classes
```dart
extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  bool get isEmail => contains('@') && contains('.');
}

// Usage
String name = 'john';
print(name.capitalize()); // John
print('test@example.com'.isEmail); // true
```

## 9. Functional Programming

### Higher-Order Functions
```dart
List<int> numbers = [1, 2, 3, 4, 5];

// Map
List<int> doubled = numbers.map((n) => n * 2).toList();

// Filter
List<int> evens = numbers.where((n) => n % 2 == 0).toList();

// Reduce
int sum = numbers.reduce((a, b) => a + b);

// Fold
String concatenated = numbers.fold('', (prev, element) => '$prev$element');
```

### Function Composition
```dart
Function<int, int> addOne = (x) => x + 1;
Function<int, int> multiplyByTwo = (x) => x * 2;

Function<int, int> composed = (x) => multiplyByTwo(addOne(x));
```

## 10. Design Patterns

### Singleton
```dart
class Singleton {
  static Singleton? _instance;
  Singleton._internal();
  
  static Singleton get instance {
    return _instance ??= Singleton._internal();
  }
}
```

### Factory
```dart
abstract class Animal {
  factory Animal.dog() = Dog;
  factory Animal.cat() = Cat;
  void makeSound();
}

class Dog implements Animal {
  @override
  void makeSound() => print('Woof!');
}
```

### Observer
```dart
abstract class Observer {
  void update(String message);
}

class Subject {
  final List<Observer> _observers = [];
  
  void addObserver(Observer observer) => _observers.add(observer);
  void removeObserver(Observer observer) => _observers.remove(observer);
  
  void notifyObservers(String message) {
    for (Observer observer in _observers) {
      observer.update(message);
    }
  }
}
```

## 11. dart:core Library Highlights

### String Methods
```dart
String text = 'Hello, World!';
text.length                    // 13
text.toUpperCase()            // 'HELLO, WORLD!'
text.toLowerCase()            // 'hello, world!'
text.contains('World')        // true
text.startsWith('Hello')      // true
text.endsWith('!')           // true
text.indexOf('o')            // 4
text.substring(0, 5)         // 'Hello'
text.split(', ')             // ['Hello', 'World!']
text.replaceAll('o', '0')    // 'Hell0, W0rld!'
text.trim()                  // Remove whitespace
```

### Number Methods
```dart
int number = 42;
number.isEven                // true
number.isOdd                 // false
number.abs()                 // 42
number.toString()            // '42'

double decimal = 3.14159;
decimal.round()              // 3
decimal.floor()              // 3
decimal.ceil()               // 4
decimal.toStringAsFixed(2)   // '3.14'
```

### DateTime
```dart
DateTime now = DateTime.now();
DateTime specific = DateTime(2024, 12, 25, 10, 30);
DateTime utc = DateTime.utc(2024, 1, 1);

now.year                     // Current year
now.month                    // Current month
now.day                      // Current day
now.add(Duration(days: 1))   // Tomorrow
now.subtract(Duration(hours: 2)) // 2 hours ago
now.difference(specific)     // Duration between dates
```

## 12. dart:io Library Highlights

### File Operations
```dart
File file = File('example.txt');
await file.writeAsString('Hello, World!');
String content = await file.readAsString();
List<String> lines = await file.readAsLines();
bool exists = await file.exists();
await file.delete();
```

### Directory Operations
```dart
Directory dir = Directory('my_folder');
await dir.create();
await for (FileSystemEntity entity in dir.list()) {
  print(entity.path);
}
await dir.delete(recursive: true);
```

### HTTP Client
```dart
HttpClient client = HttpClient();
HttpClientRequest request = await client.getUrl(Uri.parse('https://api.example.com'));
HttpClientResponse response = await request.close();
String responseBody = await response.transform(utf8.decoder).join();
client.close();
```

## 13. dart:async Library Highlights

### Timer
```dart
Timer oneTime = Timer(Duration(seconds: 1), () => print('Timer fired!'));
Timer periodic = Timer.periodic(Duration(seconds: 1), (timer) {
  print('Tick ${timer.tick}');
  if (timer.tick >= 5) timer.cancel();
});
```

### StreamController
```dart
StreamController<int> controller = StreamController<int>();
controller.stream.listen((data) => print('Received: $data'));
controller.add(1);
controller.add(2);
controller.close();
```

### Completer
```dart
Completer<String> completer = Completer<String>();
Timer(Duration(seconds: 1), () => completer.complete('Done!'));
String result = await completer.future;
```

## 14. Best Practices

### Code Organization
- Use meaningful variable and function names
- Keep functions small and focused
- Use const constructors when possible
- Prefer final over var when variables won't be reassigned

### Error Handling
- Handle specific exceptions rather than catching all
- Use try-catch for synchronous code
- Use try-catch with await for asynchronous code
- Always clean up resources (close streams, cancel subscriptions)

### Performance
- Use StringBuffer for building strings in loops
- Prefer whereType() over where() with is checks
- Use const constructors for immutable objects
- Avoid creating unnecessary objects in hot code paths

### Null Safety
- Prefer non-nullable types by default
- Use null-aware operators (?., ??, ??=)
- Avoid null assertion operator (!) unless certain
- Handle nullable types explicitly in your logic

### Async Programming
- Use async/await instead of then() for better readability
- Handle errors with try-catch in async functions
- Use Future.wait() for parallel execution
- Cancel subscriptions to prevent memory leaks

## 15. Common Pitfalls to Avoid

1. **Forgetting to handle null values** - Always check for null or use null-aware operators
2. **Not canceling subscriptions** - This can lead to memory leaks
3. **Using sync operations for I/O** - Always use async operations for file/network I/O
4. **Overusing the null assertion operator (!)** - Only use when you're absolutely certain
5. **Not handling exceptions** - Always wrap risky operations in try-catch blocks
6. **Creating unnecessary objects in loops** - This can impact performance
7. **Not using const constructors** - Missing optimization opportunities
8. **Mixing sync and async code incorrectly** - Be consistent with your async patterns

## Conclusion

This comprehensive review covers the essential Dart concepts needed for effective programming. Regular practice with these concepts, combined with reading the official documentation, will help solidify your understanding and make you a proficient Dart developer.

Remember to:
- Practice regularly with real-world examples
- Read and understand error messages
- Use the Dart analyzer and linter
- Keep up with Dart language updates
- Contribute to open-source Dart projects when possible