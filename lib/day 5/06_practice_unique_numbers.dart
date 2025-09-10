// Day 5: Practice - Unique Numbers with Sets
// Working with Sets to handle unique numbers

import 'dart:math';

void main() {
  print('=== Unique Numbers Practice ===\n');

  // 1. Basic Set of Unique Numbers
  print('1. Basic Set of Unique Numbers:');

  Set<int> uniqueNumbers = {1, 2, 3, 4, 5, 3, 2, 6, 7, 1};
  print('Set with duplicates removed: $uniqueNumbers');
  print('Count of unique numbers: ${uniqueNumbers.length}\n');

  // 2. Generating Random Unique Numbers
  print('2. Generating Random Unique Numbers:');

  Set<int> randomUniqueNumbers = {};
  Random random = Random();

  // Generate 10 unique random numbers between 1-20
  while (randomUniqueNumbers.length < 10) {
    int randomNumber = random.nextInt(20) + 1;
    randomUniqueNumbers.add(randomNumber);
  }

  print('10 unique random numbers (1-20): $randomUniqueNumbers');

  // 3. Processing Lists to Remove Duplicates
  print('\n3. Processing Lists to Remove Duplicates:');

  List<int> numbersWithDuplicates = [
    1,
    5,
    3,
    8,
    3,
    7,
    1,
    9,
    5,
    2,
    8,
    4,
    6,
    2,
    9,
    4,
  ];

  print('Original list: $numbersWithDuplicates');
  print('Length with duplicates: ${numbersWithDuplicates.length}');

  Set<int> uniqueFromList = numbersWithDuplicates.toSet();
  print('Unique numbers: $uniqueFromList');
  print('Length without duplicates: ${uniqueFromList.length}');

  // 4. Set Operations with Number Sets
  print('\n4. Set Operations with Number Sets:');

  Set<int> evenNumbers = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20};
  Set<int> multiplesOfThree = {3, 6, 9, 12, 15, 18, 21, 24, 27, 30};

  print('Even numbers: $evenNumbers');
  print('Multiples of 3: $multiplesOfThree');

  // Numbers that are both even and multiples of 3
  Set<int> evenAndMultiplesOfThree = evenNumbers.intersection(multiplesOfThree);
  print('Even AND multiples of 3: $evenAndMultiplesOfThree');

  // All even numbers or multiples of 3
  Set<int> evenOrMultiplesOfThree = evenNumbers.union(multiplesOfThree);
  print('Even OR multiples of 3: $evenOrMultiplesOfThree');

  // Even numbers that are NOT multiples of 3
  Set<int> evenNotMultiplesOfThree = evenNumbers.difference(multiplesOfThree);
  print('Even but NOT multiples of 3: $evenNotMultiplesOfThree');

  // 5. Practical Example: Lottery Number Generator
  print('\n5. Lottery Number Generator:');

  Set<int> lotteryNumbers = generateLotteryNumbers(6, 1, 49);
  print('Your lottery numbers: ${lotteryNumbers.toList()..sort()}');

  // 6. Finding Unique Elements in Multiple Lists
  print('\n6. Finding Unique Elements Across Lists:');

  List<int> list1 = [1, 2, 3, 4, 5];
  List<int> list2 = [4, 5, 6, 7, 8];
  List<int> list3 = [7, 8, 9, 10, 11];

  Set<int> allNumbers = {};
  allNumbers.addAll(list1);
  allNumbers.addAll(list2);
  allNumbers.addAll(list3);

  print('List 1: $list1');
  print('List 2: $list2');
  print('List 3: $list3');
  print('All unique numbers: $allNumbers');

  // Numbers that appear in all three lists
  Set<int> commonInAll = list1
      .toSet()
      .intersection(list2.toSet())
      .intersection(list3.toSet());
  print('Common in all lists: $commonInAll');
}

// Helper function to generate lottery numbers
Set<int> generateLotteryNumbers(int count, int min, int max) {
  Set<int> numbers = {};
  Random random = Random();

  while (numbers.length < count) {
    int number = random.nextInt(max - min + 1) + min;
    numbers.add(number);
  }

  return numbers;
}
