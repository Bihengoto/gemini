/*
ARITHMETIC OPERATORS EXAMPLES
*/

void main() {
  print("=== ARITHMETIC OPERATORS ===\n");

  int a = 15;
  int b = 4;

  print("Numbers: a = $a, b = $b\n");

  // Basic arithmetic operations
  print("Addition: $a + $b = ${a + b}");
  print("Subtraction: $a - $b = ${a - b}");
  print("Multiplication: $a * $b = ${a * b}");
  print("Division: $a / $b = ${a / b}");
  print("Integer Division: $a ~/ $b = ${a ~/ b}");
  print("Modulo: $a % $b = ${a % b}");

  print("\n=== INCREMENT/DECREMENT ===");

  int counter = 10;
  print("Initial counter: $counter");

  // Pre-increment
  print("Pre-increment (++counter): ${++counter}");
  print("Counter after pre-increment: $counter");

  // Post-increment
  print("Post-increment (counter++): ${counter++}");
  print("Counter after post-increment: $counter");

  // Pre-decrement
  print("Pre-decrement (--counter): ${--counter}");
  print("Counter after pre-decrement: $counter");

  // Post-decrement
  print("Post-decrement (counter--): ${counter--}");
  print("Counter after post-decrement: $counter");

  print("\n=== ASSIGNMENT OPERATORS ===");

  int x = 10;
  print("Initial x: $x");

  x += 5; // x = x + 5
  print("After x += 5: $x");

  x -= 3; // x = x - 3
  print("After x -= 3: $x");

  x *= 2; // x = x * 2
  print("After x *= 2: $x");

  x ~/= 4; // x = x ~/ 4
  print("After x ~/= 4: $x");
}
