# Mixin Best Practices

Guidelines and best practices for using mixins effectively in Dart.

## Naming Conventions

### Use Descriptive Names
- End mixin names with 'able', 'ible', or describe the behavior
- Examples: `Flyable`, `Swimmable`, `Drawable`, `Comparable`

```dart
// Good
mixin Jumpable { }
mixin Trackable { }
mixin Debuggable { }

// Avoid
mixin Helper { }
mixin Utils { }
mixin Stuff { }
```

## Design Principles

### 1. Single Responsibility
Each mixin should have one clear, focused purpose.

```dart
// Good - focused on jumping behavior
mixin Jumpable {
  void jump();
  bool canJump();
}

// Avoid - too many responsibilities
mixin AnimalBehaviors {
  void jump();
  void fly();
  void swim();
  void eat();
}
```

### 2. Composition over Inheritance
Use mixins to compose behaviors rather than create deep inheritance hierarchies.

```dart
// Good - compose behaviors
class Bird extends Animal with Flyable, Singable { }

// Avoid - deep inheritance
class Animal { }
class FlyingAnimal extends Animal { }
class SingingFlyingAnimal extends FlyingAnimal { }
```

### 3. Abstract Properties for Dependencies
Use abstract properties when the mixin needs data from the using class.

```dart
mixin Energetic {
  // Abstract property - must be provided by using class
  int get energy;
  set energy(int value);
  
  void useEnergy(int amount) {
    if (energy >= amount) {
      energy -= amount;
    }
  }
}
```

## Common Patterns

### 1. Capability Mixins
Mixins that add specific capabilities to classes.

```dart
mixin Serializable {
  Map<String, dynamic> toJson();
  void fromJson(Map<String, dynamic> json);
}

mixin Comparable<T> {
  int compareTo(T other);
  
  bool operator >(T other) => compareTo(other) > 0;
  bool operator <(T other) => compareTo(other) < 0;
}
```

### 2. State Management Mixins
Mixins that manage specific state or behavior.

```dart
mixin Cacheable<T> {
  final Map<String, T> _cache = {};
  
  T? getCached(String key) => _cache[key];
  void cache(String key, T value) => _cache[key] = value;
  void clearCache() => _cache.clear();
}
```

### 3. Utility Mixins
Mixins that provide utility functions.

```dart
mixin ValidationMixin {
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  bool isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s-()]+$').hasMatch(phone);
  }
}
```

## What to Avoid

### 1. Mixins with Constructors
```dart
// Wrong - mixins cannot have constructors
mixin BadMixin {
  BadMixin(String name); // Error!
}
```

### 2. Too Many Dependencies
```dart
// Avoid - too many abstract requirements
mixin OverlyComplex {
  String get name;
  int get age;
  double get weight;
  String get address;
  // ... too many requirements
}
```

### 3. Mixin Conflicts
Be careful with method name conflicts when using multiple mixins.

```dart
mixin A {
  void method() => print('A');
}

mixin B {
  void method() => print('B');
}

class C with A, B {
  // B.method() will be used (rightmost wins)
  // If you need A's method, override it
  @override
  void method() {
    super.method(); // Calls B.method()
    // Or call A's method explicitly if needed
  }
}
```

## Testing Mixins

### Test Mixins Independently
```dart
// Create a test class to test the mixin
class TestClass with Jumpable {
  @override
  int energy = 100;
  
  @override
  String name = 'Test';
}

void testJumpableMixin() {
  var test = TestClass();
  test.jump();
  // Assert expected behavior
}
```

## Documentation

Always document your mixins clearly:

```dart
/// A mixin that provides jumping capabilities to classes.
/// 
/// Classes using this mixin must provide [energy] and [name] properties.
/// The mixin will manage energy consumption during jumps.
/// 
/// Example:
/// ```dart
/// class Rabbit extends Animal with Jumpable {
///   // Implementation
/// }
/// ```
mixin Jumpable {
  // Implementation
}
```

## Summary

- Keep mixins focused and single-purpose
- Use descriptive names ending with 'able'
- Prefer composition over inheritance
- Use abstract properties for dependencies
- Document expected behavior and requirements
- Test mixins independently
- Be mindful of method conflicts with multiple mixins