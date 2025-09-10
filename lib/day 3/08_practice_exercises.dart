/*
PRACTICE EXERCISES - Day 3: Operators & Control Flow

Try to solve these exercises to practice what you've learned!
*/

void main() {
  print("=== PRACTICE EXERCISES ===\n");

  // Run all practice exercises
  exercise1();
  exercise2();
  exercise3();
  exercise4();
  exercise5();
  exercise6();
  exercise7();
  exercise8();
}

// Exercise 1: Calculator
void exercise1() {
  print("=== EXERCISE 1: SIMPLE CALCULATOR ===");
  print("Create a simple calculator that performs basic operations");

  double num1 = 15.5;
  double num2 = 4.2;
  String operation = "+";

  double result;

  if (operation == "+") {
    result = num1 + num2;
  } else if (operation == "-") {
    result = num1 - num2;
  } else if (operation == "*") {
    result = num1 * num2;
  } else if (operation == "/") {
    result = num2 != 0 ? num1 / num2 : 0;
  } else {
    result = 0;
    print("Invalid operation");
  }

  print("$num1 $operation $num2 = $result");
  print("---\n");
}

// Exercise 2: Grade Calculator
void exercise2() {
  print("=== EXERCISE 2: GRADE CALCULATOR ===");
  print("Calculate letter grade based on percentage");

  List<int> scores = [95, 87, 76, 65, 45];

  for (int score in scores) {
    String grade;
    String comment;

    if (score >= 90) {
      grade = "A";
      comment = "Excellent!";
    } else if (score >= 80) {
      grade = "B";
      comment = "Good job!";
    } else if (score >= 70) {
      grade = "C";
      comment = "Average";
    } else if (score >= 60) {
      grade = "D";
      comment = "Below average";
    } else {
      grade = "F";
      comment = "Failed";
    }

    print("Score: $score% → Grade: $grade ($comment)");
  }
  print("---\n");
}

// Exercise 3: Age Category
void exercise3() {
  print("=== EXERCISE 3: AGE CATEGORY ===");
  print("Categorize people by age groups");

  List<int> ages = [5, 12, 16, 25, 45, 70];

  for (int age in ages) {
    String category =
        age < 13
            ? "Child"
            : age < 20
            ? "Teenager"
            : age < 60
            ? "Adult"
            : "Senior";

    print("Age $age: $category");
  }
  print("---\n");
}

// Exercise 4: Number Properties
void exercise4() {
  print("=== EXERCISE 4: NUMBER PROPERTIES ===");
  print("Analyze various properties of numbers");

  List<int> numbers = [0, -5, 12, -8, 15, 100];

  for (int num in numbers) {
    print("Number: $num");

    // Even or odd
    String evenOdd = num % 2 == 0 ? "even" : "odd";
    print("  Even/Odd: $evenOdd");

    // Positive, negative, or zero
    String sign =
        num > 0
            ? "positive"
            : num < 0
            ? "negative"
            : "zero";
    print("  Sign: $sign");

    // Divisible by 3
    bool divBy3 = num % 3 == 0;
    print("  Divisible by 3: $divBy3");

    // Divisible by 5
    bool divBy5 = num % 5 == 0;
    print("  Divisible by 5: $divBy5");

    print("");
  }
  print("---\n");
}

// Exercise 5: Login Validator
void exercise5() {
  print("=== EXERCISE 5: LOGIN VALIDATOR ===");
  print("Validate user login credentials");

  // Test cases
  List<Map<String, dynamic>> users = [
    {"username": "admin", "password": "admin123", "active": true},
    {"username": "user1", "password": "wrongpass", "active": true},
    {"username": "admin", "password": "admin123", "active": false},
    {"username": "guest", "password": "guest123", "active": true},
  ];

  String correctUsername = "admin";
  String correctPassword = "admin123";

  for (var user in users) {
    String username = user["username"];
    String password = user["password"];
    bool isActive = user["active"];

    print("Attempting login: $username");

    if (username == correctUsername && password == correctPassword) {
      if (isActive) {
        print("  ✓ Login successful! Welcome, $username.");
      } else {
        print("  ✗ Account is deactivated.");
      }
    } else {
      print("  ✗ Invalid credentials.");
    }
    print("");
  }
  print("---\n");
}

// Exercise 6: Temperature Converter & Advisor
void exercise6() {
  print("=== EXERCISE 6: TEMPERATURE ADVISOR ===");
  print("Convert temperature and give clothing advice");

  List<double> celsiusTemps = [0, 15, 25, 35, -10];

  for (double celsius in celsiusTemps) {
    double fahrenheit = (celsius * 9 / 5) + 32;

    String advice;
    if (celsius < 0) {
      advice = "Very cold! Wear heavy winter clothes.";
    } else if (celsius < 10) {
      advice = "Cold! Wear a warm jacket.";
    } else if (celsius < 20) {
      advice = "Cool. A light jacket would be good.";
    } else if (celsius < 30) {
      advice = "Pleasant weather. Comfortable clothing.";
    } else {
      advice = "Hot! Wear light, breathable clothes.";
    }

    print("${celsius}°C = ${fahrenheit.toStringAsFixed(1)}°F");
    print("Advice: $advice");
    print("");
  }
  print("---\n");
}

// Exercise 7: Discount Calculator
void exercise7() {
  print("=== EXERCISE 7: DISCOUNT CALCULATOR ===");
  print("Calculate discounts based on purchase amount and membership");

  List<Map<String, dynamic>> purchases = [
    {"amount": 50.0, "isMember": false},
    {"amount": 150.0, "isMember": true},
    {"amount": 300.0, "isMember": false},
    {"amount": 75.0, "isMember": true},
  ];

  for (var purchase in purchases) {
    double amount = purchase["amount"];
    bool isMember = purchase["isMember"];

    double discountRate = 0.0;

    // Determine discount rate
    if (amount >= 200) {
      discountRate = isMember ? 0.20 : 0.15; // 20% or 15%
    } else if (amount >= 100) {
      discountRate = isMember ? 0.15 : 0.10; // 15% or 10%
    } else if (amount >= 50) {
      discountRate = isMember ? 0.10 : 0.05; // 10% or 5%
    } else {
      discountRate = isMember ? 0.05 : 0.0; // 5% or 0%
    }

    double discount = amount * discountRate;
    double finalAmount = amount - discount;

    print("Purchase: \$${amount.toStringAsFixed(2)}");
    print("Member: ${isMember ? 'Yes' : 'No'}");
    print(
      "Discount: ${(discountRate * 100).toStringAsFixed(0)}% (\$${discount.toStringAsFixed(2)})",
    );
    print("Final amount: \$${finalAmount.toStringAsFixed(2)}");
    print("");
  }
  print("---\n");
}

// Exercise 8: Number Guessing Game Logic
void exercise8() {
  print("=== EXERCISE 8: NUMBER GUESSING GAME LOGIC ===");
  print("Implement the logic for a number guessing game");

  int secretNumber = 42;
  List<int> guesses = [25, 50, 40, 42, 45];

  print("Secret number: $secretNumber");
  print("Player guesses: $guesses\n");

  for (int i = 0; i < guesses.length; i++) {
    int guess = guesses[i];
    int attempt = i + 1;

    print("Attempt $attempt: Guess = $guess");

    if (guess == secretNumber) {
      print("  🎉 Correct! You found the number in $attempt attempts!");
      break;
    } else if (guess < secretNumber) {
      print("  📈 Too low! Try a higher number.");
    } else {
      print("  📉 Too high! Try a lower number.");
    }

    // Give additional hints
    int difference = (guess - secretNumber).abs();
    if (difference <= 5) {
      print("  🔥 You're very close!");
    } else if (difference <= 10) {
      print("  🌡️ You're getting warm!");
    } else {
      print("  🧊 You're cold!");
    }

    print("");
  }
  print("---\n");
}
