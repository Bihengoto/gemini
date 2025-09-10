/*
Extension Best Practices and Guidelines
=======================================

This file covers best practices, common pitfalls, and guidelines for creating
and using extensions effectively in Dart applications.
*/

/*
BEST PRACTICES FOR EXTENSIONS:

1. NAMING CONVENTIONS
   - Use descriptive names that clearly indicate what the extension does
   - Follow PascalCase for extension names
   - Consider prefixing with your library/package name to avoid conflicts

2. SCOPE AND ORGANIZATION
   - Keep extensions focused on a single responsibility
   - Group related extensions in the same file
   - Use separate files for different types or domains

3. DOCUMENTATION
   - Always document public extensions
   - Include examples in documentation
   - Explain any non-obvious behavior

4. PERFORMANCE CONSIDERATIONS
   - Extensions have no runtime overhead
   - Be careful with expensive operations in getters
   - Consider caching results for expensive computations

5. AVOID COMMON PITFALLS
   - Don't add state (instance variables) - extensions can't have fields
   - Be careful with extension conflicts
   - Don't override existing methods
   - Consider null safety carefully
*/

// ✅ GOOD: Well-named, focused extension
extension StringValidation on String {
  /// Checks if the string is a valid email address.
  /// 
  /// Example:
  /// ```dart
  /// 'user@example.com'.isValidEmail; // true
  /// 'invalid-email'.isValidEmail;    // false
  /// ```
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }
  
  /// Checks if the string contains only alphabetic characters.
  bool get isAlphabetic {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }
  
  /// Checks if the string is a valid phone number (simple validation).
  bool get isValidPhoneNumber {
    return RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(this);
  }
}

// ✅ GOOD: Extension with caching for expensive operations
extension StringAnalysis on String {
  static final Map<String, int> _wordCountCache = {};
  
  /// Gets the word count, with caching for performance.
  int get wordCount {
    return _wordCountCache.putIfAbsent(this, () {
      return trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
    });
  }
  
  /// Clears the word count cache.
  static void clearCache() {
    _wordCountCache.clear();
  }
}

// ✅ GOOD: Generic extension with type constraints
extension ComparableListUtils<T extends Comparable<T>> on List<T> {
  /// Finds the median value in the list.
  /// Returns null if the list is empty.
  T? get median {
    if (isEmpty) return null;
    
    List<T> sorted = List.from(this)..sort();
    int middle = sorted.length ~/ 2;
    
    return sorted[middle];
  }
  
  /// Checks if the list is sorted in ascending order.
  bool get isSortedAscending {
    for (int i = 1; i < length; i++) {
      if (this[i].compareTo(this[i - 1]) < 0) return false;
    }
    return true;
  }
}

// ✅ GOOD: Extension with proper null handling
extension SafeStringOperations on String? {
  /// Returns the string if not null and not empty, otherwise returns the fallback.
  String orIfEmpty(String fallback) {
    return (this?.isNotEmpty == true) ? this! : fallback;
  }
  
  /// Safely gets the length, returning 0 for null strings.
  int get safeLength => this?.length ?? 0;
  
  /// Safely converts to uppercase, returning empty string for null.
  String get safeUpperCase => this?.toUpperCase() ?? '';
}

// ❌ BAD: Extension trying to add state (this won't compile)
/*
extension BadStringExtension on String {
  // ❌ This is not allowed - extensions cannot have instance fields
  int _cachedLength = 0;
  
  int get cachedLength {
    if (_cachedLength == 0) {
      _cachedLength = length;
    }
    return _cachedLength;
  }
}
*/

// ❌ BAD: Overly broad extension with unrelated methods
extension BadMixedExtension on String {
  // ❌ These methods don't belong together
  bool get isValidEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  double get asTemperatureInCelsius => double.parse(this);
  List<int> get asBytes => codeUnits;
  DateTime get asDateTime => DateTime.parse(this);
}

// ✅ GOOD: Separate focused extensions
extension StringEmailValidation on String {
  bool get isValidEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
}

extension StringTemperatureConversion on String {
  double get asTemperatureInCelsius => double.parse(this);
  double get asTemperatureInFahrenheit => double.parse(this) * 9/5 + 32;
}

// ✅ GOOD: Extension with proper error handling
extension SafeStringConversion on String {
  /// Safely converts string to int, returning null if conversion fails.
  int? get toIntOrNull {
    try {
      return int.parse(this);
    } catch (e) {
      return null;
    }
  }
  
  /// Safely converts string to double, returning null if conversion fails.
  double? get toDoubleOrNull {
    try {
      return double.parse(this);
    } catch (e) {
      return null;
    }
  }
  
  /// Safely converts string to DateTime, returning null if conversion fails.
  DateTime? get toDateTimeOrNull {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }
}

// ✅ GOOD: Extension with comprehensive documentation
extension ListStatistics<T extends num> on List<T> {
  /// Calculates the arithmetic mean of the list.
  /// 
  /// Returns 0 if the list is empty.
  /// 
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4, 5].mean; // 3.0
  /// <int>[].mean;         // 0.0
  /// ```
  double get mean {
    if (isEmpty) return 0.0;
    return sum / length;
  }
  
  /// Calculates the sum of all elements.
  T get sum => isEmpty ? 0 as T : reduce((a, b) => (a + b) as T);
  
  /// Calculates the standard deviation of the list.
  /// 
  /// Returns 0 if the list has fewer than 2 elements.
  double get standardDeviation {
    if (length < 2) return 0.0;
    
    double avg = mean;
    double sumSquaredDiffs = map((x) => (x - avg) * (x - avg)).sum;
    return sqrt(sumSquaredDiffs / (length - 1));
  }
}

// Import for sqrt function
import 'dart:math';

// ✅ GOOD: Extension with builder pattern
extension ListBuilder<T> on List<T> {
  /// Adds an element and returns the list for chaining.
  List<T> addAndReturn(T element) {
    add(element);
    return this;
  }
  
  /// Adds multiple elements and returns the list for chaining.
  List<T> addAllAndReturn(Iterable<T> elements) {
    addAll(elements);
    return this;
  }
  
  /// Removes an element and returns the list for chaining.
  List<T> removeAndReturn(T element) {
    remove(element);
    return this;
  }
}

// ✅ GOOD: Extension with conditional operations
extension ConditionalOperations<T> on T {
  /// Applies the transform function if the condition is true.
  T applyIf(bool condition, T Function(T) transform) {
    return condition ? transform(this) : this;
  }
  
  /// Applies the transform function if this object is not null.
  R? applyIfNotNull<R>(R Function(T) transform) {
    return transform(this);
  }
}

// Testing and demonstration
void demonstrateBestPractices() {
  print('=== Extension Best Practices Demo ===\n');
  
  // String validation extensions
  String email = 'user@example.com';
  String invalidEmail = 'not-an-email';
  
  print('Email validation:');
  print('$email is valid: ${email.isValidEmail}');
  print('$invalidEmail is valid: ${invalidEmail.isValidEmail}\n');
  
  // Safe string operations
  String? nullString = null;
  String? emptyString = '';
  String? validString = 'Hello World';
  
  print('Safe string operations:');
  print('Null string fallback: ${nullString.orIfEmpty('Default')}');
  print('Empty string fallback: ${emptyString.orIfEmpty('Default')}');
  print('Valid string fallback: ${validString.orIfEmpty('Default')}');
  print('Safe length of null: ${nullString.safeLength}');
  print('Safe uppercase of null: "${nullString.safeUpperCase}"\n');
  
  // Safe conversions
  String numberString = '123';
  String invalidNumber = 'abc';
  
  print('Safe conversions:');
  print('$numberString to int: ${numberString.toIntOrNull}');
  print('$invalidNumber to int: ${invalidNumber.toIntOrNull}');
  print('$numberString to double: ${numberString.toDoubleOrNull}\n');
  
  // List statistics
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print('List statistics for $numbers:');
  print('Sum: ${numbers.sum}');
  print('Mean: ${numbers.mean}');
  print('Standard deviation: ${numbers.standardDeviation.toStringAsFixed(2)}\n');
  
  // Builder pattern
  List<String> items = <String>[]
      .addAndReturn('First')
      .addAllAndReturn(['Second', 'Third'])
      .addAndReturn('Fourth');
  
  print('Builder pattern result: $items\n');
  
  // Conditional operations
  String text = 'hello world';
  String result = text
      .applyIf(true, (s) => s.toUpperCase())
      .applyIf(false, (s) => s.split('').reversed.join(''));
  
  print('Conditional operations: $result');
  
  // Word count with caching
  String longText = 'This is a long text with many words for testing';
  print('Word count (first call): ${longText.wordCount}');
  print('Word count (cached call): ${longText.wordCount}');
  
  // Clear cache
  StringAnalysis.clearCache();
  print('Cache cleared');
}

/*
EXTENSION LIMITATIONS AND CONSIDERATIONS:

1. CANNOT ADD INSTANCE FIELDS
   - Extensions can only add methods, getters, setters, and operators
   - Use static fields or external storage for state

2. STATIC RESOLUTION
   - Extensions are resolved at compile time
   - Cannot be overridden in subclasses
   - Import visibility affects which extensions are available

3. CONFLICTS
   - Multiple extensions with same member names can conflict
   - Use explicit extension names to resolve conflicts
   - Consider using prefixed imports

4. PERFORMANCE
   - No runtime overhead for method calls
   - Be careful with expensive operations in getters
   - Consider caching for expensive computations

5. TESTING
   - Extensions are testable like regular methods
   - Mock the extended type, not the extension
   - Test edge cases and null safety

6. VERSIONING
   - Adding new members to extensions is generally safe
   - Changing existing behavior is breaking
   - Consider deprecation for major changes
*/

void main() {
  demonstrateBestPractices();
}