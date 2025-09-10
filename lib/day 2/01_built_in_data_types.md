# Built-in Data Types in Dart

Dart provides several built-in data types that are fundamental to programming. Let's explore the main ones:

## int (Integer)
- Represents whole numbers (positive, negative, or zero)
- Range: -2^63 to 2^63 - 1 on 64-bit platforms

```dart
int age = 25;
int temperature = -10;
int zero = 0;
```

## double (Double-precision floating-point)
- Represents decimal numbers
- 64-bit double-precision floating point numbers

```dart
double price = 19.99;
double pi = 3.14159;
double negative = -45.67;
```

## String
- Represents text data
- Can be created using single or double quotes
- Supports string interpolation with $

```dart
String name = 'John Doe';
String message = "Hello, World!";
String greeting = 'Hello, $name!';
String calculation = 'The result is ${2 + 3}';
```

## bool (Boolean)
- Represents true or false values
- Used for logical operations and conditions

```dart
bool isActive = true;
bool isComplete = false;
bool canVote = age >= 18;
```

## Key Points:
- All these types are objects in Dart
- Dart is strongly typed but supports type inference
- Numbers (int and double) extend the num class
- Strings support multi-line with triple quotes