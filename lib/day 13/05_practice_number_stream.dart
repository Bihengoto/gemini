// Day 13: Asynchronous Programming - Streams
// File 5: Practice - Number Stream Over Time

/*
PRACTICE: CREATE A SIMPLE STREAM THAT EMITS NUMBERS OVER TIME

This file contains multiple implementations of number streams:
1. Basic periodic number stream
2. Configurable number stream with custom intervals
3. Number stream with mathematical operations
4. Interactive number stream with user control
*/

import 'dart:async';
import 'dart:math';

void main() async {
  print('=== Practice: Number Streams Over Time ===\n');

  await basicNumberStream();
  await configurableNumberStream();
  await mathematicalNumberStream();
  await interactiveNumberStream();
}

// Practice 1: Basic number stream
Future<void> basicNumberStream() async {
  print('1. Basic Number Stream (1-10 every second):');

  Stream<int> numberStream = createBasicNumberStream(10, Duration(seconds: 1));

  await for (int number in numberStream) {
    print('Number: $number');
  }
  print('Basic stream completed!\n');
}

// Practice 2: Configurable number stream
Future<void> configurableNumberStream() async {
  print('2. Configurable Number Stream (Even numbers, 1-20, every 500ms):');

  Stream<int> evenNumberStream = createConfigurableNumberStream(
    start: 1,
    end: 20,
    interval: Duration(milliseconds: 500),
    filter: (n) => n % 2 == 0, // Only even numbers
  );

  await for (int number in evenNumberStream) {
    print('Even number: $number');
  }
  print('Configurable stream completed!\n');
}

// Practice 3: Mathematical number stream
Future<void> mathematicalNumberStream() async {
  print('3. Mathematical Number Stream (Fibonacci sequence):');

  Stream<int> fibonacciStream = createFibonacciStream(
    10,
    Duration(milliseconds: 600),
  );

  await for (int number in fibonacciStream) {
    print('Fibonacci: $number');
  }
  print('Fibonacci stream completed!\n');
}

// Practice 4: Interactive number stream with controls
Future<void> interactiveNumberStream() async {
  print('4. Interactive Number Stream (Random numbers with pause/resume):');

  NumberStreamController controller = NumberStreamController();

  // Start the stream
  controller.start(Duration(milliseconds: 400));

  // Listen to the stream
  StreamSubscription subscription = controller.stream.listen(
    (number) => print('Random: $number'),
    onDone: () => print('Interactive stream completed!'),
  );

  // Pause after 2 seconds
  Timer(Duration(seconds: 2), () {
    print('--- Pausing stream ---');
    controller.pause();
  });

  // Resume after 1 second
  Timer(Duration(seconds: 3), () {
    print('--- Resuming stream ---');
    controller.resume();
  });

  // Stop after 5 seconds
  Timer(Duration(seconds: 5), () {
    print('--- Stopping stream ---');
    controller.stop();
  });

  await subscription.asFuture();
  print();
}

// Implementation 1: Basic number stream
Stream<int> createBasicNumberStream(int count, Duration interval) async* {
  for (int i = 1; i <= count; i++) {
    yield i;
    await Future.delayed(interval);
  }
}

// Implementation 2: Configurable number stream
Stream<int> createConfigurableNumberStream({
  required int start,
  required int end,
  required Duration interval,
  bool Function(int)? filter,
}) async* {
  for (int i = start; i <= end; i++) {
    if (filter == null || filter(i)) {
      yield i;
      await Future.delayed(interval);
    }
  }
}

// Implementation 3: Fibonacci stream
Stream<int> createFibonacciStream(int count, Duration interval) async* {
  int a = 0, b = 1;

  for (int i = 0; i < count; i++) {
    yield a;
    int temp = a + b;
    a = b;
    b = temp;
    await Future.delayed(interval);
  }
}

// Implementation 4: Interactive number stream controller
class NumberStreamController {
  StreamController<int>? _controller;
  Timer? _timer;
  Random _random = Random();
  bool _isPaused = false;

  Stream<int> get stream => _controller!.stream;

  void start(Duration interval) {
    _controller = StreamController<int>();

    _timer = Timer.periodic(interval, (timer) {
      if (!_isPaused && !_controller!.isClosed) {
        int randomNumber = _random.nextInt(100) + 1;
        _controller!.add(randomNumber);
      }
    });
  }

  void pause() {
    _isPaused = true;
  }

  void resume() {
    _isPaused = false;
  }

  void stop() {
    _timer?.cancel();
    _controller?.close();
  }
}

// Bonus: Advanced number stream with transformations
Stream<Map<String, dynamic>> createAdvancedNumberStream() async* {
  Random random = Random();

  for (int i = 1; i <= 15; i++) {
    int number = random.nextInt(50) + 1;

    yield {
      'sequence': i,
      'value': number,
      'isEven': number % 2 == 0,
      'isPrime': _isPrime(number),
      'square': number * number,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    await Future.delayed(Duration(milliseconds: 800));
  }
}

// Helper function to check if a number is prime
bool _isPrime(int number) {
  if (number < 2) return false;
  for (int i = 2; i <= number ~/ 2; i++) {
    if (number % i == 0) return false;
  }
  return true;
}
