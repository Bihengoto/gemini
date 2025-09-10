// Day 13: Asynchronous Programming - Streams
// File 2: Stream Operations and Transformations

/*
STREAM OPERATIONS

Common Stream Methods:
1. listen() - Subscribe to stream events
2. where() - Filter stream data
3. map() - Transform stream data
4. take() - Limit number of events
5. skip() - Skip first n events
6. distinct() - Remove duplicates
7. timeout() - Add timeout to stream
8. handleError() - Handle errors gracefully

Stream Subscription Methods:
- pause() - Temporarily stop listening
- resume() - Resume listening
- cancel() - Stop listening permanently
*/

import 'dart:async';

void main() async {
  print('=== Stream Operations ===\n');

  await demonstrateStreamTransformations();
  await demonstrateStreamFiltering();
  await demonstrateStreamControl();
}

Future<void> demonstrateStreamTransformations() async {
  print('1. Stream Transformations:');

  // Create a stream of numbers
  Stream<int> numbers = Stream.fromIterable([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

  // Transform and filter the stream
  Stream<String> transformedStream = numbers
      .where((number) => number % 2 == 0) // Filter even numbers
      .map((number) => 'Even: $number') // Transform to string
      .take(3); // Take only first 3

  await for (String data in transformedStream) {
    print(data);
  }
  print();
}

Future<void> demonstrateStreamFiltering() async {
  print('2. Stream Filtering and Distinct:');

  // Stream with duplicates
  Stream<int> numbersWithDuplicates = Stream.fromIterable([
    1,
    2,
    2,
    3,
    3,
    3,
    4,
    5,
    5,
  ]);

  Stream<int> uniqueNumbers = numbersWithDuplicates
      .distinct() // Remove duplicates
      .where((number) => number > 2); // Filter numbers > 2

  await for (int number in uniqueNumbers) {
    print('Unique number > 2: $number');
  }
  print();
}

Future<void> demonstrateStreamControl() async {
  print('3. Stream Control (Pause/Resume):');

  // Create a periodic stream
  Stream<int> periodicStream = Stream.periodic(
    Duration(milliseconds: 500),
    (count) => count + 1,
  ).take(10);

  StreamSubscription<int> subscription = periodicStream.listen(
    (data) => print('Data: $data'),
  );

  // Pause after 2 seconds
  Timer(Duration(seconds: 2), () {
    print('Pausing stream...');
    subscription.pause();

    // Resume after 1 second
    Timer(Duration(seconds: 1), () {
      print('Resuming stream...');
      subscription.resume();
    });
  });

  // Wait for completion
  await subscription.asFuture();
  print('Stream control demo completed!\n');
}
