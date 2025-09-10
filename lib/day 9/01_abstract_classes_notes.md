# Day 9: Abstract Classes & Interfaces

## Abstract Classes

### What are Abstract Classes?
- Abstract classes are classes that cannot be instantiated directly
- They serve as blueprints for other classes
- Can contain both abstract methods (without implementation) and concrete methods (with implementation)
- Use the `abstract` keyword to define an abstract class

### Key Features:
- Cannot create instances of abstract classes
- Can have constructors (used by subclasses)
- Can contain both abstract and concrete methods
- Subclasses must implement all abstract methods
- Can have instance variables and getters/setters

### Syntax:
```dart
abstract class ClassName {
  // Abstract method (no implementation)
  void abstractMethod();
  
  // Concrete method (with implementation)
  void concreteMethod() {
    // implementation
  }
}
```

### When to Use Abstract Classes:
- When you want to share code among several closely related classes
- When you want to force subclasses to implement certain methods
- When you have common functionality but some methods need different implementations