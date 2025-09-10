# Day 18: Extensions in Dart

Welcome to Day 18 of your Dart learning journey! Today we explore **Extensions** - a powerful feature that allows you to add new functionality to existing classes without modifying their source code.

## 📚 What You'll Learn

Extensions enable you to:
- Add methods, getters, setters, and operators to existing types
- Extend built-in types like String, List, int, DateTime
- Extend third-party library classes
- Extend your own custom classes
- Create generic extensions with type constraints

## 📁 File Structure

### Core Concepts
1. **`01_extensions_overview.dart`** - Introduction to extensions and basic syntax
2. **`02_string_extensions.dart`** - Comprehensive String extensions including the required `capitalize()` method
3. **`03_numeric_extensions.dart`** - Extensions for int, double, and num types
4. **`04_collection_extensions.dart`** - Extensions for List, Set, Map, and Iterable
5. **`05_datetime_extensions.dart`** - DateTime and Duration extensions

### Advanced Topics
6. **`06_custom_class_extensions.dart`** - Extensions for custom classes and objects
7. **`07_advanced_extensions.dart`** - Generic extensions, type constraints, and advanced patterns
8. **`08_extension_best_practices.dart`** - Best practices, guidelines, and common pitfalls

### Practice
9. **`09_practical_exercises.dart`** - Hands-on exercises with solutions

## 🎯 Key Features Covered

### Basic Extension Syntax
```dart
extension ExtensionName on TargetType {
  // methods, getters, setters, operators
}
```

### String Extensions (Required Practice)
```dart
extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

// Usage
'hello world'.capitalize(); // 'Hello world'
```

### Generic Extensions
```dart
extension ListExtensions<T> on List<T> {
  T? get secondOrNull => length >= 2 ? this[1] : null;
}
```

### Extensions with Type Constraints
```dart
extension ComparableExtensions<T extends Comparable<T>> on T {
  bool isBetween(T min, T max) {
    return compareTo(min) >= 0 && compareTo(max) <= 0;
  }
}
```

## 🚀 Running the Examples

Each file can be run independently:

```bash
# Run basic overview
dart run lib/day\ 18/01_extensions_overview.dart

# Run string extensions (includes required capitalize method)
dart run lib/day\ 18/02_string_extensions.dart

# Run practical exercises
dart run lib/day\ 18/09_practical_exercises.dart
```

## 💡 Key Benefits

1. **Clean Code**: Add functionality without inheritance
2. **Type Safety**: Extensions are resolved at compile time
3. **No Performance Overhead**: Extensions compile to regular method calls
4. **Flexibility**: Extend any type, including sealed/final classes
5. **Discoverability**: Extensions appear in IDE autocomplete

## ⚠️ Important Limitations

1. **No Instance Fields**: Extensions cannot add instance variables
2. **Static Resolution**: Extensions are resolved at compile time
3. **Import Visibility**: Only imported extensions are available
4. **Conflicts**: Multiple extensions with same names can conflict

## 🎯 Practice Exercises

The `09_practical_exercises.dart` file includes:

1. **String Capitalize** (Required) - Implement the `capitalize()` method
2. **List Utilities** - Add utility methods to List
3. **DateTime Utilities** - Enhance DateTime with useful methods
4. **Map Enhancements** - Add advanced Map operations
5. **Numeric Range** - Add range and conversion methods to numbers
6. **Custom Class Extensions** - Extend your own classes

## 🔍 Best Practices

1. **Naming**: Use descriptive names and consider prefixing to avoid conflicts
2. **Focus**: Keep extensions focused on single responsibility
3. **Documentation**: Always document public extensions with examples
4. **Performance**: Be careful with expensive operations in getters
5. **Null Safety**: Handle nullable types appropriately

## 🌟 Real-World Applications

Extensions are commonly used for:
- **String Validation**: Email, phone number, URL validation
- **Collection Utilities**: Safe access, filtering, transformations
- **Date/Time Formatting**: Custom date formats and calculations
- **Numeric Operations**: Currency formatting, unit conversions
- **API Enhancements**: Adding convenience methods to library classes

## 📖 Additional Resources

- [Dart Language Tour - Extensions](https://dart.dev/guides/language/extension-methods)
- [Effective Dart - Extensions](https://dart.dev/guides/language/effective-dart)
- [Extension Methods Design](https://github.com/dart-lang/language/blob/master/accepted/2.7/static-extension-methods/feature-specification.md)

## 🎉 What's Next?

After mastering extensions, you'll be able to:
- Create more expressive and readable code
- Add functionality to any existing type
- Build reusable utility libraries
- Enhance third-party APIs with custom methods

Extensions are a powerful tool that can significantly improve your code's readability and maintainability. Practice creating extensions for different types and scenarios to become proficient with this feature!