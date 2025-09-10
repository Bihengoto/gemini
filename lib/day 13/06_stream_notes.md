# Day 13: Asynchronous Programming - Streams

## Overview
Streams in Dart provide a way to handle sequences of asynchronous data events. Unlike Futures that represent a single asynchronous value, Streams can emit multiple values over time.

## Key Concepts

### 1. What are Streams?
- **Definition**: A sequence of asynchronous data events
- **Analogy**: Like a pipe where data flows through over time
- **Use Cases**: User input, network responses, file I/O, real-time data

### 2. Stream Types
- **Single-subscription streams**: Can only be listened to once
- **Broadcast streams**: Can have multiple listeners

### 3. Stream Events
- **Data events**: Normal data flowing through the stream
- **Error events**: When something goes wrong
- **Done event**: When the stream is closed/completed

## Core Components

### StreamController
```dart
// Single subscription
StreamController<T> controller = StreamController<T>();

// Broadcast (multiple listeners)
StreamController<T> broadcastController = StreamController<T>.broadcast();
```

### StreamSubscription
```dart
StreamSubscription subscription = stream.listen(
  (data) => print(data),
  onError: (error) => print('Error: $error'),
  onDone: () => print('Done'),
);
```

## Common Stream Operations

### Listening to Streams
1. **listen() method**
   ```dart
   stream.listen((data) => print(data));
   ```

2. **await for loop**
   ```dart
   await for (var data in stream) {
     print(data);
   }
   ```

### Stream Transformations
- `where()` - Filter data
- `map()` - Transform data
- `take()` - Limit events
- `skip()` - Skip events
- `distinct()` - Remove duplicates

### Subscription Control
- `pause()` - Temporarily stop listening
- `resume()` - Resume listening
- `cancel()` - Stop listening permanently

## Best Practices

### 1. Memory Management
- Always cancel subscriptions when done
- Use `cancelOnError: false` to continue after errors
- Close StreamControllers when finished

### 2. Error Handling
```dart
stream.listen(
  (data) => processData(data),
  onError: (error) => handleError(error),
  cancelOnError: false,
);
```

### 3. Resource Cleanup
```dart
StreamSubscription? subscription;

void dispose() {
  subscription?.cancel();
}
```

## Common Patterns

### 1. Creating Custom Streams
```dart
Stream<int> countStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}
```

### 2. Stream from Periodic Timer
```dart
Stream<int> periodicStream = Stream.periodic(
  Duration(seconds: 1),
  (count) => count,
).take(10);
```

### 3. Broadcast Stream
```dart
StreamController<String> controller = StreamController.broadcast();

// Multiple listeners
controller.stream.listen((data) => print('Listener 1: $data'));
controller.stream.listen((data) => print('Listener 2: $data'));
```

## Practice Exercises

### Exercise 1: Basic Number Stream
Create a stream that emits numbers 1-10 with 1-second intervals.

### Exercise 2: Filtered Stream
Create a stream that emits only even numbers from 1-20.

### Exercise 3: Interactive Stream
Create a stream with pause/resume functionality.

### Exercise 4: Error Handling
Create a stream that handles errors gracefully and continues operation.

## Real-World Applications

### 1. User Interface Events
```dart
// Button clicks, text input changes
StreamController<String> searchController = StreamController();
searchController.stream
  .debounce(Duration(milliseconds: 300))
  .listen((query) => performSearch(query));
```

### 2. Network Data
```dart
// Real-time data updates
Stream<List<Message>> messageStream = 
  webSocket.stream.map((data) => parseMessages(data));
```

### 3. File Operations
```dart
// Reading large files
Stream<String> fileLines = file.openRead()
  .transform(utf8.decoder)
  .transform(LineSplitter());
```

## Key Takeaways

1. **Streams handle multiple asynchronous values over time**
2. **Always manage subscriptions properly to prevent memory leaks**
3. **Use appropriate stream operations for data transformation**
4. **Handle errors gracefully with proper error handling**
5. **Choose between single-subscription and broadcast streams based on needs**
6. **Streams are perfect for reactive programming patterns**

## Next Steps
- Explore StreamBuilder for Flutter UI integration
- Learn about Stream transformers for complex data processing
- Practice with real-world scenarios like WebSocket connections
- Study reactive programming patterns with Streams