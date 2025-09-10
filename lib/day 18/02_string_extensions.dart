/*
String Extensions - Comprehensive Examples
==========================================

This file demonstrates various useful extensions for the String class,
including the required capitalize() method and many other practical utilities.
*/

extension StringUtilities on String {
  // Required: Capitalize method
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  // Title case - capitalize each word
  String toTitleCase() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  // Check if string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  // Check if string is numeric
  bool get isNumeric {
    return double.tryParse(this) != null;
  }

  // Remove all whitespace
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  // Truncate string with ellipsis
  String truncate(int maxLength, [String suffix = '...']) {
    if (length <= maxLength) return this;
    return substring(0, maxLength - suffix.length) + suffix;
  }

  // Count occurrences of a substring
  int countOccurrences(String substring) {
    int count = 0;
    int index = 0;
    while ((index = indexOf(substring, index)) != -1) {
      count++;
      index += substring.length;
    }
    return count;
  }

  // Check if string is palindrome
  bool get isPalindrome {
    String cleaned = toLowerCase().removeWhitespace();
    return cleaned == cleaned.split('').reversed.join('');
  }

  // Convert to snake_case
  String toSnakeCase() {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceFirst(RegExp(r'^_'), '');
  }

  // Convert to camelCase
  String toCamelCase() {
    List<String> words = split(RegExp(r'[_\s]+'));
    if (words.isEmpty) return this;

    String result = words.first.toLowerCase();
    for (int i = 1; i < words.length; i++) {
      result += words[i].capitalize();
    }
    return result;
  }

  // Extract numbers from string
  List<int> extractNumbers() {
    return RegExp(
      r'\d+',
    ).allMatches(this).map((match) => int.parse(match.group(0)!)).toList();
  }

  // Mask sensitive information (like credit card numbers)
  String mask({
    int visibleStart = 4,
    int visibleEnd = 4,
    String maskChar = '*',
  }) {
    if (length <= visibleStart + visibleEnd) return this;

    String start = substring(0, visibleStart);
    String end = substring(length - visibleEnd);
    String middle = maskChar * (length - visibleStart - visibleEnd);

    return start + middle + end;
  }
}

void demonstrateStringExtensions() {
  print('=== String Extensions Demo ===\n');

  // Basic capitalize
  String name = 'john doe';
  print('Original: $name');
  print('Capitalized: ${name.capitalize()}');
  print('Title Case: ${name.toTitleCase()}\n');

  // Email validation
  String email1 = 'user@example.com';
  String email2 = 'invalid-email';
  print('$email1 is valid email: ${email1.isValidEmail}');
  print('$email2 is valid email: ${email2.isValidEmail}\n');

  // Numeric check
  String num1 = '123.45';
  String num2 = 'abc123';
  print('$num1 is numeric: ${num1.isNumeric}');
  print('$num2 is numeric: ${num2.isNumeric}\n');

  // Text manipulation
  String text = 'Hello World Programming';
  print('Original: $text');
  print('No whitespace: ${text.removeWhitespace()}');
  print('Truncated: ${text.truncate(10)}');
  print('Snake case: ${text.toSnakeCase()}');
  print('Camel case: ${text.toCamelCase()}\n');

  // Palindrome check
  String palindrome = 'A man a plan a canal Panama';
  print('$palindrome is palindrome: ${palindrome.isPalindrome}');

  // Count occurrences
  String sentence = 'The quick brown fox jumps over the lazy dog';
  print(
    'Occurrences of "the": ${sentence.toLowerCase().countOccurrences('the')}\n',
  );

  // Extract numbers
  String mixed = 'I have 5 apples and 10 oranges, total 15 fruits';
  print('Numbers in "$mixed": ${mixed.extractNumbers()}\n');

  // Mask sensitive data
  String creditCard = '1234567890123456';
  print('Credit card: ${creditCard.mask()}');
}

void main() {
  demonstrateStringExtensions();
}
