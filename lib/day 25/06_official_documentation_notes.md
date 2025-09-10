# Day 25: Official Dart Documentation Study Notes

## Overview
This document contains comprehensive notes from studying the official Dart documentation, focusing on the core libraries and advanced concepts.

## 1. Dart Language Tour Key Points

### Variables and Types
- **Type Inference**: Dart can infer types using `var`, `final`, and `const`
- **Null Safety**: All types are non-nullable by default unless explicitly marked with `?`
- **Late Variables**: Use `late` for variables that will be initialized later but before use
- **Final vs Const**: `final` for runtime constants, `const` for compile-time constants

### Control Flow
- **Pattern Matching**: New switch expressions with pattern matching capabilities
- **If-case**: Combine if statements with pattern matching
- **Guard Clauses**: Use `when` in switch cases for additional conditions

### Functions
- **Arrow Functions**: Use `=>` for single-expression functions
- **Optional Parameters**: Positional `[param]` and named `{param}` parameters
- **Required Named Parameters**: Use `required` keyword for mandatory named parameters
- **Function Types**: Functions are first-class objects with specific types

### Classes and Objects
- **Constructors**: Default, named, factory, and redirecting constructors
- **Getters and Setters**: Computed properties using `get` and `set`
- **Abstract Classes**: Cannot be instantiated, used for defining interfaces
- **Mixins**: Share code between classes using `mixin` keyword

## 2. dart:core Library Deep Dive

### Object Class
- Base class for all Dart objects
- Provides fundamental methods: `toString()`, `hashCode`, `==`, `runtimeType`
- `noSuchMethod()` for handling missing method calls

### String Class
```dart
// Key methods and properties
String.length          // Number of characters
String.isEmpty         // Check if empty
String.isNotEmpty      // Check if not empty
String.contains()      // Check if contains substring
String.startsWith()    // Check prefix
String.endsWith()      // Check suffix
String.indexOf()       // Find first occurrence
String.lastIndexOf()   // Find last occurrence
String.substring()     // Extract substring
String.split()         // Split into list
String.replaceAll()    // Replace all occurrences
String.trim()          // Remove whitespace
String.toLowerCase()   // Convert to lowercase
String.toUpperCase()   // Convert to uppercase
```

### Numbers (int and double)
```dart
// int methods
int.parse()           // Parse string to int
int.tryParse()        // Safe parsing (returns null on error)
int.isEven           // Check if even
int.isOdd            // Check if odd
int.abs()            // Absolute value
int.sign             // Sign (-1, 0, 1)

// double methods
double.parse()        // Parse string to double
double.tryParse()     // Safe parsing
double.isFinite      // Check if finite
double.isInfinite    // Check if infinite
double.isNaN         // Check if NaN
double.round()       // Round to nearest int
double.floor()       // Round down
double.ceil()        // Round up
double.truncate()    // Remove decimal part
```

### Collections
```dart
// List methods
List.add()           // Add element
List.addAll()        // Add multiple elements
List.insert()        // Insert at index
List.remove()        // Remove element
List.removeAt()      // Remove at index
List.clear()         // Remove all elements
List.indexOf()       // Find index of element
List.contains()      // Check if contains element
List.sublist()       // Get sublist
List.reversed        // Reverse order
List.sort()          // Sort in place

// Map methods
Map.putIfAbsent()    // Add if key doesn't exist
Map.remove()         // Remove by key
Map.clear()          // Remove all entries
Map.containsKey()    // Check if key exists
Map.containsValue()  // Check if value exists
Map.keys            // Get all keys
Map.values          // Get all values
Map.entries         // Get key-value pairs

// Set methods
Set.add()           // Add element
Set.remove()        // Remove element
Set.contains()      // Check if contains
Set.union()         // Union with another set
Set.intersection()  // Intersection with another set
Set.difference()    // Difference from another set
```

### DateTime
```dart
// Creating DateTime objects
DateTime.now()                    // Current date/time
DateTime(year, month, day)        // Specific date
DateTime.utc()                    // UTC date/time
DateTime.parse()                  // Parse from string

// DateTime properties
DateTime.year                     // Year
DateTime.month                    // Month (1-12)
DateTime.day                      // Day of month
DateTime.hour                     // Hour (0-23)
DateTime.minute                   // Minute (0-59)
DateTime.second                   // Second (0-59)
DateTime.millisecond             // Millisecond (0-999)
DateTime.weekday                 // Day of week (1=Monday)

// DateTime methods
DateTime.add(Duration)           // Add duration
DateTime.subtract(Duration)      // Subtract duration
DateTime.difference(DateTime)    // Get difference
DateTime.isBefore(DateTime)      // Check if before
DateTime.isAfter(DateTime)       // Check if after
DateTime.toIso8601String()       // Convert to ISO string
DateTime.toUtc()                 // Convert to UTC
DateTime.toLocal()               // Convert to local time
```

### Duration
```dart
// Creating Duration objects
Duration(days: 1, hours: 2, minutes: 30)
Duration(milliseconds: 1500)
Duration(microseconds: 1000000)

// Duration properties
Duration.inDays                  // Total days
Duration.inHours                 // Total hours
Duration.inMinutes               // Total minutes
Duration.inSeconds               // Total seconds
Duration.inMilliseconds          // Total milliseconds
Duration.inMicroseconds          // Total microseconds

// Duration operations
Duration + Duration              // Addition
Duration - Duration              // Subtraction
Duration * int                   // Multiplication
Duration ~/ int                  // Integer division
Duration.abs()                   // Absolute value
```

## 3. dart:io Library Deep Dive

### File Operations
```dart
// File class methods
File(path)                       // Create file reference
File.exists()                    // Check if file exists
File.create()                    // Create file
File.delete()                    // Delete file
File.copy(newPath)               // Copy file
File.rename(newPath)             // Rename/move file
File.readAsString()              // Read as string
File.readAsBytes()               // Read as bytes
File.readAsLines()               // Read as list of lines
File.writeAsString()             // Write string to file
File.writeAsBytes()              // Write bytes to file
File.openRead()                  // Open for reading (stream)
File.openWrite()                 // Open for writing (stream)
File.stat()                      // Get file statistics
```

### Directory Operations
```dart
// Directory class methods
Directory(path)                  // Create directory reference
Directory.exists()               // Check if directory exists
Directory.create()               // Create directory
Directory.delete()               // Delete directory
Directory.rename(newPath)        // Rename/move directory
Directory.list()                 // List contents
Directory.listSync()             // List contents synchronously
Directory.current                // Get current directory
Directory.systemTemp             // Get system temp directory
```

### Process Operations
```dart
// Process class methods
Process.run(executable, args)    // Run process and wait
Process.start(executable, args)  // Start process
Process.runSync(executable, args) // Run synchronously
Process.killPid(pid)             // Kill process by PID

// ProcessResult properties
ProcessResult.exitCode          // Exit code
ProcessResult.stdout             // Standard output
ProcessResult.stderr             // Standard error
ProcessResult.pid                // Process ID
```

### Platform Information
```dart
// Platform class properties
Platform.operatingSystem        // OS name
Platform.operatingSystemVersion // OS version
Platform.numberOfProcessors     // CPU count
Platform.pathSeparator          // Path separator
Platform.executable             // Dart executable path
Platform.script                 // Current script URI
Platform.environment            // Environment variables
Platform.version                // Dart version

// Platform boolean checks
Platform.isAndroid              // Android check
Platform.isIOS                  // iOS check
Platform.isLinux                // Linux check
Platform.isMacOS                // macOS check
Platform.isWindows              // Windows check
Platform.isFuchsia              // Fuchsia check
```

## 4. dart:async Library Deep Dive

### Future Class
```dart
// Creating Futures
Future.value(value)              // Completed future
Future.error(error)              // Failed future
Future.delayed(duration, fn)     // Delayed future
Future(() => computation)        // Future from function
Future.microtask(fn)             // Microtask future

// Future methods
Future.then(onValue)             // Handle success
Future.catchError(onError)       // Handle error
Future.whenComplete(fn)          // Always execute
Future.timeout(duration)         // Add timeout
Future.asStream()                // Convert to stream

// Static methods
Future.wait(futures)             // Wait for all
Future.any(futures)              // Wait for first
Future.forEach(iterable, fn)     // Sequential processing
```

### Stream Class
```dart
// Creating Streams
Stream.fromIterable(iterable)    // From collection
Stream.periodic(period, fn)      // Periodic generation
Stream.value(value)              // Single value stream
Stream.error(error)              // Error stream
Stream.empty()                   // Empty stream

// Stream methods
Stream.listen(onData)            // Subscribe to stream
Stream.where(test)               // Filter elements
Stream.map(transform)            // Transform elements
Stream.expand(transform)         // Flatten elements
Stream.take(count)               // Take first n elements
Stream.skip(count)               // Skip first n elements
Stream.distinct()                // Remove duplicates
Stream.handleError(onError)      // Handle errors
Stream.transform(transformer)    // Apply transformer
Stream.asBroadcastStream()       // Convert to broadcast

// Stream aggregation
Stream.reduce(combine)           // Reduce to single value
Stream.fold(initial, combine)    // Fold with initial value
Stream.first                     // First element
Stream.last                      // Last element
Stream.single                    // Single element (error if not exactly one)
Stream.isEmpty                   // Check if empty
Stream.length                    // Count elements
Stream.any(test)                 // Check if any match
Stream.every(test)               // Check if all match
Stream.contains(element)         // Check if contains element
```

### StreamController
```dart
// Creating StreamController
StreamController()               // Single subscription
StreamController.broadcast()     // Multiple subscriptions

// StreamController properties
StreamController.stream          // The stream
StreamController.sink            // The sink
StreamController.isClosed        // Check if closed
StreamController.hasListener     // Check if has listener
StreamController.isPaused        // Check if paused

// StreamController methods
StreamController.add(data)       // Add data
StreamController.addError(error) // Add error
StreamController.close()         // Close stream
```

### Timer Class
```dart
// Creating Timers
Timer(duration, callback)        // One-time timer
Timer.periodic(duration, callback) // Repeating timer
Timer.run(callback)              // Immediate execution

// Timer properties
Timer.isActive                   // Check if active
Timer.tick                       // Current tick count

// Timer methods
Timer.cancel()                   // Cancel timer
```

### Zone Class
```dart
// Zone methods
Zone.current                     // Current zone
Zone.fork(specification)         // Create child zone
Zone.run(body)                   // Run in zone
Zone.runGuarded(body)            // Run with error handling
Zone.runUnary(body, arg)         // Run with argument
Zone.runBinary(body, arg1, arg2) // Run with two arguments

// ZoneSpecification handlers
ZoneSpecification(
  handleUncaughtError: handler,  // Error handler
  print: handler,                // Print handler
  scheduleMicrotask: handler,    // Microtask handler
  createTimer: handler,          // Timer creation handler
)
```

## 5. Best Practices from Documentation

### Performance
1. **Use const constructors** when possible for compile-time constants
2. **Prefer final over var** when the variable won't be reassigned
3. **Use StringBuffer** for building strings in loops
4. **Avoid creating unnecessary objects** in hot code paths
5. **Use async/await** instead of then() for better readability
6. **Prefer whereType()** over where() with is checks

### Memory Management
1. **Cancel subscriptions** to prevent memory leaks
2. **Close streams and sinks** when done
3. **Use weak references** for caches and observers
4. **Avoid circular references** in object graphs
5. **Use object pools** for frequently created objects

### Error Handling
1. **Use try-catch** for synchronous code
2. **Use try-catch with await** for asynchronous code
3. **Handle specific exceptions** rather than catching all
4. **Use Result types** for operations that can fail
5. **Validate inputs** at API boundaries

### Code Organization
1. **Use libraries** to organize code into modules
2. **Export only necessary APIs** from libraries
3. **Use part/part of** for splitting large files
4. **Follow naming conventions** (camelCase, PascalCase)
5. **Document public APIs** with dartdoc comments

### Null Safety
1. **Prefer non-nullable types** by default
2. **Use null-aware operators** (?., ??, ??=)
3. **Avoid null assertion operator** (!) unless certain
4. **Use late for lazy initialization** when appropriate
5. **Handle nullable types explicitly** in your logic

## 6. Advanced Patterns and Idioms

### Factory Pattern
```dart
abstract class Shape {
  factory Shape.circle(double radius) = Circle;
  factory Shape.rectangle(double width, double height) = Rectangle;
}
```

### Singleton Pattern
```dart
class Singleton {
  static Singleton? _instance;
  Singleton._internal();
  
  factory Singleton() {
    return _instance ??= Singleton._internal();
  }
}
```

### Observer Pattern
```dart
class Observable<T> {
  final List<void Function(T)> _observers = [];
  
  void addObserver(void Function(T) observer) {
    _observers.add(observer);
  }
  
  void removeObserver(void Function(T) observer) {
    _observers.remove(observer);
  }
  
  void notify(T value) {
    for (var observer in _observers) {
      observer(value);
    }
  }
}
```

### Builder Pattern
```dart
class HttpRequest {
  final String url;
  final String method;
  final Map<String, String> headers;
  final String? body;
  
  HttpRequest._(this.url, this.method, this.headers, this.body);
  
  factory HttpRequest.builder() = HttpRequestBuilder;
}

class HttpRequestBuilder {
  String? _url;
  String _method = 'GET';
  final Map<String, String> _headers = {};
  String? _body;
  
  HttpRequestBuilder url(String url) {
    _url = url;
    return this;
  }
  
  HttpRequestBuilder method(String method) {
    _method = method;
    return this;
  }
  
  HttpRequestBuilder header(String key, String value) {
    _headers[key] = value;
    return this;
  }
  
  HttpRequestBuilder body(String body) {
    _body = body;
    return this;
  }
  
  HttpRequest build() {
    if (_url == null) throw ArgumentError('URL is required');
    return HttpRequest._(_url!, _method, Map.from(_headers), _body);
  }
}
```

## 7. Testing Patterns

### Unit Testing
```dart
import 'package:test/test.dart';

void main() {
  group('Calculator', () {
    late Calculator calculator;
    
    setUp(() {
      calculator = Calculator();
    });
    
    test('should add two numbers', () {
      expect(calculator.add(2, 3), equals(5));
    });
    
    test('should throw on division by zero', () {
      expect(() => calculator.divide(5, 0), throwsA(isA<ArgumentError>()));
    });
  });
}
```

### Async Testing
```dart
test('should complete async operation', () async {
  final result = await someAsyncOperation();
  expect(result, isNotNull);
});

test('should handle stream data', () async {
  final stream = Stream.fromIterable([1, 2, 3]);
  final results = await stream.toList();
  expect(results, equals([1, 2, 3]));
});
```

## 8. Documentation Standards

### Dartdoc Comments
```dart
/// A calculator that performs basic arithmetic operations.
/// 
/// Example usage:
/// ```dart
/// final calc = Calculator();
/// final result = calc.add(2, 3); // Returns 5
/// ```
class Calculator {
  /// Adds two numbers and returns the result.
  /// 
  /// Both [a] and [b] must be finite numbers.
  /// Throws [ArgumentError] if either parameter is infinite or NaN.
  double add(double a, double b) {
    if (!a.isFinite || !b.isFinite) {
      throw ArgumentError('Parameters must be finite numbers');
    }
    return a + b;
  }
}
```

This comprehensive review covers the essential aspects of Dart's core libraries and advanced concepts as documented in the official Dart documentation.