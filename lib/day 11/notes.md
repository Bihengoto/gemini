# Day 11: Getters & Setters

## Overview
Getters and setters are special methods that provide controlled access to class properties. They allow you to define custom logic when reading or writing to class fields.

## Key Concepts

### Getters
- Used to retrieve values from private fields
- Can perform calculations or transformations
- Defined using the `get` keyword
- Called like properties (no parentheses)

### Setters
- Used to assign values to private fields
- Can include validation logic
- Defined using the `set` keyword
- Called with assignment operator (=)

## Benefits
1. **Encapsulation**: Hide internal implementation details
2. **Validation**: Ensure data integrity when setting values
3. **Computed Properties**: Create properties that are calculated on-the-fly
4. **Backward Compatibility**: Change internal structure without breaking external code

## Syntax
```dart
class MyClass {
  String _privateField;
  
  // Getter
  String get publicProperty => _privateField;
  
  // Setter
  set publicProperty(String value) {
    _privateField = value;
  }
}
```

## Practice Goal
Create a Person class with:
- Private firstName and lastName fields
- A custom fullName getter that combines both names
- Proper setters with validation