// Day 13: Asynchronous Programming - Streams
// File 7: Advanced Stream Examples

/*
ADVANCED STREAM EXAMPLES

This file contains more complex stream scenarios:
1. Stream transformers and custom transformations
2. Combining multiple streams
3. Stream with backpressure handling
4. Real-world simulation examples
*/

import 'dart:async';
import 'dart:convert';
import 'dart:math';

void main() async {
  print('=== Advanced Stream Examples ===\n');

  await demonstrateStreamTransformer();
  await demonstrateCombiningStreams();
  await demonstrateBackpressureHandling();
  await demonstrateRealWorldSimulation();
}

// Example 1: Custom Stream Transformer
Future<void> demonstrateStreamTransformer() async {
  print('1. Custom Stream Transformer:');

  Stream<int> numberStream = Stream.fromIterable([
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
  ]);

  // Create a custom transformer that processes numbers in batches
  StreamTransformer<int, List<int>> batchTransformer =
      StreamTransformer.fromHandlers(
        handleData: (int data, EventSink<List<int>> sink) {
          // This is a simple example - in real scenarios, you'd accumulate data
          sink.add([data, data * 2, data * 3]);
        },
      );

  Stream<List<int>> batchedStream = numberStream.transform(batchTransformer);

  await for (List<int> batch in batchedStream) {
    print('Batch: $batch');
  }
  print();
}

// Example 2: Combining Multiple Streams
Future<void> demonstrateCombiningStreams() async {
  print('2. Combining Multiple Streams:');

  // Create multiple streams
  Stream<String> stream1 = Stream.periodic(
    Duration(milliseconds: 1000),
    (i) => 'Stream1-${i + 1}',
  ).take(5);

  Stream<String> stream2 = Stream.periodic(
    Duration(milliseconds: 1500),
    (i) => 'Stream2-${i + 1}',
  ).take(3);

  Stream<String> stream3 = Stream.periodic(
    Duration(milliseconds: 800),
    (i) => 'Stream3-${i + 1}',
  ).take(4);

  // Merge streams - events arrive as they're emitted
  Stream<String> mergedStream = StreamGroup.merge([stream1, stream2, stream3]);

  await for (String data in mergedStream) {
    print('Merged: $data');
  }
  print();
}

// Example 3: Backpressure Handling
Future<void> demonstrateBackpressureHandling() async {
  print('3. Backpressure Handling:');

  StreamController<int> fastProducer = StreamController<int>();

  // Fast producer - adds data every 100ms
  Timer.periodic(Duration(milliseconds: 100), (timer) {
    if (timer.tick <= 20) {
      fastProducer.add(timer.tick);
    } else {
      timer.cancel();
      fastProducer.close();
    }
  });

  // Slow consumer with buffer
  Stream<int> bufferedStream = fastProducer.stream
      .where((data) => data % 3 == 0) // Filter some data
      .take(5); // Limit to prevent infinite processing

  await for (int data in bufferedStream) {
    print('Processing (slow): $data');
    // Simulate slow processing
    await Future.delayed(Duration(milliseconds: 500));
  }
  print();
}

// Example 4: Real-world Simulation - Stock Price Stream
Future<void> demonstrateRealWorldSimulation() async {
  print('4. Real-world Simulation - Stock Price Monitor:');

  StockPriceMonitor monitor = StockPriceMonitor();

  // Subscribe to stock updates
  StreamSubscription subscription = monitor.priceStream.listen((stockData) {
    print(
      '${stockData['symbol']}: \$${stockData['price'].toStringAsFixed(2)} '
      '(${stockData['change'] > 0 ? '+' : ''}${stockData['change'].toStringAsFixed(2)})',
    );
  }, onDone: () => print('Market closed'));

  // Start monitoring
  monitor.startMonitoring(['AAPL', 'GOOGL', 'MSFT']);

  // Stop after 8 seconds
  Timer(Duration(seconds: 8), () {
    monitor.stopMonitoring();
  });

  await subscription.asFuture();
  print();
}

// Custom Stream Group implementation for merging streams
class StreamGroup<T> {
  static Stream<T> merge<T>(List<Stream<T>> streams) {
    StreamController<T> controller = StreamController<T>();
    List<StreamSubscription> subscriptions = [];
    int activeStreams = streams.length;

    for (Stream<T> stream in streams) {
      StreamSubscription subscription = stream.listen(
        (data) => controller.add(data),
        onError: (error) => controller.addError(error),
        onDone: () {
          activeStreams--;
          if (activeStreams == 0) {
            controller.close();
          }
        },
      );
      subscriptions.add(subscription);
    }

    return controller.stream;
  }
}

// Real-world example: Stock Price Monitor
class StockPriceMonitor {
  StreamController<Map<String, dynamic>>? _controller;
  Timer? _timer;
  Random _random = Random();
  List<String> _symbols = [];
  Map<String, double> _lastPrices = {};

  Stream<Map<String, dynamic>> get priceStream => _controller!.stream;

  void startMonitoring(List<String> symbols) {
    _symbols = symbols;
    _controller = StreamController<Map<String, dynamic>>();

    // Initialize prices
    for (String symbol in symbols) {
      _lastPrices[symbol] = 100.0 + _random.nextDouble() * 50;
    }

    // Update prices every 800ms
    _timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      if (!_controller!.isClosed) {
        _updateRandomPrice();
      }
    });
  }

  void stopMonitoring() {
    _timer?.cancel();
    _controller?.close();
  }

  void _updateRandomPrice() {
    if (_symbols.isEmpty) return;

    String symbol = _symbols[_random.nextInt(_symbols.length)];
    double lastPrice = _lastPrices[symbol]!;

    // Generate price change (-5% to +5%)
    double changePercent = (_random.nextDouble() - 0.5) * 0.1;
    double newPrice = lastPrice * (1 + changePercent);
    double change = newPrice - lastPrice;

    _lastPrices[symbol] = newPrice;

    _controller!.add({
      'symbol': symbol,
      'price': newPrice,
      'change': change,
      'timestamp': DateTime.now(),
    });
  }
}

// Bonus: Stream with custom error recovery
Stream<int> createResilientStream() async* {
  int count = 0;

  while (count < 10) {
    try {
      count++;

      // Simulate random errors
      if (Random().nextDouble() < 0.3) {
        throw Exception('Random error at count $count');
      }

      yield count;
      await Future.delayed(Duration(milliseconds: 500));
    } catch (error) {
      // Log error but continue
      print('Error caught and recovered: $error');
      await Future.delayed(Duration(milliseconds: 200));
    }
  }
}
