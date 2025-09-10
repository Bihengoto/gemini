/*
CONDITIONAL STATEMENTS EXAMPLES
*/

void main() {
  print("=== CONDITIONAL STATEMENTS ===\n");

  // Simple if statement
  print("=== SIMPLE IF STATEMENT ===");
  int temperature = 25;
  print("Temperature: ${temperature}°C");

  if (temperature > 30) {
    print("It's hot outside!");
  }

  if (temperature <= 30) {
    print("Temperature is comfortable.");
  }

  // If-else statement
  print("\n=== IF-ELSE STATEMENT ===");
  int age = 17;
  print("Age: $age");

  if (age >= 18) {
    print("You are an adult.");
  } else {
    print("You are a minor.");
  }

  // If-else if-else statement
  print("\n=== IF-ELSE IF-ELSE STATEMENT ===");
  int score = 85;
  print("Score: $score");

  if (score >= 90) {
    print("Grade: A (Excellent!)");
  } else if (score >= 80) {
    print("Grade: B (Good job!)");
  } else if (score >= 70) {
    print("Grade: C (Average)");
  } else if (score >= 60) {
    print("Grade: D (Below Average)");
  } else {
    print("Grade: F (Failed)");
  }

  // Nested if statements
  print("\n=== NESTED IF STATEMENTS ===");
  bool isWeekend = true;
  bool hasHomework = false;

  print("Is weekend: $isWeekend, Has homework: $hasHomework");

  if (isWeekend) {
    print("It's weekend!");
    if (hasHomework) {
      print("But you have homework to do.");
    } else {
      print("Time to relax and have fun!");
    }
  } else {
    print("It's a weekday. Time for work/school.");
  }

  // Multiple conditions
  print("\n=== MULTIPLE CONDITIONS ===");
  String weather = "sunny";
  int temp = 22;

  print("Weather: $weather, Temperature: ${temp}°C");

  if (weather == "sunny" && temp > 20) {
    print("Perfect day for outdoor activities!");
  } else if (weather == "rainy" || temp < 10) {
    print("Better stay indoors.");
  } else {
    print("It's an okay day.");
  }

  // Practical example: Login system
  print("\n=== PRACTICAL EXAMPLE: LOGIN SYSTEM ===");
  String username = "admin";
  String password = "password123";
  bool isAccountActive = true;

  if (username == "admin" && password == "password123") {
    if (isAccountActive) {
      print("Login successful! Welcome, $username.");
    } else {
      print("Account is deactivated. Contact support.");
    }
  } else {
    print("Invalid username or password.");
  }
}
