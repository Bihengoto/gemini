# The 'with' Keyword

The `with` keyword is used to apply mixins to a class. It allows you to "mix in" the functionality from one or more mixins into your class.

## Syntax

```dart
class ClassName extends SuperClass with Mixin1, Mixin2, Mixin3 {
  // Class body
}
```

## Key Rules

1. **Order Matters**: Mixins are applied from left to right
2. **Method Resolution**: If multiple mixins have the same method, the rightmost mixin wins
3. **No Constructors**: Mixins cannot have constructors
4. **Can Use Super**: Mixins can call super methods

## Examples of Usage

### Single Mixin
```dart
class Bird extends Animal with Flyable {
  // Bird now has both Animal and Flyable functionality
}
```

### Multiple Mixins
```dart
class Duck extends Animal with Flyable, Swimmable {
  // Duck has Animal, Flyable, and Swimmable functionality
}
```

### Mixin Order Example
```dart
mixin A {
  void method() => print('A');
}

mixin B {
  void method() => print('B');
}

class C with A, B {
  // method() will print 'B' because B is applied last
}
```

## Best Practices

- Use descriptive names ending with 'able' (Flyable, Swimmable)
- Keep mixins focused on a single responsibility
- Document the expected behavior and requirements
- Consider the order when using multiple mixins