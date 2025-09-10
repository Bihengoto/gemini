// Day 25: Exploring dart:async Library
// The dart:async library provides asynchronous programming support

import 'dart:async';
import 'dart:math';

void main() async {
  print('=== DART:ASYNC LIBRARY EXPLORATION ===\n');
  
  // Future operations
  await futureOperations();
  
  // Stream operations
  await streamOperations();
  
  // Timer operations
  await timerOperations();
  
  // Completer operations
  await completerOperations();
  
  // Zone operations
  zoneOperations();
  
  // Stream controller operations
  await streamControllerOperations();
  
  // Advanced async patterns
  await advancedAsyncPatterns();
}

// 1. Future Operations
Future<void> futureOperations() async {
  print('1. FUTURE OPERATIONS');
  print('--------------------');
  
  // Basic Future creation
  Future<String> simpleFuture = Future.value('Hello, Future!');
  String result = await simpleFuture;
  print('Simple future result: $result');
  
  // Future with delay
  Future<String> delayedFuture = Future.delayed(
    Duration(milliseconds: 100),
    () => 'Delayed result'
  );
  String delayedResult = await delayedFuture;
  print('Delayed future result: $delayedResult');
  
  // Future with computation
  Future<int> computationFuture = Future(() {
    int sum = 0;
    for (int i = 1; i <= 100; i++) {
      sum += i;
    }
    return sum;
  });
  int computationResult = await computationFuture;
  print('Computation result: $computationResult');
  
  // Future error handling
  try {
    await Future.error('This is an error');
  } catch (e) {
    print('Caught error: $e');
  }
  
  // Future.wait - parallel execution
  List<Future<int>> futures = [
    Future.delayed(Duration(milliseconds: 100), () => 1),
    Future.delayed(Duration(milliseconds: 200), () => 2),
    Future.delayed(Duration(milliseconds: 150), () => 3),
  ];
  
  List<int> results = await Future.wait(futures);
  print('Parallel results: $results');
  
  // Future.any - first to complete
  Future<String> firstResult = Future.any([
    Future.delayed(Duration(milliseconds: 300), () => 'Third'),
    Future.delayed(Duration(milliseconds: 100), () => 'First'),
    Future.delayed(Duration(milliseconds: 200), () => 'Second'),
  ]);
  String first = await firstResult;
  print('First completed: $first');
  
  // Future chaining
  String chainedResult = await Future.value('start')
      .then((value) => '$value -> middle')
      .then((value) => '$value -> end');
  print('Chained result: $chainedResult');
  
  // Future with timeout
  try {
    String timeoutResult = await Future.delayed(Duration(seconds: 1), () => 'Too slow')
        .timeout(Duration(milliseconds: 500));
    print('Timeout result: $timeoutResult');
  } on TimeoutException catch (e) {
    print('Timeout occurred: ${e.message}');
  }
  
  // Future.microtask
  Future.microtask(() => print('Microtask executed'));
  print('After microtask scheduled');
  
  // Wait for microtask to complete
  await Future.delayed(Duration.zero);
  print('');
}

// 2. Stream Operations
Future<void> streamOperations() async {
  print('2. STREAM OPERATIONS');
  print('--------------------');
  
  // Simple stream from iterable
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);
  print('Numbers from stream:');
  await for (int number in numberStream) {
    print('  $number');
  }
  
  // Stream with periodic generation
  Stream<int> periodicStream = Stream.periodic(
    Duration(milliseconds: 100),
    (count) => count * count
  ).take(5);
  
  print('Periodic stream (squares):');
  await for (int square in periodicStream) {
    print('  $square');
  }
  
  // Stream transformations
  Stream<String> transformedStream = Stream.fromIterable([1, 2, 3, 4, 5])
      .where((n) => n % 2 == 0)  // Filter even numbers
      .map((n) => 'Even: $n')    // Transform to strings
      .take(3);                  // Take first 3
  
  print('Transformed stream:');
  await for (String item in transformedStream) {
    print('  $item');
  }
  
  // Stream with error handling
  Stream<int> errorStream = Stream.fromIterable([1, 2, 3])
      .map((n) {
        if (n == 2) throw Exception('Error at $n');
        return n * 10;
      });
  
  print('Stream with error handling:');
  await for (int value in errorStream.handleError((error) {
    print('  Handled error: $error');
  })) {
    print('  Value: $value');
  }
  
  // Stream subscription
  print('Stream subscription:');
  StreamSubscription<int> subscription = Stream.periodic(
    Duration(milliseconds: 100),
    (count) => count
  ).listen(
    (data) => print('  Received: $data'),
    onError: (error) => print('  Error: $error'),
    onDone: () => print('  Stream completed'),
  );
  
  // Cancel subscription after some time
  await Future.delayed(Duration(milliseconds: 350));
  await subscription.cancel();
  print('  Subscription cancelled');
  
  // Stream reduce and fold
  int sum = await Stream.fromIterable([1, 2, 3, 4, 5])
      .reduce((a, b) => a + b);
  print('Stream sum: $sum');
  
  String concatenated = await Stream.fromIterable(['a', 'b', 'c'])
      .fold('start', (prev, element) => '$prev-$element');
  print('Stream fold: $concatenated');
  
  // Stream first, last, single
  int first = await Stream.fromIterable([10, 20, 30]).first;
  int last = await Stream.fromIterable([10, 20, 30]).last;
  print('First: $first, Last: $last');
  
  // Stream any, every, contains
  bool hasEven = await Stream.fromIterable([1, 3, 4, 7])
      .any((n) => n % 2 == 0);
  bool allPositive = await Stream.fromIterable([1, 2, 3])
      .every((n) => n > 0);
  bool containsFive = await Stream.fromIterable([1, 2, 5, 8])
      .contains(5);
  
  print('Has even: $hasEven, All positive: $allPositive, Contains 5: $containsFive');
  print('');
}

// 3. Timer Operations
Future<void> timerOperations() async {
  print('3. TIMER OPERATIONS');
  print('-------------------');
  
  // One-time timer
  print('Starting one-time timer...');
  Timer oneTimeTimer = Timer(Duration(milliseconds: 200), () {
    print('One-time timer fired!');
  });
  
  // Wait for timer to fire
  await Future.delayed(Duration(milliseconds: 300));
  
  // Periodic timer
  print('Starting periodic timer...');
  int count = 0;
  Timer periodicTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
    count++;
    print('Periodic timer tick: $count');
    
    if (count >= 3) {
      timer.cancel();
      print('Periodic timer cancelled');
    }
  });
  
  // Wait for periodic timer to complete
  await Future.delayed(Duration(milliseconds: 500));
  
  // Timer properties
  Timer testTimer = Timer(Duration(seconds: 1), () {});
  print('Timer is active: ${testTimer.isActive}');
  print('Timer tick: ${testTimer.tick}');
  testTimer.cancel();
  print('Timer cancelled, is active: ${testTimer.isActive}');
  
  // Immediate timer (runs in next event loop)
  Timer.run(() => print('Immediate timer executed'));
  await Future.delayed(Duration.zero); // Wait for immediate timer
  print('');
}

// 4. Completer Operations
Future<void> completerOperations() async {
  print('4. COMPLETER OPERATIONS');
  print('-----------------------');
  
  // Basic completer usage
  Completer<String> completer = Completer<String>();
  
  // Simulate async operation that completes the future
  Timer(Duration(milliseconds: 100), () {
    completer.complete('Completer result');
  });
  
  String result = await completer.future;
  print('Completer result: $result');
  
  // Completer with error
  Completer<int> errorCompleter = Completer<int>();
  
  Timer(Duration(milliseconds: 100), () {
    errorCompleter.completeError('Completer error');
  });
  
  try {
    await errorCompleter.future;
  } catch (e) {
    print('Completer error caught: $e');
  }
  
  // Completer properties
  Completer<void> testCompleter = Completer<void>();
  print('Completer is completed: ${testCompleter.isCompleted}');
  testCompleter.complete();
  print('Completer is completed: ${testCompleter.isCompleted}');
  
  // Using completer to convert callback to future
  Future<String> callbackToFuture() {
    Completer<String> completer = Completer<String>();
    
    // Simulate callback-based API
    Timer(Duration(milliseconds: 50), () {
      // This would be your callback
      completer.complete('Callback converted to Future');
    });
    
    return completer.future;
  }
  
  String callbackResult = await callbackToFuture();
  print('Callback to Future: $callbackResult');
  print('');
}

// 5. Zone Operations
void zoneOperations() {
  print('5. ZONE OPERATIONS');
  print('------------------');
  
  // Current zone
  Zone currentZone = Zone.current;
  print('Current zone: $currentZone');
  
  // Fork a new zone with error handling
  Zone errorZone = Zone.current.fork(
    specification: ZoneSpecification(
      handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone, Object error, StackTrace stackTrace) {
        print('Zone caught error: $error');
      },
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        parent.print(zone, 'Zone: $line');
      },
    ),
  );
  
  // Run code in the error zone
  errorZone.run(() {
    print('Running in custom zone');
    // This would normally crash the program
    // throw Exception('Zone error test');
  });
  
  // Zone with values
  Zone valueZone = Zone.current.fork(
    zoneValues: {'user': 'Alice', 'session': '12345'},
  );
  
  valueZone.run(() {
    String? user = Zone.current['user'];
    String? session = Zone.current['session'];
    print('Zone values - User: $user, Session: $session');
  });
  
  // Async operations in zones
  Zone asyncZone = Zone.current.fork(
    specification: ZoneSpecification(
      scheduleMicrotask: (Zone self, ZoneDelegate parent, Zone zone, void Function() f) {
        print('Scheduling microtask in custom zone');
        parent.scheduleMicrotask(zone, f);
      },
    ),
  );
  
  asyncZone.run(() {
    Future.microtask(() => print('Microtask in custom zone'));
  });
  
  print('');
}

// 6. Stream Controller Operations
Future<void> streamControllerOperations() async {
  print('6. STREAM CONTROLLER OPERATIONS');
  print('-------------------------------');
  
  // Basic stream controller
  StreamController<int> controller = StreamController<int>();
  
  // Listen to the stream
  StreamSubscription<int> subscription = controller.stream.listen(
    (data) => print('Received: $data'),
    onError: (error) => print('Error: $error'),
    onDone: () => print('Stream closed'),
  );
  
  // Add data to stream
  controller.add(1);
  controller.add(2);
  controller.add(3);
  
  // Add error to stream
  controller.addError('Test error');
  
  // Add more data
  controller.add(4);
  controller.add(5);
  
  // Close the stream
  controller.close();
  
  // Wait for stream to process
  await Future.delayed(Duration(milliseconds: 100));
  
  // Broadcast stream controller
  print('\nBroadcast stream:');
  StreamController<String> broadcastController = StreamController<String>.broadcast();
  
  // Multiple listeners
  broadcastController.stream.listen((data) => print('Listener 1: $data'));
  broadcastController.stream.listen((data) => print('Listener 2: $data'));
  
  broadcastController.add('Broadcast message 1');
  broadcastController.add('Broadcast message 2');
  
  await Future.delayed(Duration(milliseconds: 100));
  broadcastController.close();
  
  // Stream controller with sync option
  print('\nSync stream controller:');
  StreamController<int> syncController = StreamController<int>(sync: true);
  
  syncController.stream.listen((data) => print('Sync data: $data'));
  
  syncController.add(100);
  syncController.add(200);
  syncController.close();
  
  // Stream transformer
  print('\nStream transformer:');
  StreamController<int> transformController = StreamController<int>();
  
  Stream<String> transformedStream = transformController.stream
      .transform(StreamTransformer<int, String>.fromHandlers(
        handleData: (int data, EventSink<String> sink) {
          sink.add('Transformed: ${data * 2}');
        },
        handleError: (Object error, StackTrace stackTrace, EventSink<String> sink) {
          sink.add('Error transformed: $error');
        },
        handleDone: (EventSink<String> sink) {
          sink.add('Transform complete');
          sink.close();
        },
      ));
  
  transformedStream.listen((data) => print(data));
  
  transformController.add(10);
  transformController.add(20);
  transformController.addError('Transform error');
  transformController.add(30);
  transformController.close();
  
  await Future.delayed(Duration(milliseconds: 100));
  print('');
}

// 7. Advanced Async Patterns
Future<void> advancedAsyncPatterns() async {
  print('7. ADVANCED ASYNC PATTERNS');
  print('---------------------------');
  
  // Async generator function
  Stream<int> countStream(int max) async* {
    for (int i = 1; i <= max; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      yield i;
    }
  }
  
  print('Async generator:');
  await for (int count in countStream(3)) {
    print('  Count: $count');
  }
  
  // Recursive async generator
  Stream<int> fibonacciStream(int count) async* {
    int a = 0, b = 1;
    for (int i = 0; i < count; i++) {
      yield a;
      int temp = a + b;
      a = b;
      b = temp;
      await Future.delayed(Duration(milliseconds: 50));
    }
  }
  
  print('Fibonacci stream:');
  await for (int fib in fibonacciStream(5)) {
    print('  Fib: $fib');
  }
  
  // Stream with backpressure handling
  print('Backpressure handling:');
  StreamController<int> backpressureController = StreamController<int>(
    onListen: () => print('  Stream listener attached'),
    onPause: () => print('  Stream paused'),
    onResume: () => print('  Stream resumed'),
    onCancel: () => print('  Stream cancelled'),
  );
  
  StreamSubscription<int> backpressureSubscription = 
      backpressureController.stream.listen((data) {
    print('  Processing: $data');
  });
  
  // Add data
  backpressureController.add(1);
  backpressureController.add(2);
  
  // Pause and resume
  backpressureSubscription.pause();
  backpressureController.add(3); // This will be buffered
  
  await Future.delayed(Duration(milliseconds: 100));
  backpressureSubscription.resume();
  
  await Future.delayed(Duration(milliseconds: 100));
  backpressureController.close();
  
  // Async error handling patterns
  print('\nAsync error handling:');
  
  Future<String> riskyOperation() async {
    await Future.delayed(Duration(milliseconds: 50));
    if (Random().nextBool()) {
      throw Exception('Random failure');
    }
    return 'Success';
  }
  
  // Retry pattern
  Future<String> retryOperation(int maxRetries) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        return await riskyOperation();
      } catch (e) {
        print('  Attempt $attempt failed: $e');
        if (attempt == maxRetries) rethrow;
        await Future.delayed(Duration(milliseconds: 100));
      }
    }
    throw Exception('All retries failed');
  }
  
  try {
    String result = await retryOperation(3);
    print('  Retry result: $result');
  } catch (e) {
    print('  Final error: $e');
  }
  
  // Circuit breaker pattern (simplified)
  print('\nCircuit breaker pattern:');
  
  class SimpleCircuitBreaker {
    int _failureCount = 0;
    final int _threshold = 2;
    bool _isOpen = false;
    DateTime? _lastFailureTime;
    final Duration _timeout = Duration(milliseconds: 200);
    
    Future<T> execute<T>(Future<T> Function() operation) async {
      if (_isOpen) {
        if (_lastFailureTime != null && 
            DateTime.now().difference(_lastFailureTime!) > _timeout) {
          _isOpen = false;
          _failureCount = 0;
          print('  Circuit breaker reset');
        } else {
          throw Exception('Circuit breaker is open');
        }
      }
      
      try {
        T result = await operation();
        _failureCount = 0;
        return result;
      } catch (e) {
        _failureCount++;
        _lastFailureTime = DateTime.now();
        
        if (_failureCount >= _threshold) {
          _isOpen = true;
          print('  Circuit breaker opened');
        }
        
        rethrow;
      }
    }
  }
  
  SimpleCircuitBreaker circuitBreaker = SimpleCircuitBreaker();
  
  for (int i = 1; i <= 5; i++) {
    try {
      String result = await circuitBreaker.execute(() => riskyOperation());
      print('  Circuit breaker result $i: $result');
    } catch (e) {
      print('  Circuit breaker error $i: $e');
    }
    await Future.delayed(Duration(milliseconds: 50));
  }
  
  print('\nAsync patterns completed');
}