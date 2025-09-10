/*
Advanced Extensions
===================

This file covers advanced extension concepts including:
- Generic extensions
- Extensions with type constraints
- Extension conflicts and resolution
- Static extensions
- Extensions on functions
- Best practices and limitations
*/

// Generic extensions
extension GenericListExtensions<T> on List<T> {
  // Safe get with bounds checking
  T? safeGet(int index) {
    return (index >= 0 && index < length) ? this[index] : null;
  }

  // Update element at index if valid
  bool safeUpdate(int index, T value) {
    if (index >= 0 && index < length) {
      this[index] = value;
      return true;
    }
    return false;
  }

  // Partition list based on predicate
  ({List<T> matching, List<T> notMatching}) partition(
    bool Function(T) predicate,
  ) {
    List<T> matching = [];
    List<T> notMatching = [];

    for (T element in this) {
      if (predicate(element)) {
        matching.add(element);
      } else {
        notMatching.add(element);
      }
    }

    return (matching: matching, notMatching: notMatching);
  }
}

// Extensions with type constraints
extension ComparableExtensions<T extends Comparable<T>> on T {
  // Check if value is between two bounds
  bool isBetween(T min, T max) {
    return compareTo(min) >= 0 && compareTo(max) <= 0;
  }

  // Clamp value between bounds
  T clamp(T min, T max) {
    if (compareTo(min) < 0) return min;
    if (compareTo(max) > 0) return max;
    return this;
  }
}

extension ComparableListExtensions<T extends Comparable<T>> on List<T> {
  // Find min and max efficiently
  ({T min, T max})? get minMax {
    if (isEmpty) return null;

    T min = first;
    T max = first;

    for (T element in this) {
      if (element.compareTo(min) < 0) min = element;
      if (element.compareTo(max) > 0) max = element;
    }

    return (min: min, max: max);
  }

  // Check if list is sorted
  bool get isSorted {
    for (int i = 1; i < length; i++) {
      if (this[i].compareTo(this[i - 1]) < 0) return false;
    }
    return true;
  }
}

// Extensions on function types
extension FunctionExtensions<T> on T Function() {
  // Memoize function result
  T Function() memoize() {
    T? cached;
    bool hasValue = false;

    return () {
      if (!hasValue) {
        cached = this();
        hasValue = true;
      }
      return cached as T;
    };
  }

  // Add timing to function
  (T result, Duration duration) timed() {
    Stopwatch stopwatch = Stopwatch()..start();
    T result = this();
    stopwatch.stop();
    return (result, stopwatch.elapsed);
  }
}

extension AsyncFunctionExtensions<T> on Future<T> Function() {
  // Retry function with exponential backoff
  Future<T> retry({
    int maxAttempts = 3,
    Duration initialDelay = const Duration(seconds: 1),
    double backoffMultiplier = 2.0,
  }) async {
    Duration delay = initialDelay;

    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await this();
      } catch (e) {
        if (attempt == maxAttempts) rethrow;

        await Future.delayed(delay);
        delay = Duration(
          milliseconds: (delay.inMilliseconds * backoffMultiplier).round(),
        );
      }
    }

    throw StateError('This should never be reached');
  }

  // Add timeout to function
  Future<T> withTimeout(Duration timeout) async {
    return await this().timeout(timeout);
  }
}

// Extensions on nullable types
extension NullableExtensions<T> on T? {
  // Execute action if not null
  R? let<R>(R Function(T) action) {
    return this != null ? action(this as T) : null;
  }

  // Return this if not null, otherwise return alternative
  T orElse(T alternative) {
    return this ?? alternative;
  }

  // Return this if not null, otherwise compute alternative
  T orElseGet(T Function() alternative) {
    return this ?? alternative();
  }

  // Check if null and execute action
  T? also(void Function(T) action) {
    if (this != null) action(this as T);
    return this;
  }
}

// Multiple extensions on the same type (demonstrating conflicts)
extension StringExtension1 on String {
  String get doubled => this + this;
}

extension StringExtension2 on String {
  String get doubled => '$this $this'; // Different implementation
}

// Named extension to resolve conflicts
extension StringDoubler on String {
  String get doubledWithSpace => '$this $this';
  String get doubledConcatenated => this + this;
}

// Extension on abstract class
abstract class Shape {
  double get area;
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);

  @override
  double get area => 3.14159 * radius * radius;
}

class Rectangle extends Shape {
  final double width, height;
  Rectangle(this.width, this.height);

  @override
  double get area => width * height;
}

extension ShapeExtensions on Shape {
  // Calculate area in different units
  double get areaInSquareFeet =>
      area * 10.764; // Assuming area is in square meters

  // Check if shape is large
  bool get isLarge => area > 100;

  // Get area description
  String get areaDescription {
    if (area < 10) return 'Small';
    if (area < 100) return 'Medium';
    return 'Large';
  }
}

// Static extension methods (using static methods in extensions)
extension MathUtils on num {
  static double pi = 3.14159265359;
  static double e = 2.71828182846;

  // Static method for calculating factorial
  static int factorial(int n) {
    if (n < 0)
      throw ArgumentError('Factorial is not defined for negative numbers');
    if (n <= 1) return 1;

    int result = 1;
    for (int i = 2; i <= n; i++) {
      result *= i;
    }
    return result;
  }

  // Static method for GCD
  static int gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }
}

void demonstrateAdvancedExtensions() {
  print('=== Advanced Extensions Demo ===\n');

  // Generic extensions
  List<String> words = ['hello', 'world', 'dart', 'extensions'];
  print('Words: $words');
  print('Safe get index 2: ${words.safeGet(2)}');
  print('Safe get index 10: ${words.safeGet(10)}');

  // Partition example
  var partition = words.partition((word) => word.length > 4);
  print('Long words: ${partition.matching}');
  print('Short words: ${partition.notMatching}\n');

  // Comparable extensions
  List<int> numbers = [5, 2, 8, 1, 9, 3];
  print('Numbers: $numbers');
  print('Is sorted: ${numbers.isSorted}');

  var minMax = numbers.minMax;
  if (minMax != null) {
    print('Min: ${minMax.min}, Max: ${minMax.max}');
  }

  // Clamp example
  int value = 15;
  print('$value clamped (1-10): ${value.clamp(1, 10)}\n');

  // Function extensions
  String Function() expensiveFunction = () {
    // Simulate expensive operation
    return 'Expensive result';
  };

  var memoized = expensiveFunction.memoize();
  print('First call: ${memoized()}');
  print('Second call (cached): ${memoized()}');

  var (result, duration) = expensiveFunction.timed();
  print('Timed result: $result (took: ${duration.inMicroseconds}μs)\n');

  // Nullable extensions
  String? nullableString = 'Hello';
  String? nullString = null;

  print('Nullable operations:');
  print('Let on non-null: ${nullableString?.let((s) => s.toUpperCase())}');
  print('Let on null: ${nullString?.let((s) => s.toUpperCase())}');
  print('OrElse on null: ${nullString.orElse('Default')}');

  nullableString?.also((s) => print('Also executed: $s'));
  nullString?.also((s) => print('This won\'t print'));
  print();

  // Shape extensions
  List<Shape> shapes = [Circle(5), Rectangle(10, 8), Circle(2)];

  print('Shapes:');
  for (Shape shape in shapes) {
    print(
      'Area: ${shape.area.toStringAsFixed(2)}, '
      'Description: ${shape.areaDescription}, '
      'Large: ${shape.isLarge}',
    );
  }
  print();

  // Static extension methods
  print('Static methods:');
  print('Pi: ${MathUtils.pi}');
  print('Factorial of 5: ${MathUtils.factorial(5)}');
  print('GCD of 48 and 18: ${MathUtils.gcd(48, 18)}');

  // Extension conflicts (would need to be resolved with explicit naming)
  String text = 'Hello';
  print('Doubled with space: ${text.doubledWithSpace}');
  print('Doubled concatenated: ${text.doubledConcatenated}');
}

void demonstrateAsyncExtensions() async {
  print('\n=== Async Extensions Demo ===\n');

  // Async function that might fail
  Future<String> Function() unreliableFunction = () async {
    await Future.delayed(Duration(milliseconds: 100));
    if (DateTime.now().millisecond % 3 == 0) {
      throw Exception('Random failure');
    }
    return 'Success!';
  };

  try {
    String result = await unreliableFunction.retry(maxAttempts: 3);
    print('Retry result: $result');
  } catch (e) {
    print('Failed after retries: $e');
  }

  // Timeout example
  Future<String> Function() slowFunction = () async {
    await Future.delayed(Duration(seconds: 2));
    return 'Slow result';
  };

  try {
    String result = await slowFunction.withTimeout(Duration(seconds: 1));
    print('Timeout result: $result');
  } catch (e) {
    print('Timeout occurred: $e');
  }
}

void main() async {
  demonstrateAdvancedExtensions();
  await demonstrateAsyncExtensions();
}
