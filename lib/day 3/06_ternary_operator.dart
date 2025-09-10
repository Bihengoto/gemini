/*
TERNARY OPERATOR EXAMPLES
Syntax: condition ? expression1 : expression2
*/

void main() {
  print("=== TERNARY OPERATOR ===\n");

  // Basic ternary operator
  print("=== BASIC TERNARY OPERATOR ===");
  int age = 20;
  String status = age >= 18 ? "Adult" : "Minor";
  print("Age: $age");
  print("Status: $status");

  // Comparing with if-else
  print("\n=== COMPARISON WITH IF-ELSE ===");
  int num1 = 15;
  int num2 = 25;

  // Using ternary operator
  int max = num1 > num2 ? num1 : num2;
  print("Numbers: $num1, $num2");
  print("Maximum (using ternary): $max");

  // Equivalent if-else
  int maxIfElse;
  if (num1 > num2) {
    maxIfElse = num1;
  } else {
    maxIfElse = num2;
  }
  print("Maximum (using if-else): $maxIfElse");

  // Multiple ternary operators
  print("\n=== MULTIPLE TERNARY OPERATORS ===");
  int score = 85;
  String grade =
      score >= 90
          ? "A"
          : score >= 80
          ? "B"
          : score >= 70
          ? "C"
          : score >= 60
          ? "D"
          : "F";

  print("Score: $score");
  print("Grade: $grade");

  // Ternary in print statements
  print("\n=== TERNARY IN PRINT STATEMENTS ===");
  bool isLoggedIn = true;
  print("User is ${isLoggedIn ? 'logged in' : 'not logged in'}");

  int temperature = 28;
  print("It's ${temperature > 25 ? 'warm' : 'cool'} today (${temperature}°C)");

  // Ternary with different data types
  print("\n=== TERNARY WITH DIFFERENT DATA TYPES ===");
  bool hasDiscount = true;
  double originalPrice = 100.0;
  double finalPrice = hasDiscount ? originalPrice * 0.8 : originalPrice;

  print("Original price: \$${originalPrice}");
  print("Has discount: $hasDiscount");
  print("Final price: \$${finalPrice}");

  // Nested ternary (use sparingly)
  print("\n=== NESTED TERNARY (ADVANCED) ===");
  int hour = 14;
  String timeOfDay =
      hour < 12
          ? "Morning"
          : hour < 18
          ? "Afternoon"
          : "Evening";

  print("Hour: $hour");
  print("Time of day: $timeOfDay");

  // Practical examples
  print("\n=== PRACTICAL EXAMPLES ===");

  // Even/odd check
  int number = 7;
  String evenOdd = number % 2 == 0 ? "even" : "odd";
  print("$number is $evenOdd");

  // Pass/fail
  int examScore = 75;
  String result = examScore >= 60 ? "Pass" : "Fail";
  print("Exam score: $examScore - Result: $result");

  // Discount calculation
  int quantity = 15;
  double unitPrice = 10.0;
  double total =
      quantity >= 10
          ? unitPrice * quantity * 0.9
          : // 10% discount for bulk
          unitPrice * quantity;

  print("Quantity: $quantity, Unit price: \$${unitPrice}");
  print(
    "Total: \$${total} ${quantity >= 10 ? '(10% bulk discount applied)' : ''}",
  );
}
