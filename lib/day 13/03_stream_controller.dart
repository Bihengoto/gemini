// Day 13: Asynchronous Programming - Streams
// File 3: StreamController - Creating Custom Streams

/*
STREAMCONTROLLER

StreamController is used to create custom streams:
- Controls when data is added to the stream
- Can add data, errors, and close the stream
- Provides both Stream (output) and Sink (input)

Types:
1. StreamController<T>() - Single subscription
2. StreamController<T>.broadcast() - Multiple subscriptions

Key Methods:
- add(data) - Add data to stream
- addError(error) - Add error to stream
- close() - Close the stream
- sink.add(data) - Alternative way to add data
*/

import 'dart:async';
import 'dart:math';

void main() async {
  print('=== StreamController Examples ===\n');

  await demonstrateBasicController();
  await demonstrateBroadcastController();
  await demonstrateCustomDataStream();
}

Future<void> demonstrateBasicController() async {
  print('1. Basic StreamController:');

  // Create a stream controller
  StreamController<String> controller = StreamController<String>();

  // Listen to the stream
  StreamSubscription subscription = controller.stream.listen(
    (data) => print('Received: $data'),
    onError: (error) => print('Error: $error'),
    onDone: () => print('Stream closed'),
  );

  // Add data to the stream
  controller.add('Hello');
  controller.add('World');
  controller.add('from');
  controller.add('StreamController');

  // Add an error
  controller.addError('Something went wrong!');

  // Add more data
  controller.add('But we continue...');

  // Close the stream
  controller.close();

  // Wait for completion
  await subscription.asFuture();
  print();
}

Future<void> demonstrateBroadcastController() async {
  print('2. Broadcast StreamController (Multiple Listeners):');

  // Create a broadcast stream controller
  StreamController<int> broadcastController = StreamController<int>.broadcast();

  // Add multiple listeners
  broadcastController.stream.listen((data) => print('Listener 1: $data'));

  broadcastController.stream.listen((data) => print('Listener 2: ${data * 2}'));

  broadcastController.stream.listen(
    (data) => print('Listener 3: ${data * data}'),
  );

  // Add data - all listeners will receive it
  for (int i = 1; i <= 5; i++) {
    broadcastController.add(i);
    await Future.delayed(Duration(milliseconds: 500));
  }

  broadcastController.close();
  print();
}

Future<void> demonstrateCustomDataStream() async {
  print('3. Custom Data Stream (Random Numbers):');

  // Create a custom stream that generates random numbers
  Stream<int> randomNumberStream = createRandomNumberStream(10);

  await for (int number in randomNumberStream) {
    print('Random number: $number');
  }
  print();
}

// Custom function to create a stream of random numbers
Stream<int> createRandomNumberStream(int count) {
  StreamController<int> controller = StreamController<int>();
  Random random = Random();
  int generated = 0;

  // Timer to generate numbers periodically
  Timer.periodic(Duration(milliseconds: 300), (timer) {
    if (generated < count) {
      int randomNumber = random.nextInt(100);
      controller.add(randomNumber);
      generated++;
    } else {
      timer.cancel();
      controller.close();
    }
  });

  return controller.stream;
}
