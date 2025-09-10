// Day 5: Collections - Maps Operations
// Common operations you can perform on Maps

void main() {
  print('=== Maps Operations ===\n');

  // Initialize a map for demonstrations
  Map<String, int> scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};

  print('Initial scores: $scores\n');

  // 1. Adding Elements
  print('1. Adding Elements:');
  scores['David'] = 89;
  scores.putIfAbsent('Eve', () => 91);
  scores.putIfAbsent('Alice', () => 100); // Won't overwrite existing

  print('After adding: $scores\n');

  // 2. Updating Elements
  print('2. Updating Elements:');
  scores['Bob'] = 90; // Direct assignment
  scores.update('Charlie', (value) => value + 3);
  scores.update('Frank', (value) => value + 5, ifAbsent: () => 85);

  print('After updating: $scores\n');

  // 3. Removing Elements
  print('3. Removing Elements:');
  int? removedScore = scores.remove('Eve');
  print('Removed Eve with score: $removedScore');

  scores.removeWhere((key, value) => value < 90);
  print('After removing scores < 90: $scores\n');

  // 4. Checking for Keys/Values
  print('4. Checking for Keys/Values:');
  print('Contains key "Alice": ${scores.containsKey('Alice')}');
  print('Contains value 95: ${scores.containsValue(95)}');

  // 5. Iterating through Maps
  print('\n5. Iterating through Maps:');

  // Method 1: forEach
  print('Using forEach:');
  scores.forEach((key, value) {
    print('  $key: $value');
  });

  // Method 2: for-in with entries
  print('\nUsing for-in with entries:');
  for (MapEntry<String, int> entry in scores.entries) {
    print('  ${entry.key}: ${entry.value}');
  }

  // Method 3: for-in with keys
  print('\nUsing for-in with keys:');
  for (String key in scores.keys) {
    print('  $key: ${scores[key]}');
  }
}
