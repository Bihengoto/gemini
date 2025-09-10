// Day 4: Do-While Loops in Dart

void main() {
  print('=== DO-WHILE LOOPS EXAMPLES ===\n');

  // 1. Basic do-while loop
  print('1. Basic do-while loop:');
  int counter = 1;
  do {
    print('Execution: $counter');
    counter++;
  } while (counter <= 3);

  // 2. Do-while vs while comparison
  print('\n2. Do-while executes at least once:');
  int falseCondition = 10;

  print('Do-while with false condition:');
  do {
    print('This will execute once even though condition is false');
    falseCondition++;
  } while (falseCondition < 10);

  print('While with false condition:');
  int anotherFalse = 10;
  while (anotherFalse < 10) {
    print('This will never execute');
    anotherFalse++;
  }

  // 3. Menu simulation with do-while
  print('\n3. Menu simulation:');
  int choice = 0;
  int menuCount = 0;

  do {
    menuCount++;
    print('--- Menu (Attempt $menuCount) ---');
    print('1. Option A');
    print('2. Option B');
    print('3. Exit');

    // Simulate user choice
    if (menuCount == 1)
      choice = 1;
    else if (menuCount == 2)
      choice = 2;
    else
      choice = 3;

    print('Selected: $choice');

    switch (choice) {
      case 1:
        print('You selected Option A');
        break;
      case 2:
        print('You selected Option B');
        break;
      case 3:
        print('Exiting...');
        break;
      default:
        print('Invalid choice');
    }
    print('');
  } while (choice != 3);

  // 4. Do-while with break and continue
  print('4. Do-while with break and continue:');
  int num = 0;
  do {
    num++;
    if (num % 2 == 0) {
      continue; // Skip even numbers
    }
    if (num > 7) {
      print('Breaking at $num');
      break;
    }
    print('Odd number: $num');
  } while (num < 15);
}
