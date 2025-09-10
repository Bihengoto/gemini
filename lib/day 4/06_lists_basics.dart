// Day 4: Lists (Collections) in Dart

void main() {
  print('=== LISTS BASICS ===\n');

  // 1. Creating Lists
  print('1. Creating Lists:');

  // Empty list
  List<String> emptyList = [];
  List<int> numbers = <int>[];

  // List with initial values
  List<String> fruits = ['Apple', 'Banana', 'Orange'];
  List<int> scores = [85, 92, 78, 96, 88];

  print('Fruits: $fruits');
  print('Scores: $scores');

  // 2. Accessing Elements
  print('\n2. Accessing Elements:');
  print('First fruit: ${fruits[0]}');
  print('Last fruit: ${fruits[fruits.length - 1]}');
  print('Second score: ${scores[1]}');

  // Safe access with length check
  if (fruits.isNotEmpty) {
    print('List is not empty, first item: ${fruits.first}');
    print('Last item: ${fruits.last}');
  }

  // 3. Adding Elements
  print('\n3. Adding Elements:');
  fruits.add('Mango');
  print('After adding Mango: $fruits');

  fruits.addAll(['Grapes', 'Pineapple']);
  print('After adding multiple fruits: $fruits');

  fruits.insert(1, 'Strawberry');
  print('After inserting Strawberry at index 1: $fruits');

  // 4. Removing Elements
  print('\n4. Removing Elements:');
  fruits.remove('Banana');
  print('After removing Banana: $fruits');

  String removedFruit = fruits.removeAt(0);
  print('Removed fruit at index 0: $removedFruit');
  print('List after removal: $fruits');

  fruits.removeLast();
  print('After removing last element: $fruits');

  // 5. List Properties
  print('\n5. List Properties:');
  print('Length of fruits list: ${fruits.length}');
  print('Is fruits list empty? ${fruits.isEmpty}');
  print('Is fruits list not empty? ${fruits.isNotEmpty}');

  // 6. Checking if element exists
  print('\n6. Checking Elements:');
  print('Contains Mango? ${fruits.contains('Mango')}');
  print('Index of Orange: ${fruits.indexOf('Orange')}');

  // 7. List Operations
  print('\n7. List Operations:');
  List<int> moreNumbers = [1, 2, 3, 4, 5];
  print('Original numbers: $moreNumbers');

  // Reverse
  List<int> reversed = moreNumbers.reversed.toList();
  print('Reversed: $reversed');

  // Sort
  List<String> unsortedFruits = ['Zebra', 'Apple', 'Mango', 'Banana'];
  unsortedFruits.sort();
  print('Sorted fruits: $unsortedFruits');

  // Clear all elements
  List<String> tempList = ['a', 'b', 'c'];
  print('Before clear: $tempList');
  tempList.clear();
  print('After clear: $tempList');
}
