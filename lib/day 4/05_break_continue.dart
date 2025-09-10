// Day 4: Break and Continue Statements

void main() {
  print('=== BREAK AND CONTINUE EXAMPLES ===\n');

  // 1. Break in for loop
  print('1. Break in for loop:');
  print('Finding first number divisible by 7:');
  for (int i = 1; i <= 50; i++) {
    if (i % 7 == 0) {
      print('Found: $i');
      break; // Exit the loop
    }
    print('Checking: $i');
  }

  // 2. Continue in for loop
  print('\n2. Continue in for loop:');
  print('Printing only odd numbers from 1 to 10:');
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
      continue; // Skip even numbers
    }
    print('Odd: $i');
  }

  // 3. Break in while loop
  print('\n3. Break in while loop:');
  print('Guessing game simulation:');
  int secretNumber = 7;
  int guess = 1;

  while (true) {
    print('Guessing: $guess');
    if (guess == secretNumber) {
      print('Correct! The number was $secretNumber');
      break;
    }
    if (guess > 10) {
      print('Too many attempts!');
      break;
    }
    guess++;
  }

  // 4. Continue in while loop
  print('\n4. Continue in while loop:');
  print('Processing numbers, skipping multiples of 3:');
  int num = 0;
  while (num < 15) {
    num++;
    if (num % 3 == 0) {
      continue; // Skip multiples of 3
    }
    print('Processing: $num');
  }

  // 5. Nested loops with break and continue
  print('\n5. Nested loops with labeled break:');
  print('Multiplication table (breaking at 6x6):');

  outerLoop:
  for (int i = 1; i <= 10; i++) {
    for (int j = 1; j <= 10; j++) {
      if (i == 6 && j == 6) {
        print('Breaking at ${i}x$j');
        break outerLoop; // Break out of both loops
      }
      if (j > 5) continue; // Skip if j > 5
      print('${i}x$j = ${i * j}');
    }
    print('---');
  }

  // 6. Practical example: Processing a list
  print('\n6. Processing list with break/continue:');
  List<String> students = ['Alice', 'Bob', '', 'Charlie', 'STOP', 'David'];

  print('Processing student list:');
  for (String student in students) {
    if (student.isEmpty) {
      print('Skipping empty entry');
      continue;
    }
    if (student == 'STOP') {
      print('Stop command found, ending processing');
      break;
    }
    print('Processing student: $student');
  }

  // 7. Search example
  print('\n7. Search with break:');
  List<int> searchList = [3, 7, 1, 9, 4, 6, 2, 8];
  int target = 9;
  bool found = false;

  for (int i = 0; i < searchList.length; i++) {
    if (searchList[i] == target) {
      print('Found $target at index $i');
      found = true;
      break;
    }
  }

  if (!found) {
    print('$target not found in the list');
  }
}
