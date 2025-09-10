// Day 16: How to Add and Use Packages
// ===================================

/*
STEP-BY-STEP GUIDE TO ADDING PACKAGES:

1. FIND A PACKAGE:
   - Visit pub.dev
   - Search for functionality you need
   - Check package popularity, likes, and pub points
   - Read documentation and examples

2. ADD TO PUBSPEC.YAML:
   - Open pubspec.yaml
   - Add package under dependencies section
   - Maintain proper indentation (2 spaces)

3. INSTALL THE PACKAGE:
   - Run: flutter pub get
   - Or use IDE: Pub get button

4. IMPORT IN YOUR CODE:
   - Add import statement at top of Dart file
   - Use the package functionality

5. FOLLOW PACKAGE DOCUMENTATION:
   - Each package has its own API
   - Check examples and usage instructions
*/

// Example: Adding the 'http' package for network requests

/*
STEP 1: Add to pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0  # Add this line

STEP 2: Run flutter pub get

STEP 3: Import and use in your code
*/

import 'dart:convert';
// import 'package:http/http.dart' as http; // Uncomment when http package is added

void demonstratePackageUsage() {
  print('Package Usage Example:');
  print('1. Add package to pubspec.yaml');
  print('2. Run flutter pub get');
  print('3. Import package in your Dart file');
  print('4. Use package functionality');
}

// Example function that would use http package
Future<void> fetchDataExample() async {
  print('This function would make HTTP requests using the http package');

  // Uncomment when http package is added:
  /*
  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/1'),
    );
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Title: ${data['title']}');
    } else {
      print('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
  }
  */
}

void main() {
  demonstratePackageUsage();
  fetchDataExample();
}
