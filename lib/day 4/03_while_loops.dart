// Day 4: While Loops in Dart

void main() {
  print('=== WHILE LOOPS EXAMPLES ===\n');

  // 1. Basic while loop
  print('1. Basic while loop (counting to 5):');
  int counter = 1;
  while (counter <= 5) {
    print('Count: $counter');
    counter++;
  }

  // 2. While loop with user input simulation
  print('\n2. While loop with condition:');
  int number = 16;
  while (number > 1) {
    print('Number: $number');
    number = number ~/ 2; // Integer division
  }
  print('Final number: $number');

  // 3. While loop with break
  print('\n3. While loop with break:');
  int i = 1;
  while (true) {
    // Infinite loop
    print('Processing: $i');
    if (i == 4) {
      print('Breaking out of loop');
      break;
    }
    i++;
  }

  // 4. While loop with continue
  print('\n4. While loop with continue (skip multiples of 3):');
  int j = 0;
  while (j < 10) {
    j++;
    if (j % 3 == 0) {
      continue; // Skip multiples of 3
    }
    print('Not divisible by 3: $j');
  }

  // 5. While loop with list processing
  print('\n5. While loop processing a list:');
  List<String> colors = ['Red', 'Green', 'Blue', 'Yellow'];
  int index = 0;
  while (index < colors.length) {
    print('Color ${index + 1}: ${colors[index]}');
    index++;
  }
}
