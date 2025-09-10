/*
Collection Extensions
=====================

Extensions for List, Set, Map, and Iterable to add useful functionality
for data manipulation, filtering, and utility operations.
*/

extension ListExtensions<T> on List<T> {
  // Get random element
  T get random {
    if (isEmpty) throw StateError('Cannot get random element from empty list');
    return this[(DateTime.now().millisecondsSinceEpoch % length)];
  }
  
  // Shuffle the list (returns new list)
  List<T> shuffled() {
    List<T> newList = List.from(this);
    newList.shuffle();
    return newList;
  }
  
  // Get element at index or return default
  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }
  
  // Split list into chunks
  List<List<T>> chunk(int size) {
    if (size <= 0) throw ArgumentError('Chunk size must be positive');
    
    List<List<T>> chunks = [];
    for (int i = 0; i < length; i += size) {
      chunks.add(sublist(i, (i + size > length) ? length : i + size));
    }
    return chunks;
  }
  
  // Remove duplicates while preserving order
  List<T> get unique {
    Set<T> seen = <T>{};
    return where((element) => seen.add(element)).toList();
  }
  
  // Get second element (if exists)
  T? get secondOrNull => length >= 2 ? this[1] : null;
  
  // Get second to last element
  T? get secondToLastOrNull => length >= 2 ? this[length - 2] : null;
  
  // Check if list has duplicates
  bool get hasDuplicates => length != toSet().length;
  
  // Intersperse elements with separator
  List<T> intersperse(T separator) {
    if (length <= 1) return List.from(this);
    
    List<T> result = [];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) result.add(separator);
    }
    return result;
  }
}

extension IterableExtensions<T> on Iterable<T> {
  // Find element by condition or return null
  T? firstWhereOrNull(bool Function(T) test) {
    for (T element in this) {
      if (test(element)) return element;
    }
    return null;
  }
  
  // Count elements matching condition
  int countWhere(bool Function(T) test) {
    return where(test).length;
  }
  
  // Check if all elements are unique
  bool get allUnique => length == toSet().length;
  
  // Group elements by key
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    Map<K, List<T>> groups = {};
    for (T element in this) {
      K key = keySelector(element);
      groups.putIfAbsent(key, () => []).add(element);
    }
    return groups;
  }
  
  // Get most frequent element
  T? get mostFrequent {
    if (isEmpty) return null;
    
    Map<T, int> frequency = {};
    for (T element in this) {
      frequency[element] = (frequency[element] ?? 0) + 1;
    }
    
    return frequency.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
}

extension MapExtensions<K, V> on Map<K, V> {
  // Get value or return default
  V getOrDefault(K key, V defaultValue) {
    return this[key] ?? defaultValue;
  }
  
  // Invert map (values become keys, keys become values)
  Map<V, K> get inverted {
    return Map.fromEntries(entries.map((entry) => MapEntry(entry.value, entry.key)));
  }
  
  // Filter map by condition
  Map<K, V> whereEntry(bool Function(K key, V value) test) {
    Map<K, V> result = {};
    for (MapEntry<K, V> entry in entries) {
      if (test(entry.key, entry.value)) {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }
  
  // Transform values while keeping keys
  Map<K, R> mapValues<R>(R Function(V value) transform) {
    return Map.fromEntries(
      entries.map((entry) => MapEntry(entry.key, transform(entry.value)))
    );
  }
  
  // Transform keys while keeping values
  Map<R, V> mapKeys<R>(R Function(K key) transform) {
    return Map.fromEntries(
      entries.map((entry) => MapEntry(transform(entry.key), entry.value))
    );
  }
}

// Specialized extensions for numeric lists
extension NumericListExtensions on List<num> {
  // Calculate sum
  num get sum => isEmpty ? 0 : reduce((a, b) => a + b);
  
  // Calculate average
  double get average => isEmpty ? 0 : sum / length;
  
  // Find minimum value
  num get min => isEmpty ? 0 : reduce((a, b) => a < b ? a : b);
  
  // Find maximum value
  num get max => isEmpty ? 0 : reduce((a, b) => a > b ? a : b);
  
  // Calculate median
  double get median {
    if (isEmpty) return 0;
    
    List<num> sorted = List.from(this)..sort();
    int middle = sorted.length ~/ 2;
    
    if (sorted.length.isOdd) {
      return sorted[middle].toDouble();
    } else {
      return (sorted[middle - 1] + sorted[middle]) / 2;
    }
  }
  
  // Calculate standard deviation
  double get standardDeviation {
    if (isEmpty) return 0;
    
    double avg = average;
    double sumSquaredDiffs = map((x) => (x - avg) * (x - avg)).sum.toDouble();
    return sqrt(sumSquaredDiffs / length);
  }
}

// Import for sqrt function
import 'dart:math';

void demonstrateCollectionExtensions() {
  print('=== Collection Extensions Demo ===\n');
  
  // List extensions
  List<String> fruits = ['apple', 'banana', 'cherry', 'apple', 'date'];
  print('Fruits: $fruits');
  print('Random fruit: ${fruits.random}');
  print('Unique fruits: ${fruits.unique}');
  print('Has duplicates: ${fruits.hasDuplicates}');
  print('Second fruit: ${fruits.secondOrNull}');
  print('Chunks of 2: ${fruits.chunk(2)}');
  print('With separators: ${fruits.intersperse('|')}\n');
  
  // Iterable extensions
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print('Numbers: $numbers');
  print('First even: ${numbers.firstWhereOrNull((n) => n.isEven)}');
  print('Count of evens: ${numbers.countWhere((n) => n.isEven)}');
  print('Most frequent: ${[1, 2, 2, 3, 2, 4].mostFrequent}');
  
  // Group by example
  List<String> words = ['cat', 'dog', 'car', 'duck', 'cow'];
  Map<String, List<String>> grouped = words.groupBy((word) => word[0]);
  print('Grouped by first letter: $grouped\n');
  
  // Map extensions
  Map<String, int> scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};
  print('Scores: $scores');
  print('Bob or default: ${scores.getOrDefault('Bob', 0)}');
  print('David or default: ${scores.getOrDefault('David', 0)}');
  print('Inverted: ${scores.inverted}');
  print('High scores (>90): ${scores.whereEntry((k, v) => v > 90)}');
  print('Doubled scores: ${scores.mapValues((score) => score * 2)}\n');
  
  // Numeric list extensions
  List<num> values = [10, 20, 30, 40, 50];
  print('Values: $values');
  print('Sum: ${values.sum}');
  print('Average: ${values.average}');
  print('Min: ${values.min}');
  print('Max: ${values.max}');
  print('Median: ${values.median}');
  print('Standard deviation: ${values.standardDeviation.roundToPlaces(2)}');
}

void main() {
  demonstrateCollectionExtensions();
}