# Null Safety and Nullable Operator

Dart 2.12 introduced sound null safety, which helps prevent null reference errors at compile time.

## What is Null Safety?
- Prevents null reference exceptions
- Variables are non-nullable by default
- Must explicitly declare when a variable can be null
- Compile-time guarantees about null values

## Non-nullable vs Nullable Types

### Non-nullable (Default)
```dart
String name = 'John'; // Cannot be null
int age = 25; // Cannot be null
bool isActive = true; // Cannot be null

// name = null; // ❌ Error - cannot assign null
```

### Nullable (with ? operator)
```dart
String? nullableName; // Can be null
int? nullableAge; // Can be null
bool? nullableStatus; // Can be null

nullableName = null; // ✅ Allowed
nullableName = 'Alice'; // ✅ Also allowed
```

## Working with Nullable Variables

### Null-aware operators:

#### Null-aware access (?.)
```dart
String? name;
int? length = name?.length; // Returns null if name is null
```

#### Null coalescing (??)
```dart
String? name;
String displayName = name ?? 'Guest'; // Use 'Guest' if name is null
```

#### Null assignment (??=)
```dart
String? name;
name ??= 'Default'; // Assign 'Default' only if name is null
```

#### Null assertion (!)
```dart
String? name = 'John';
int length = name!.length; // Assert that name is not null
// Use carefully - throws exception if name is actually null
```

## Null Safety Best Practices:

1. **Prefer non-nullable types** when possible
2. **Use nullable types** only when null is a valid state
3. **Check for null** before using nullable variables
4. **Use null-aware operators** to handle null safely
5. **Avoid null assertion (!)** unless you're certain the value isn't null

## Late Variables:
```dart
late String description; // Will be initialized later
// Must be initialized before first use
```

## Benefits of Null Safety:
- Eliminates null reference exceptions
- Makes code more predictable
- Better IDE support and error detection
- Improved performance (no runtime null checks needed)