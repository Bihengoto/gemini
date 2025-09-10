# Understanding the Future Class

## What is a Future?

A `Future` represents a potential value or error that will be available at some time in the future. Think of it as a "promise" that a value will be delivered later.

## Future States

A Future can be in one of three states:

1. **Uncompleted**: The operation is still running
2. **Completed with a value**: The operation finished successfully
3. **Completed with an error**: The operation failed

## Basic Future Syntax

```dart
// Creating a Future that completes with a value
Future<String> myFuture = Future.value("Hello, Future!");

// Creating a Future that completes after a delay
Future<String> delayedFuture = Future.delayed(
  Duration(seconds: 2),
  () => "This completed after 2 seconds"
);

// Creating a Future that might fail
Future<int> riskyFuture = Future.error("Something went wrong!");
```

## Working with Futures

### Method 1: Using .then() and .catchError()

```dart
void demonstrateThen() {
  Future<String> future = Future.delayed(
    Duration(seconds: 1),
    () => "Future completed!"
  );
  
  future
    .then((value) {
      print("Success: $value");
    })
    .catchError((error) {
      print("Error: $error");
    });
}
```

### Method 2: Using async/await (Preferred)

```dart
Future<void> demonstrateAsyncAwait() async {
  try {
    String result = await Future.delayed(
      Duration(seconds: 1),
      () => "Future completed!"
    );
    print("Success: $result");
  } catch (error) {
    print("Error: $error");
  }
}
```

## Future Types

```dart
// Future that returns a String
Future<String> getString() async {
  return "Hello";
}

// Future that returns an int
Future<int> getNumber() async {
  return 42;
}

// Future that returns nothing (void)
Future<void> doSomething() async {
  print("Doing something...");
}

// Future that returns a custom object
Future<User> getUser() async {
  return User(name: "John", age: 30);
}
```

## Key Points

- Futures are "lazy" - they don't start executing until you await them or call .then()
- Always handle errors when working with Futures
- Use async/await for cleaner, more readable code
- Futures can be chained together for complex operations