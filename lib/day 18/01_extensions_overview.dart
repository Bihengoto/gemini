/*
Day 18: Extensions in Dart
==========================

Extensions allow you to add new functionality to existing classes without 
modifying their source code or creating a subclass. This is particularly 
useful when working with classes from libraries you don't control.

Key Concepts:
1. Extensions add methods, getters, setters, and operators to existing types
2. They don't add instance variables (fields)
3. Extensions are resolved statically at compile time
4. They can be applied to any type: built-in types, library types, or your own types

Syntax:
extension ExtensionName on TargetType {
  // methods, getters, setters, operators
}

Benefits:
- Clean, readable code
- No inheritance hierarchy pollution
- Can extend sealed/final classes
- Type-safe additions to existing APIs
*/

// Basic extension example
extension StringExtensions on String {
  // Method to capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  // Getter for word count
  int get wordCount => trim().split(RegExp(r'\s+')).length;

  // Method to reverse string
  String reverse() => split('').reversed.join('');
}

void demonstrateBasicExtensions() {
  print('=== Basic String Extensions ===');

  String text = 'hello world';
  print('Original: $text');
  print('Capitalized: ${text.capitalize()}');
  print('Word count: ${text.wordCount}');
  print('Reversed: ${text.reverse()}');

  // Extensions work on string literals too
  print('Direct usage: ${'dart programming'.capitalize()}');
}

void main() {
  demonstrateBasicExtensions();
}
