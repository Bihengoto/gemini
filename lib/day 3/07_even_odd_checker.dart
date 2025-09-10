/*
PRACTICE: EVEN OR ODD CHECKER
This program demonstrates various ways to check if a number is even or odd
*/

import 'dart:io';

void main() {
  print("=== EVEN OR ODD CHECKER ===\n");

  // Method 1: Simple if-else
  print("=== METHOD 1: SIMPLE IF-ELSE ===");
  checkEvenOddMethod1(8);
  checkEvenOddMethod1(15);
  checkEvenOddMethod1(0);

  // Method 2: Using ternary operator
  print("\n=== METHOD 2: TERNARY OPERATOR ===");
  checkEvenOddMethod2(12);
  checkEvenOddMethod2(7);
  checkEvenOddMethod2(-4);

  // Method 3: Interactive version
  print("\n=== METHOD 3: INTERACTIVE VERSION ===");
  print("Enter a number to check if it's even or odd:");

  // Note: In a real Flutter app, you'd get input differently
  // This is for console demonstration
  try {
    String? input = stdin.readLineSync();
    if (input != null) {
      int number = int.parse(input);
      checkEvenOddInteractive(number);
    }
  } catch (e) {
    print("Please enter a valid integer!");
    // Fallback with predefined numbers
    print("Using example numbers instead:");
    checkEvenOddInteractive(42);
    checkEvenOddInteractive(13);
  }

  // Method 4: Batch checking
  print("\n=== METHOD 4: BATCH CHECKING ===");
  List<int> numbers = [1, 2, 3, 4, 5, 10, 15, 20, 25, 100];
  checkMultipleNumbers(numbers);

  // Method 5: Advanced with additional info
  print("\n=== METHOD 5: ADVANCED ANALYSIS ===");
  analyzeNumber(24);
  analyzeNumber(17);
  analyzeNumber(0);
  analyzeNumber(-8);
}

// Method 1: Simple if-else approach
void checkEvenOddMethod1(int number) {
  print("Checking number: $number");

  if (number % 2 == 0) {
    print("$number is EVEN");
  } else {
    print("$number is ODD");
  }
  print("---");
}

// Method 2: Using ternary operator
void checkEvenOddMethod2(int number) {
  String result = number % 2 == 0 ? "EVEN" : "ODD";
  print("$number is $result");
}

// Method 3: Interactive with detailed explanation
void checkEvenOddInteractive(int number) {
  print("Analyzing number: $number");
  print("$number ÷ 2 = ${number / 2}");
  print("$number % 2 = ${number % 2}");

  if (number % 2 == 0) {
    print("Since remainder is 0, $number is EVEN");
  } else {
    print("Since remainder is 1, $number is ODD");
  }
  print("---");
}

// Method 4: Check multiple numbers
void checkMultipleNumbers(List<int> numbers) {
  print("Checking numbers: $numbers");

  List<int> evenNumbers = [];
  List<int> oddNumbers = [];

  for (int number in numbers) {
    if (number % 2 == 0) {
      evenNumbers.add(number);
    } else {
      oddNumbers.add(number);
    }
  }

  print("Even numbers: $evenNumbers");
  print("Odd numbers: $oddNumbers");
  print("Total even: ${evenNumbers.length}");
  print("Total odd: ${oddNumbers.length}");
}

// Method 5: Advanced analysis
void analyzeNumber(int number) {
  print("=== ANALYZING $number ===");

  // Basic even/odd check
  String evenOdd = number % 2 == 0 ? "even" : "odd";
  print("$number is $evenOdd");

  // Additional properties
  String sign =
      number > 0
          ? "positive"
          : number < 0
          ? "negative"
          : "zero";
  print("$number is $sign");

  // Special cases
  if (number == 0) {
    print("Note: 0 is considered even by mathematical convention");
  }

  if (number < 0) {
    print("Note: Negative numbers follow the same even/odd rules");
  }

  // Divisibility info
  if (number != 0) {
    print("$number is divisible by 2: ${number % 2 == 0}");
    if (number % 2 == 0) {
      print("$number ÷ 2 = ${number ~/ 2}");
    }
  }

  print("---");
}
