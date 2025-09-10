// Day 13: Asynchronous Programming - Streams
// File 4: Listening to and Canceling Streams

/*
LISTENING TO STREAMS

Ways to listen to streams:
1. listen() method - Returns StreamSubscription
2. await for loop - Consumes entire stream
3. forEach() method - Process each element

StreamSubscription Methods:
- pause() - Pause the subscription
- resume() - Resume the subscription  
- cancel() - Cancel the subscription
- asFuture() - Convert to Future that completes when done

Best Practices:
- Always cancel subscriptions to prevent memory leaks
- Handle errors appropriately
- Use try-catch with await for loops
*/

import 'dart:async';

void main() async {
  print('=== Listening and Canceling Streams ===\n');

  await demonstrateListenMethod();
  await demonstrateAwaitForLoop();
  await demonstrateSubscriptionControl();
  await demonstrateErrorHandling();
}

Future<void> demonstrateListenMethod() async {
  print('1. Using listen() method:');

  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  StreamSubscription<int> subscription = numberStream.listen(
    (data) {
      print('Data received: $data');
    },
    onError: (error) {
      print('Error occurred: $error');
    },
    onDone: () {
      print('Stream completed');
    },
    cancelOnError: false, // Continue listening even after error
  );

  // Wait for completion
  await subscription.asFuture();
  print();
}

Future<void> demonstrateAwaitForLoop() async {
  print('2. Using await for loop:');

  Stream<String> messageStream = Stream.fromIterable([
    'Hello',
    'World',
    'from',
    'Dart',
    'Streams',
  ]);

  try {
    await for (String message in messageStream) {
      print('Message: $message');

      // Simulate some processing time
      await Future.delayed(Duration(milliseconds: 200));
    }
    print('All messages processed');
  } catch (error) {
    print('Error in await for: $error');
  }
  print();
}

Future<void> demonstrateSubscriptionControl() async {
  print('3. Subscription Control:');

  // Create a stream that emits numbers every 500ms
  StreamController<int> controller = StreamController<int>();

  // Start emitting numbers
  Timer.periodic(Duration(milliseconds: 500), (timer) {
    if (!controller.isClosed) {
      controller.add(timer.tick);

      // Close after 10 ticks
      if (timer.tick >= 10) {
        timer.cancel();
        controller.close();
      }
    }
  });

  StreamSubscription<int> subscription = controller.stream.listen(
    (data) => print('Tick: $data'),
  );

  // Cancel subscription after 3 seconds
  Timer(Duration(seconds: 3), () {
    print('Canceling subscription...');
    subscription.cancel();
  });

  // Wait a bit to see the cancellation effect
  await Future.delayed(Duration(seconds: 4));
  print('Subscription control demo completed\n');
}

Future<void> demonstrateErrorHandling() async {
  print('4. Error Handling in Streams:');

  StreamController<int> controller = StreamController<int>();

  // Listen with error handling
  StreamSubscription subscription = controller.stream.listen(
    (data) => print('Data: $data'),
    onError: (error, stackTrace) {
      print('Caught error: $error');
      // Don't cancel on error, continue listening
    },
    onDone: () => print('Stream finished'),
    cancelOnError: false,
  );

  // Add some data and errors
  controller.add(1);
  controller.add(2);
  controller.addError('First error occurred!');
  controller.add(3);
  controller.addError('Second error occurred!');
  controller.add(4);
  controller.close();

  await subscription.asFuture();
  print();
}

// Example of a stream with built-in error handling
Stream<int> createStreamWithErrors() async* {
  for (int i = 1; i <= 5; i++) {
    if (i == 3) {
      throw Exception('Error at number $i');
    }
    yield i;
    await Future.delayed(Duration(milliseconds: 300));
  }
}
