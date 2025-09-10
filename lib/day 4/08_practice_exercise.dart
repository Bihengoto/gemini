// Day 4: Practice Exercise - Names List with Different Loop Types

void main() {
  print('=== PRACTICE EXERCISE: NAMES LIST ===\n');

  // Create a list of names
  List<String> names = [
    'Alice',
    'Bob',
    'Charlie',
    'Diana',
    'Edward',
    'Fiona',
    'George',
    'Hannah',
  ];

  print('Original list of names: $names\n');

  // Method 1: Using for-in loop (most common for lists)
  print('1. Using for-in loop:');
  for (String name in names) {
    print('Hello, $name!');
  }

  // Method 2: Using traditional for loop with index
  print('\n2. Using traditional for loop with index:');
  for (int i = 0; i < names.length; i++) {
    print('${i + 1}. ${names[i]}');
  }

  // Method 3: Using while loop
  print('\n3. Using while loop:');
  int index = 0;
  while (index < names.length) {
    print('Name at position $index: ${names[index]}');
    index++;
  }

  // Method 4: Using do-while loop
  print('\n4. Using do-while loop:');
  int counter = 0;
  if (names.isNotEmpty) {
    do {
      print('Processing: ${names[counter]}');
      counter++;
    } while (counter < names.length);
  }

  // Bonus: Advanced operations with loops
  print('\n=== BONUS EXERCISES ===');

  // Exercise 1: Find names starting with specific letter
  print('\n5. Names starting with "A" or "B":');
  for (String name in names) {
    if (name.startsWith('A') || name.startsWith('B')) {
      print('Found: $name');
    }
  }

  // Exercise 2: Count names with specific length
  print('\n6. Counting names by length:');
  Map<int, int> lengthCount = {};
  for (String name in names) {
    int length = name.length;
    lengthCount[length] = (lengthCount[length] ?? 0) + 1;
  }
  lengthCount.forEach((length, count) {
    print('Names with $length letters: $count');
  });

  // Exercise 3: Reverse print with break condition
  print('\n7. Reverse printing (stop at "Edward"):');
  for (int i = names.length - 1; i >= 0; i--) {
    if (names[i] == 'Edward') {
      print('Stopping at: ${names[i]}');
      break;
    }
    print('Reverse order: ${names[i]}');
  }

  // Exercise 4: Skip names with even index
  print('\n8. Names at odd positions only:');
  for (int i = 0; i < names.length; i++) {
    if (i % 2 == 0) {
      continue; // Skip even indices (0, 2, 4, ...)
    }
    print('Odd position $i: ${names[i]}');
  }

  // Exercise 5: Interactive-style processing
  print('\n9. Processing with conditions:');
  for (String name in names) {
    if (name.length < 4) {
      print('Short name: $name');
      continue;
    }
    if (name.length > 6) {
      print('Long name: $name');
      continue;
    }
    print('Medium name: $name');
  }

  // Exercise 6: Creating new lists based on conditions
  print('\n10. Categorizing names:');
  List<String> shortNames = [];
  List<String> longNames = [];

  for (String name in names) {
    if (name.length <= 4) {
      shortNames.add(name);
    } else {
      longNames.add(name);
    }
  }

  print('Short names (≤4 letters): $shortNames');
  print('Long names (>4 letters): $longNames');
}
