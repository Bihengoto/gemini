/*
LOGICAL OPERATORS EXAMPLES
*/

void main() {
  print("=== LOGICAL OPERATORS ===\n");

  bool isLoggedIn = true;
  bool hasPermission = false;
  bool isAdmin = true;

  print("Variables:");
  print("isLoggedIn: $isLoggedIn");
  print("hasPermission: $hasPermission");
  print("isAdmin: $isAdmin\n");

  // Logical AND (&&)
  print("=== LOGICAL AND (&&) ===");
  print("isLoggedIn && hasPermission: ${isLoggedIn && hasPermission}");
  print("isLoggedIn && isAdmin: ${isLoggedIn && isAdmin}");

  // Logical OR (||)
  print("\n=== LOGICAL OR (||) ===");
  print("hasPermission || isAdmin: ${hasPermission || isAdmin}");
  print("isLoggedIn || hasPermission: ${isLoggedIn || hasPermission}");

  // Logical NOT (!)
  print("\n=== LOGICAL NOT (!) ===");
  print("!isLoggedIn: ${!isLoggedIn}");
  print("!hasPermission: ${!hasPermission}");
  print("!isAdmin: ${!isAdmin}");

  print("\n=== PRACTICAL EXAMPLES ===");

  // User access control
  bool canAccessSystem = isLoggedIn && (hasPermission || isAdmin);
  print("Can access system: $canAccessSystem");

  // Age and license check
  int age = 20;
  bool hasLicense = true;
  bool canDrive = age >= 18 && hasLicense;
  print("\nAge: $age, Has License: $hasLicense");
  print("Can drive: $canDrive");

  // Weather conditions
  bool isSunny = false;
  bool isWarm = true;
  bool hasUmbrella = true;

  bool shouldGoOut = (isSunny && isWarm) || (!isSunny && hasUmbrella);
  print(
    "\nWeather - Sunny: $isSunny, Warm: $isWarm, Has Umbrella: $hasUmbrella",
  );
  print("Should go out: $shouldGoOut");

  // Complex logical expression
  int score = 85;
  bool hasBonus = true;
  bool isPassing = (score >= 60) && (score >= 80 || hasBonus);
  print("\nScore: $score, Has Bonus: $hasBonus");
  print("Is passing: $isPassing");

  // Short-circuit evaluation example
  print("\n=== SHORT-CIRCUIT EVALUATION ===");
  bool result1 = false && (5 / 0 > 1); // Won't evaluate second part
  print("false && (5/0 > 1): $result1"); // Safe because of short-circuit

  bool result2 = true || (5 / 0 > 1); // Won't evaluate second part
  print("true || (5/0 > 1): $result2"); // Safe because of short-circuit
}
