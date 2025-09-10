// Day 5: Collections - Sets Operations
// Common operations you can perform on Sets

void main() {
  print('=== Sets Operations ===\n');

  // Initialize sets for demonstrations
  Set<int> setA = {1, 2, 3, 4, 5};
  Set<int> setB = {4, 5, 6, 7, 8};

  print('Set A: $setA');
  print('Set B: $setB\n');

  // 1. Adding Elements
  print('1. Adding Elements:');
  Set<String> colors = {'red', 'blue'};
  print('Initial colors: $colors');

  colors.add('green');
  colors.add('red'); // Won't add duplicate
  colors.addAll(['yellow', 'purple', 'blue']); // Won't add duplicates

  print('After adding: $colors\n');

  // 2. Removing Elements
  print('2. Removing Elements:');
  bool removed = colors.remove('yellow');
  print('Removed yellow: $removed');
  print('After removing yellow: $colors');

  colors.removeWhere((color) => color.startsWith('p'));
  print('After removing colors starting with "p": $colors\n');

  // 3. Set Operations
  print('3. Set Operations:');

  // Union (all elements from both sets)
  Set<int> union = setA.union(setB);
  print('Union (A ∪ B): $union');

  // Intersection (common elements)
  Set<int> intersection = setA.intersection(setB);
  print('Intersection (A ∩ B): $intersection');

  // Difference (elements in A but not in B)
  Set<int> difference = setA.difference(setB);
  print('Difference (A - B): $difference');

  // Symmetric difference (elements in either A or B, but not both)
  Set<int> symmetricDifference = setA
      .union(setB)
      .difference(setA.intersection(setB));
  print('Symmetric Difference: $symmetricDifference\n');

  // 4. Iterating through Sets
  print('4. Iterating through Sets:');

  // Method 1: forEach
  print('Using forEach:');
  colors.forEach((color) {
    print('  Color: $color');
  });

  // Method 2: for-in
  print('\nUsing for-in:');
  for (String color in colors) {
    print('  Color: $color');
  }

  // 5. Converting Sets
  print('\n5. Converting Sets:');
  List<String> colorsList = colors.toList();
  print('Set to List: $colorsList');

  Set<String> backToSet = colorsList.toSet();
  print('List back to Set: $backToSet');
}
