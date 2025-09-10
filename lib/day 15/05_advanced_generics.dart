/*
 * Day 15: Advanced Generics Concepts
 * 
 * This file covers advanced topics in generics:
 * - Bounded type parameters
 * - Generic constraints
 * - Covariance and contravariance
 * - Generic type aliases
 * - Generic mixins
 * - Wildcard types and type bounds
 */

void main() {
  print('=== Advanced Generics ===');
  
  demonstrateBoundedTypes();
  demonstrateGenericConstraints();
  demonstrateVariance();
  demonstrateTypeAliases();
  demonstrateGenericMixins();
}

// Bounded type parameters - T must extend num
class Calculator<T extends num> {
  T add(T a, T b) => (a + b) as T;
  T subtract(T a, T b) => (a - b) as T;
  T multiply(T a, T b) => (a * b) as T;
  double divide(T a, T b) => a / b;
  
  bool isPositive(T value) => value > 0;
  bool isNegative(T value) => value < 0;
  T abs(T value) => value < 0 ? (-value) as T : value;
}

// Multiple bounds using 'with' for mixins
mixin Printable {
  void printInfo();
}

class Document with Printable {
  String content;
  Document(this.content);
  
  @override
  void printInfo() => print('Document: $content');
}

class Report with Printable {
  String title;
  List<String> data;
  Report(this.title, this.data);
  
  @override
  void printInfo() => print('Report: $title with ${data.length} items');
}

// Generic class with multiple constraints
class Processor<T extends Object with Printable> {
  void process(T item) {
    print('Processing item...');
    item.printInfo();
  }
  
  void processAll(List<T> items) {
    for (var item in items) {
      process(item);
    }
  }
}

// Generic type aliases
typedef StringMap<T> = Map<String, T>;
typedef IntList = List<int>;
typedef Predicate<T> = bool Function(T);
typedef Transformer<T, R> = R Function(T);
typedef Comparator<T> = int Function(T, T);

// Generic function types
typedef Callback<T> = void Function(T);
typedef AsyncCallback<T> = Future<void> Function(T);

// Generic mixin
mixin Cacheable<T> {
  final Map<String, T> _cache = {};
  
  void cacheValue(String key, T value) {
    _cache[key] = value;
  }
  
  T? getCachedValue(String key) {
    return _cache[key];
  }
  
  bool hasCachedValue(String key) {
    return _cache.containsKey(key);
  }
  
  void clearCache() {
    _cache.clear();
  }
  
  int get cacheSize => _cache.length;
}

// Class using generic mixin
class DataService<T> with Cacheable<T> {
  final String serviceName;
  
  DataService(this.serviceName);
  
  Future<T?> fetchData(String id) async {
    // Check cache first
    if (hasCachedValue(id)) {
      print('Returning cached data for $id');
      return getCachedValue(id);
    }
    
    // Simulate network call
    print('Fetching data for $id from $serviceName...');
    await Future.delayed(Duration(milliseconds: 100));
    
    // This would normally fetch real data
    return null;
  }
  
  void storeData(String id, T data) {
    cacheValue(id, data);
    print('Stored data for $id in cache');
  }
}

// Variance examples
class Animal {
  String name;
  Animal(this.name);
  void makeSound() => print('$name makes a sound');
}

class Dog extends Animal {
  Dog(String name) : super(name);
  @override
  void makeSound() => print('$name barks');
  void fetch() => print('$name fetches');
}

class Cat extends Animal {
  Cat(String name) : super(name);
  @override
  void makeSound() => print('$name meows');
  void purr() => print('$name purrs');
}

// Generic class demonstrating variance
class AnimalShelter<T extends Animal> {
  final List<T> _animals = [];
  
  void addAnimal(T animal) {
    _animals.add(animal);
  }
  
  T? getAnimal(int index) {
    return index < _animals.length ? _animals[index] : null;
  }
  
  List<T> getAllAnimals() => List.unmodifiable(_animals);
  
  int get count => _animals.length;
  
  void makeAllSounds() {
    for (var animal in _animals) {
      animal.makeSound();
    }
  }
}

// Generic utility functions
class GenericUtils {
  // Generic swap function
  static void swap<T>(List<T> list, int i, int j) {
    if (i >= 0 && i < list.length && j >= 0 && j < list.length) {
      T temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }
  
  // Generic find function
  static T? find<T>(List<T> list, Predicate<T> predicate) {
    for (var item in list) {
      if (predicate(item)) return item;
    }
    return null;
  }
  
  // Generic filter function
  static List<T> filter<T>(List<T> list, Predicate<T> predicate) {
    return list.where(predicate).toList();
  }
  
  // Generic map function
  static List<R> map<T, R>(List<T> list, Transformer<T, R> transformer) {
    return list.map(transformer).toList();
  }
  
  // Generic reduce function
  static T reduce<T>(List<T> list, T Function(T, T) reducer) {
    if (list.isEmpty) throw ArgumentError('List cannot be empty');
    T result = list.first;
    for (int i = 1; i < list.length; i++) {
      result = reducer(result, list[i]);
    }
    return result;
  }
}

void demonstrateBoundedTypes() {
  print('\n--- Bounded Type Parameters ---');
  
  var intCalculator = Calculator<int>();
  var doubleCalculator = Calculator<double>();
  
  print('Int calculator: 5 + 3 = ${intCalculator.add(5, 3)}');
  print('Double calculator: 5.5 * 2.0 = ${doubleCalculator.multiply(5.5, 2.0)}');
  print('Is -5 negative? ${intCalculator.isNegative(-5)}');
  print('Absolute value of -3.14: ${doubleCalculator.abs(-3.14)}');
  
  // This would cause a compile error:
  // var stringCalculator = Calculator<String>(); // Error!
}

void demonstrateGenericConstraints() {
  print('\n--- Generic Constraints ---');
  
  var processor = Processor<Document>();
  var documents = [
    Document('User Manual'),
    Document('API Documentation'),
  ];
  
  var reportProcessor = Processor<Report>();
  var reports = [
    Report('Sales Report', ['Q1', 'Q2', 'Q3', 'Q4']),
    Report('Performance Report', ['CPU', 'Memory', 'Disk']),
  ];
  
  print('Processing documents:');
  processor.processAll(documents);
  
  print('\nProcessing reports:');
  reportProcessor.processAll(reports);
}

void demonstrateVariance() {
  print('\n--- Variance Examples ---');
  
  var dogShelter = AnimalShelter<Dog>();
  var catShelter = AnimalShelter<Cat>();
  
  dogShelter.addAnimal(Dog('Buddy'));
  dogShelter.addAnimal(Dog('Max'));
  
  catShelter.addAnimal(Cat('Whiskers'));
  catShelter.addAnimal(Cat('Mittens'));
  
  print('Dog shelter has ${dogShelter.count} dogs');
  print('Cat shelter has ${catShelter.count} cats');
  
  print('\nDog sounds:');
  dogShelter.makeAllSounds();
  
  print('\nCat sounds:');
  catShelter.makeAllSounds();
  
  // Covariance example - List<Dog> can be treated as List<Animal> in some contexts
  List<Dog> dogs = [Dog('Rex'), Dog('Spot')];
  List<Animal> animals = dogs; // This works due to covariance
  
  print('\nAnimals list (originally dogs):');
  for (var animal in animals) {
    animal.makeSound();
  }
}

void demonstrateTypeAliases() {
  print('\n--- Type Aliases ---');
  
  // Using type aliases
  StringMap<int> scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};
  IntList numbers = [1, 2, 3, 4, 5];
  
  Predicate<int> isEven = (n) => n % 2 == 0;
  Transformer<int, String> intToString = (n) => 'Number: $n';
  Comparator<String> stringComparator = (a, b) => a.compareTo(b);
  
  print('Scores: $scores');
  print('Numbers: $numbers');
  print('Is 4 even? ${isEven(4)}');
  print('Transform 42: ${intToString(42)}');
  print('Compare "apple" and "banana": ${stringComparator("apple", "banana")}');
  
  // Using generic utility functions
  var evenNumbers = GenericUtils.filter(numbers, isEven);
  var numberStrings = GenericUtils.map(numbers, intToString);
  var sum = GenericUtils.reduce(numbers, (a, b) => a + b);
  
  print('Even numbers: $evenNumbers');
  print('Number strings: $numberStrings');
  print('Sum: $sum');
}

void demonstrateGenericMixins() {
  print('\n--- Generic Mixins ---');
  
  var userService = DataService<Map<String, dynamic>>('UserService');
  var productService = DataService<String>('ProductService');
  
  // Store some data
  userService.storeData('user1', {'name': 'Alice', 'age': 30});
  userService.storeData('user2', {'name': 'Bob', 'age': 25});
  
  productService.storeData('prod1', 'Laptop');
  productService.storeData('prod2', 'Mouse');
  
  print('User service cache size: ${userService.cacheSize}');
  print('Product service cache size: ${productService.cacheSize}');
  
  // Fetch data (will use cache)
  print('\nFetching data:');
  userService.fetchData('user1');
  productService.fetchData('prod1');
  
  // Clear caches
  userService.clearCache();
  print('User service cache size after clear: ${userService.cacheSize}');
}