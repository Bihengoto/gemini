# The async and await Keywords

## The async Keyword

The `async` keyword is used to mark a function as asynchronous. When you add `async` to a function:

1. The function automatically returns a `Future`
2. You can use the `await` keyword inside the function
3. The function can be paused and resumed

```dart
// Regular synchronous function
String regularFunction() {
  return "Hello";
}

// Asynchronous function
Future<String> asyncFunction() async {
  return "Hello";
}
```

## The await Keyword

The `await` keyword is used to wait for a `Future` to complete. It can only be used inside `async` functions.

```dart
Future<void> demonstrateAwait() async {
  // Wait for the Future to complete and get the result
  String result = await Future.delayed(
    Duration(seconds: 2),
    () => "Operation completed!"
  );
  
  print(result); // This runs after 2 seconds
}
```

## async/await vs .then()

### Using .then() (callback style)
```dart
void usingThen() {
  fetchUserData()
    .then((userData) {
      return processUserData(userData);
    })
    .then((processedData) {
      return saveUserData(processedData);
    })
    .then((result) {
      print("All operations completed: $result");
    })
    .catchError((error) {
      print("Error occurred: $error");
    });
}
```

### Using async/await (cleaner style)
```dart
Future<void> usingAsyncAwait() async {
  try {
    String userData = await fetchUserData();
    String processedData = await processUserData(userData);
    String result = await saveUserData(processedData);
    print("All operations completed: $result");
  } catch (error) {
    print("Error occurred: $error");
  }
}
```

## Error Handling with async/await

```dart
Future<String> fetchDataWithErrorHandling() async {
  try {
    // This might throw an exception
    String data = await riskyNetworkCall();
    return data;
  } catch (e) {
    // Handle the error
    print("Error fetching data: $e");
    return "Default data";
  } finally {
    // This always runs
    print("Cleanup operations");
  }
}
```

## Multiple Futures

### Sequential execution (one after another)
```dart
Future<void> sequentialExecution() async {
  String first = await fetchFirst();   // Wait for first
  String second = await fetchSecond(); // Then wait for second
  String third = await fetchThird();   // Then wait for third
  
  print("All completed: $first, $second, $third");
}
```

### Parallel execution (all at once)
```dart
Future<void> parallelExecution() async {
  // Start all operations simultaneously
  Future<String> firstFuture = fetchFirst();
  Future<String> secondFuture = fetchSecond();
  Future<String> thirdFuture = fetchThird();
  
  // Wait for all to complete
  List<String> results = await Future.wait([
    firstFuture,
    secondFuture,
    thirdFuture,
  ]);
  
  print("All completed: ${results.join(', ')}");
}
```

## Key Rules

1. **async functions always return a Future**
2. **await can only be used inside async functions**
3. **await pauses the function until the Future completes**
4. **Use try/catch for error handling with async/await**
5. **async/await makes asynchronous code look synchronous**