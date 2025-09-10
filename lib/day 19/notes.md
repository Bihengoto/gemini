# Day 19: Callable Classes & Enums

## Overview
Today we'll explore two important Dart concepts:
1. **Callable Classes** - Making class instances behave like functions
2. **Enums** - Representing fixed sets of constant values

## Callable Classes

### What are Callable Classes?
A callable class is a class that can be invoked like a function by implementing the `call()` method. This allows instances of the class to be called with parentheses and arguments.

### Key Points:
- Implement the `call()` method to make a class callable
- The `call()` method can have any signature (parameters and return type)
- Useful for creating function-like objects with state
- Common use cases: callbacks, event handlers, mathematical functions

### Syntax:
```dart
class MyCallableClass {
  // Class properties and methods
  
  // The call method makes the class callable
  ReturnType call(parameters) {
    // Implementation
  }
}
```

## Enums

### What are Enums?
Enums (enumerations) represent a fixed number of constant values. They're perfect for representing a set of related constants like colors, days of the week, or states.

### Key Points:
- Declared using the `enum` keyword
- Values are implicitly static and const
- Each enum value has an `index` property (0-based)
- Enums have a `values` property that returns all enum values
- Enhanced enums (Dart 2.17+) can have methods, properties, and constructors

### Basic Syntax:
```dart
enum EnumName {
  value1,
  value2,
  value3,
}
```

### Enhanced Enum Syntax:
```dart
enum EnumName {
  value1('data1'),
  value2('data2');
  
  const EnumName(this.data);
  final String data;
  
  // Methods can be added
  void someMethod() {
    // Implementation
  }
}
```

## Practice Exercise
Create an enum for LightColors with red, green, and yellow values, and demonstrate both basic and enhanced enum features.