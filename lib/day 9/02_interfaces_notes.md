# Interfaces in Dart

## What are Interfaces?
- In Dart, every class implicitly defines an interface
- An interface is a contract that defines what methods a class must implement
- Use the `implements` keyword to implement an interface
- A class can implement multiple interfaces

### Key Differences: Abstract Classes vs Interfaces

| Abstract Classes | Interfaces |
|-----------------|------------|
| Use `extends` keyword | Use `implements` keyword |
| Can have concrete methods | Must implement all methods |
| Single inheritance | Multiple implementation |
| Can have constructors | Cannot use constructors |
| Can have instance variables | Must redefine all properties |

### Syntax:
```dart
// Define an interface (any class can be an interface)
class InterfaceName {
  void method1();
  void method2();
}

// Implement the interface
class ClassName implements InterfaceName {
  @override
  void method1() {
    // implementation
  }
  
  @override
  void method2() {
    // implementation
  }
}
```

### Multiple Interface Implementation:
```dart
class MyClass implements Interface1, Interface2, Interface3 {
  // Must implement all methods from all interfaces
}
```

### When to Use Interfaces:
- When you want to ensure a class has certain methods
- When you need multiple inheritance-like behavior
- When you want to define a contract without providing implementation