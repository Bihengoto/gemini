# Variable Declaration Keywords: var, final, const

Dart provides three main keywords for variable declaration, each with specific use cases and behaviors.

## var
- Type is inferred from the assigned value
- Variable can be reassigned
- Mutable reference

```dart
var name = 'John'; // String inferred
var age = 25; // int inferred
name = 'Jane'; // ✅ Allowed - can reassign
```

## final
- Value is set once and cannot be changed
- Type can be inferred or explicitly declared
- Runtime constant (value determined at runtime)
- Immutable reference, but object can be mutable

```dart
final String city = 'New York';
final currentTime = DateTime.now(); // Runtime value
// city = 'Boston'; // ❌ Error - cannot reassign

final List<String> fruits = ['apple', 'banana'];
fruits.add('orange'); // ✅ Allowed - list is mutable
// fruits = ['grape']; // ❌ Error - cannot reassign reference
```

## const
- Compile-time constant
- Value must be known at compile time
- Immutable reference and immutable object
- More memory efficient (canonical instances)

```dart
const String appName = 'MyApp';
const int maxUsers = 100;
const List<String> colors = ['red', 'green', 'blue'];
// colors.add('yellow'); // ❌ Error - const list is immutable
```

## When to Use Each:

### Use `var` when:
- You need to reassign the variable
- Type inference is sufficient
- Working with changing values

### Use `final` when:
- Value is set once but determined at runtime
- You want immutable references
- Working with objects that might be mutable internally

### Use `const` when:
- Value is known at compile time
- You want complete immutability
- Creating constants that won't change
- Memory optimization is important

## Best Practices:
1. Prefer `final` over `var` when possible
2. Use `const` for compile-time constants
3. Be explicit with types when clarity is important
4. Use `var` sparingly, mainly for complex type inference