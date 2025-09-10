// Day 17: Isolates Overview
// Understanding Dart's concurrency model with Isolates

/*
ISOLATES IN DART - OVERVIEW

What are Isolates?
- Isolates are independent workers that run in parallel to the main thread
- Each isolate has its own memory heap and cannot directly share objects
- Communication happens through message passing (ports)
- True concurrency vs asynchronous operations

Key Concepts:
1. Main Isolate: Where your app's UI and main logic runs
2. Spawn Isolate: Create new isolates for heavy computations
3. Ports: Communication channels between isolates
4. Message Passing: How data is shared between isolates

When to use Isolates:
✅ CPU-intensive calculations (mathematical operations, data processing)
✅ Large data parsing (JSON, XML)
✅ Image/video processing
✅ Cryptographic operations
❌ Simple async operations (use Future/async-await instead)
❌ File I/O operations (already non-blocking)
❌ Network requests (already non-blocking)

Isolate vs Async/Await:
- Async/Await: Single-threaded concurrency (cooperative multitasking)
- Isolates: Multi-threaded concurrency (true parallelism)
*/

import 'dart:isolate';
import 'dart:math';

void main() {
  print('=== Isolates Overview ===');
  print('Main isolate started');
  
  // This will demonstrate the difference between blocking and non-blocking operations
  demonstrateBlockingVsNonBlocking();
}

void demonstrateBlockingVsNonBlocking() async {
  print('\n--- Blocking vs Non-blocking Demo ---');
  
  // This blocks the main thread
  print('Starting blocking operation...');
  var start = DateTime.now();
  var result = heavyCalculation(1000000);
  var end = DateTime.now();
  print('Blocking result: $result');
  print('Time taken: ${end.difference(start).inMilliseconds}ms');
  
  // This doesn't block the main thread
  print('\nStarting non-blocking operation with isolate...');
  start = DateTime.now();
  var isolateResult = await runInIsolate();
  end = DateTime.now();
  print('Isolate result: $isolateResult');
  print('Time taken: ${end.difference(start).inMilliseconds}ms');
  print('Main thread was free during isolate execution!');
}

// Heavy calculation that blocks the thread
int heavyCalculation(int iterations) {
  var sum = 0;
  for (int i = 0; i < iterations; i++) {
    sum += sqrt(i).round();
  }
  return sum;
}

// Function to run heavy calculation in isolate
Future<int> runInIsolate() async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(isolateEntryPoint, receivePort.sendPort);
  
  final result = await receivePort.first as int;
  return result;
}

// Entry point for the isolate
static void isolateEntryPoint(SendPort sendPort) {
  final result = heavyCalculation(1000000);
  sendPort.send(result);
}