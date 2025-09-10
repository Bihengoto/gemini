// Day 4: Combining Loops with Collections - Advanced Examples

void main() {
  print('=== LOOPS & COLLECTIONS COMBINED ===\n');

  // 1. Processing multiple lists
  print('1. Processing multiple lists together:');
  List<String> students = ['Alice', 'Bob', 'Charlie', 'Diana'];
  List<int> grades = [85, 92, 78, 96];

  for (int i = 0; i < students.length && i < grades.length; i++) {
    String status = grades[i] >= 80 ? 'Pass' : 'Needs Improvement';
    print('${students[i]}: ${grades[i]} - $status');
  }

  // 2. Nested lists processing
  print('\n2. Processing nested data:');
  List<List<int>> matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ];

  print('Matrix:');
  for (int row = 0; row < matrix.length; row++) {
    String rowString = '';
    for (int col = 0; col < matrix[row].length; col++) {
      rowString += '${matrix[row][col]} ';
    }
    print('Row $row: $rowString');
  }

  // 3. Finding elements in lists
  print('\n3. Search operations:');
  List<String> inventory = [
    'apples',
    'bananas',
    'oranges',
    'grapes',
    'mangoes',
  ];
  List<String> shoppingList = ['bananas', 'bread', 'oranges', 'milk'];

  print('Checking shopping list against inventory:');
  for (String item in shoppingList) {
    bool inStock = false;
    for (String inventoryItem in inventory) {
      if (item == inventoryItem) {
        inStock = true;
        break;
      }
    }
    print('$item: ${inStock ? "In Stock" : "Out of Stock"}');
  }

  // 4. List manipulation with loops
  print('\n4. Building new lists with conditions:');
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<int> evenNumbers = [];
  List<int> oddNumbers = [];

  for (int number in numbers) {
    if (number % 2 == 0) {
      evenNumbers.add(number);
    } else {
      oddNumbers.add(number);
    }
  }

  print('Original: $numbers');
  print('Even numbers: $evenNumbers');
  print('Odd numbers: $oddNumbers');

  // 5. Counting and statistics
  print('\n5. Statistics from lists:');
  List<double> temperatures = [23.5, 25.0, 22.8, 26.2, 24.1, 23.9, 25.5];

  double sum = 0;
  double max = temperatures[0];
  double min = temperatures[0];

  for (double temp in temperatures) {
    sum += temp;
    if (temp > max) max = temp;
    if (temp < min) min = temp;
  }

  double average = sum / temperatures.length;
  print('Temperatures: $temperatures');
  print('Average: ${average.toStringAsFixed(2)}°C');
  print('Maximum: $max°C');
  print('Minimum: $min°C');

  // 6. List of Maps (complex data)
  print('\n6. Working with complex data structures:');
  List<Map<String, dynamic>> employees = [
    {'name': 'John', 'age': 30, 'department': 'IT'},
    {'name': 'Sarah', 'age': 25, 'department': 'HR'},
    {'name': 'Mike', 'age': 35, 'department': 'IT'},
    {'name': 'Lisa', 'age': 28, 'department': 'Finance'},
  ];

  print('IT Department employees:');
  for (Map<String, dynamic> employee in employees) {
    if (employee['department'] == 'IT') {
      print('${employee['name']} (Age: ${employee['age']})');
    }
  }

  // 7. Removing elements while iterating (careful approach)
  print('\n7. Safe removal during iteration:');
  List<int> numbersToFilter = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print('Before filtering: $numbersToFilter');

  // Remove even numbers (iterate backwards to avoid index issues)
  for (int i = numbersToFilter.length - 1; i >= 0; i--) {
    if (numbersToFilter[i] % 2 == 0) {
      numbersToFilter.removeAt(i);
    }
  }
  print('After removing even numbers: $numbersToFilter');

  // 8. Performance comparison
  print('\n8. Different ways to iterate:');
  List<int> largeList = List.generate(1000, (index) => index);

  // Method 1: for-in (recommended for simple iteration)
  print('Using for-in loop for simple processing...');
  int count1 = 0;
  for (int item in largeList) {
    if (item % 100 == 0) count1++;
  }
  print('Found $count1 items divisible by 100');

  // Method 2: traditional for with index (when you need index)
  print('Using indexed for loop...');
  int count2 = 0;
  for (int i = 0; i < largeList.length; i++) {
    if (largeList[i] % 100 == 0) count2++;
  }
  print('Found $count2 items divisible by 100');
}
