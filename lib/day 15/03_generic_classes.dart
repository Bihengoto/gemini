/*
 * Day 15: Generic Classes
 * 
 * This file demonstrates how to create and use generic classes:
 * - Basic generic class syntax
 * - Multiple type parameters
 * - Bounded generics
 * - Generic constructors and methods
 */

void main() {
  print('=== Generic Classes ===');
  
  demonstrateBasicGenericClass();
  demonstrateMultipleTypeParameters();
  demonstrateBoundedGenerics();
  demonstrateGenericMethods();
}

// Basic generic class
class Container<T> {
  T _value;
  
  Container(this._value);
  
  T get value => _value;
  set value(T newValue) => _value = newValue;
  
  void display() {
    print('Container holds: $_value (${_value.runtimeType})');
  }
  
  // Generic method within generic class
  bool isSameType<U>(U other) {
    return _value.runtimeType == other.runtimeType;
  }
}

// Generic class with multiple type parameters
class Pair<T, U> {
  T first;
  U second;
  
  Pair(this.first, this.second);
  
  void display() {
    print('Pair: ($first, $second)');
  }
  
  // Swap the values (returns new Pair with swapped types)
  Pair<U, T> swap() {
    return Pair<U, T>(second, first);
  }
  
  @override
  String toString() => '($first, $second)';
}

// Generic class with bounded type parameter
class NumberContainer<T extends num> {
  T _value;
  
  NumberContainer(this._value);
  
  T get value => _value;
  
  // Can use num methods because T extends num
  T add(T other) => (_value + other) as T;
  T multiply(T other) => (_value * other) as T;
  bool isPositive() => _value > 0;
  
  void display() {
    print('NumberContainer: $_value (${_value.runtimeType})');
  }
}

// Generic class implementing a generic interface
abstract class Comparable<T> {
  int compareTo(T other);
}

class Person implements Comparable<Person> {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  @override
  int compareTo(Person other) {
    return age.compareTo(other.age);
  }
  
  @override
  String toString() => '$name ($age)';
}

// Generic class with factory constructor
class Cache<T> {
  final Map<String, T> _cache = {};
  
  Cache._();
  
  static final Map<Type, Cache> _instances = {};
  
  factory Cache<T>() {
    return _instances.putIfAbsent(T, () => Cache<T>._()) as Cache<T>;
  }
  
  void put(String key, T value) {
    _cache[key] = value;
  }
  
  T? get(String key) {
    return _cache[key];
  }
  
  bool containsKey(String key) {
    return _cache.containsKey(key);
  }
  
  void clear() {
    _cache.clear();
  }
  
  int get size => _cache.length;
}

void demonstrateBasicGenericClass() {
  print('\n--- Basic Generic Class ---');
  
  // Create containers for different types
  var stringContainer = Container<String>('Hello, Dart!');
  var intContainer = Container<int>(42);
  var boolContainer = Container<bool>(true);
  
  stringContainer.display();
  intContainer.display();
  boolContainer.display();
  
  // Type-safe operations
  stringContainer.value = 'Updated string';
  intContainer.value = 100;
  
  print('After updates:');
  stringContainer.display();
  intContainer.display();
  
  // Test generic method
  print('String and int same type? ${stringContainer.isSameType(42)}');
  print('String and string same type? ${stringContainer.isSameType("test")}');
}

void demonstrateMultipleTypeParameters() {
  print('\n--- Multiple Type Parameters ---');
  
  var stringIntPair = Pair<String, int>('Age', 25);
  var intStringPair = Pair<int, String>(1, 'First');
  var doubleBoolPair = Pair<double, bool>(3.14, true);
  
  stringIntPair.display();
  intStringPair.display();
  doubleBoolPair.display();
  
  // Swap the pair
  var swapped = stringIntPair.swap();
  print('Original: $stringIntPair');
  print('Swapped: $swapped');
}

void demonstrateBoundedGenerics() {
  print('\n--- Bounded Generics ---');
  
  var intContainer = NumberContainer<int>(10);
  var doubleContainer = NumberContainer<double>(3.14);
  
  intContainer.display();
  doubleContainer.display();
  
  // Use methods available because T extends num
  print('10 + 5 = ${intContainer.add(5)}');
  print('3.14 * 2 = ${doubleContainer.multiply(2.0)}');
  print('Is 10 positive? ${intContainer.isPositive()}');
  print('Is 3.14 positive? ${doubleContainer.isPositive()}');
  
  // This would cause a compile error:
  // var stringContainer = NumberContainer<String>('hello'); // Error!
}

void demonstrateGenericMethods() {
  print('\n--- Generic Methods and Advanced Usage ---');
  
  // Using generic class with Comparable
  var people = [
    Person('Alice', 30),
    Person('Bob', 25),
    Person('Charlie', 35),
  ];
  
  people.sort((a, b) => a.compareTo(b));
  print('People sorted by age: $people');
  
  // Using singleton cache
  var stringCache = Cache<String>();
  var intCache = Cache<int>();
  
  stringCache.put('greeting', 'Hello');
  stringCache.put('farewell', 'Goodbye');
  
  intCache.put('answer', 42);
  intCache.put('year', 2024);
  
  print('String cache size: ${stringCache.size}');
  print('Int cache size: ${intCache.size}');
  print('Greeting: ${stringCache.get('greeting')}');
  print('Answer: ${intCache.get('answer')}');
  
  // Verify singleton behavior
  var anotherStringCache = Cache<String>();
  print('Same cache instance? ${identical(stringCache, anotherStringCache)}');
}