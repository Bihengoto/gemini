// Day 4: For Loops in Dart

void main() {
  print('=== FOR LOOPS EXAMPLES ===\n');

  // 1. Basic for loop
  print('1. Basic for loop (0 to 4):');
  for (int i = 0; i < 5; i++) {
    print('Iteration: $i');
  }

  print('\n2. For loop with step increment:');
  for (int i = 0; i <= 10; i += 2) {
    print('Even number: $i');
  }

  print('\n3. Countdown for loop:');
  for (int i = 5; i >= 1; i--) {
    print('Countdown: $i');
  }

  // 4. For-in loop with lists
  print('\n4. For-in loop with list:');
  List<String> fruits = ['Apple', 'Banana', 'Orange', 'Mango'];
  for (String fruit in fruits) {
    print('Fruit: $fruit');
  }

  // 5. For loop with break
  print('\n5. For loop with break:');
  for (int i = 1; i <= 10; i++) {
    if (i == 6) {
      print('Breaking at $i');
      break;
    }
    print('Number: $i');
  }

  // 6. For loop with continue
  print('\n6. For loop with continue (skip even numbers):');
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
      continue; // Skip even numbers
    }
    print('Odd number: $i');
  }
}
