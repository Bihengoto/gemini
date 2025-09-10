# Day 15: Generics in Dart - Complete Notes

## Overview
Generics allow you to write flexible, reusable code that can work with different types while maintaining type safety at compile time.

## Key Concepts

### 1. Basic Generic Syntax
```dart
// Generic class
class Container<T> {
  T value;
  Container(this.value);
}

// Generic method
T getFirst<T>(List<T> list) => list.first;

// Generic function
void swap<T>(List<T> list, int i, int j) {
  T temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}
```

### 2. Generic Collections

#### Lists
```dart
List<String> names = ['Alice', 'Bob', 'Charlie'];
List<int> numbers = [1, 2, 3, 4, 5];
var colors = <String>['red', 'green', 'blue']; // Type inference
```

#### Maps
```dart
Map<String, int> scores = {'Alice': 95, 'Bob': 87};
Map<int, String> idToName = {1: 'John', 2: 'Jane'};
```

#### Sets
```dart
Set<String> uniqueNames = {'Alice', 'Bob', 'Charlie'};
Set<int> primeNumbers = {2, 3, 5, 7, 11};
```

### 3. Bounded Type Parameters
Restrict generic types to specific type hierarchies:

```dart
// T must extend num
class Calculator<T extends num> {
  T add(T a, T b) => (a + b) as T;
}

// T must implement Comparable
class SortedList<T extends Comparable<T>> {
  List<T> _items = [];
  
  void add(T item) {
    _items.add(item);
    _items.sort();
  }
}
```

### 4. Multiple Type Parameters
```dart
class Pair<T, U> {
  T first;
  U second;
  
  Pair(this.first, this.second);
  
  Pair<U, T> swap() => Pair<U, T>(second, first);
}
```

### 5. Generic Constraints with Mixins
```dart
mixin Printable {
  void printInfo();
}

class Processor<T extends Object with Printable> {
  void process(T item) {
    item.printInfo();
  }
}
```

### 6. Type Aliases
Simplify complex generic types:

```dart
typedef StringMap<T> = Map<String, T>;
typedef Predicate<T> = bool Function(T);
typedef Transformer<T, R> = R Function(T);

// Usage
StringMap<int> scores = {'Alice': 95, 'Bob': 87};
Predicate<int> isEven = (n) => n % 2 == 0;
```

### 7. Generic Mixins
```dart
mixin Cacheable<T> {
  final Map<String, T> _cache = {};
  
  void cacheValue(String key, T value) => _cache[key] = value;
  T? getCachedValue(String key) => _cache[key];
}

class DataService<T> with Cacheable<T> {
  // Can use caching functionality
}
```

## Benefits of Generics

### 1. Type Safety
- Catch type errors at compile time
- Prevent ClassCastException at runtime
- Better IDE support with autocomplete

### 2. Code Reusability
- Write once, use with multiple types
- Reduce code duplication
- Maintain single source of truth

### 3. Performance
- Avoid boxing/unboxing overhead
- No runtime type casting needed
- Better optimization opportunities

### 4. Better API Design
- Clear contracts about expected types
- Self-documenting code
- Improved maintainability

## Best Practices

### 1. Use Meaningful Type Parameter Names
```dart
// Good
class Repository<TEntity, TKey> {
  TEntity? findById(TKey id) { ... }
}

// Acceptable for simple cases
class Container<T> {
  T value;
}
```

### 2. Prefer Bounded Types When Appropriate
```dart
// Instead of
class MathUtils<T> {
  T add(T a, T b) => (a + b) as T; // Unsafe cast
}

// Use
class MathUtils<T extends num> {
  T add(T a, T b) => (a + b) as T; // Safe because T extends num
}
```

### 3. Use Type Aliases for Complex Types
```dart
// Instead of
Map<String, List<Map<String, dynamic>>> complexData;

// Use
typedef UserData = Map<String, dynamic>;
typedef UserGroups = Map<String, List<UserData>>;
UserGroups complexData;
```

### 4. Leverage Type Inference
```dart
// Dart can infer types
var names = <String>['Alice', 'Bob']; // List<String>
var scores = {'Alice': 95, 'Bob': 87}; // Map<String, int>
```

## Common Patterns

### 1. Generic Repository Pattern
```dart
abstract class Repository<T, ID> {
  Future<T?> findById(ID id);
  Future<List<T>> findAll();
  Future<T> save(T entity);
  Future<void> delete(ID id);
}
```

### 2. Generic Builder Pattern
```dart
class QueryBuilder<T> {
  String _table = '';
  List<String> _conditions = [];
  
  QueryBuilder<T> from(String table) {
    _table = table;
    return this;
  }
  
  QueryBuilder<T> where(String condition) {
    _conditions.add(condition);
    return this;
  }
  
  String build() {
    return 'SELECT * FROM $_table WHERE ${_conditions.join(' AND ')}';
  }
}
```

### 3. Generic Factory Pattern
```dart
abstract class Factory<T> {
  T create();
}

class UserFactory implements Factory<User> {
  @override
  User create() => User();
}
```

## Advanced Topics

### 1. Variance
- **Covariance**: `List<Dog>` can be treated as `List<Animal>`
- **Contravariance**: Function parameters are contravariant
- **Invariance**: Generic types are invariant by default

### 2. Type Erasure
- Generic type information is available at compile time
- Some type information is erased at runtime
- Use `runtimeType` to check actual types

### 3. Generic Type Testing
```dart
bool isListOfStrings(dynamic value) {
  return value is List<String>;
}

void processIfList<T>(dynamic value) {
  if (value is List<T>) {
    // Process as List<T>
  }
}
```

## Common Pitfalls

### 1. Raw Types
```dart
// Avoid
List rawList = []; // No type safety

// Prefer
List<dynamic> dynamicList = []; // Explicit about accepting any type
List<String> stringList = []; // Type-safe
```

### 2. Unnecessary Casting
```dart
// Avoid
T getValue<T>() {
  return someValue as T; // Unsafe
}

// Prefer bounded types or proper type checking
T getValue<T extends SomeBaseType>() {
  return someValue; // Safe if someValue is of correct type
}
```

### 3. Overusing Generics
```dart
// Unnecessary
class StringContainer<T extends String> {
  T value;
}

// Better
class StringContainer {
  String value;
}
```

## Summary

Generics in Dart provide:
- **Type Safety**: Compile-time type checking
- **Reusability**: Same code works with different types
- **Performance**: No runtime type casting overhead
- **Clarity**: Self-documenting code with clear type contracts

Key takeaways:
1. Use generics for collections and reusable components
2. Prefer bounded types when you need specific capabilities
3. Leverage type inference where possible
4. Use type aliases for complex generic types
5. Follow naming conventions for type parameters
6. Don't overuse generics - keep it simple when possible

The generic Box class practice demonstrates these concepts in action, showing how to create flexible, type-safe containers that can work with any type while providing useful operations and maintaining type safety throughout.