// Day 5: Collections - Sets Introduction
// Sets are collections of unique values in Dart

void main() {
  print('=== Sets Introduction ===\n');

  // 1. Creating Sets
  print('1. Creating Sets:');

  // Empty set
  Set<int> emptySet = {};
  Set<int> emptySet2 = Set<int>();

  // Set with initial values
  Set<String> fruits = {'apple', 'banana', 'orange'};

  // Set from list (duplicates removed automatically)
  Set<int> numbersFromList = {1, 2, 3, 2, 1, 4, 5, 4}.toSet();

  print('Fruits set: $fruits');
  print('Numbers from list: $numbersFromList\n');

  // 2. Set Properties
  print('2. Set Properties:');
  print('Length: ${fruits.length}');
  print('Is empty: ${fruits.isEmpty}');
  print('Is not empty: ${fruits.isNotEmpty}');
  print('First element: ${fruits.first}');
  print('Last element: ${fruits.last}\n');

  // 3. Checking for Elements
  print('3. Checking for Elements:');
  print('Contains "apple": ${fruits.contains('apple')}');
  print('Contains "grape": ${fruits.contains('grape')}\n');

  // 4. Unique Values Demonstration
  print('4. Unique Values Demonstration:');
  Set<int> uniqueNumbers = {};
  List<int> duplicateList = [1, 2, 3, 2, 1, 4, 5, 4, 3];

  print('Original list with duplicates: $duplicateList');

  for (int number in duplicateList) {
    uniqueNumbers.add(number);
  }

  print('Set with unique values: $uniqueNumbers');
  print('Duplicates automatically removed!\n');
}
