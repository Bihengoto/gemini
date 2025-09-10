// Day 17: Async vs Isolates Comparison
// Understanding when to use async/await vs isolates

import 'dart:isolate';
import 'dart:io';
import 'dart:math';

void main() async {
  print('=== Async vs Isolates Comparison ===');
  
  await demonstrateAsyncOperations();
  await demonstrateIsolateOperations();
  await comparePerformance();
}

// Demonstrate async operations (single-threaded concurrency)
Future<void> demonstrateAsyncOperations() async {
  print('\n--- Async Operations (Single-threaded) ---');
  
  final stopwatch = Stopwatch()..start();
  
  // These run concurrently but on the same thread
  final futures = [
    simulateNetworkCall('API 1'),
    simulateNetworkCall('API 2'),
    simulateNetworkCall('API 3'),
  ];
  
  final results = await Future.wait(futures);
  stopwatch.stop();
  
  print('Async results: $results');
  print('Total time: ${stopwatch.elapsedMilliseconds}ms');
  print('All operations ran concurrently on the main thread');
}

// Simulate network call (I/O operation)
Future<String> simulateNetworkCall(String apiName) async {
  print('Starting $apiName request...');
  await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
  return '$apiName response';
}

// Demonstrate isolate operations (multi-threaded concurrency)
Future<void> demonstrateIsolateOperations() async {
  print('\n--- Isolate Operations (Multi-threaded) ---');
  
  final stopwatch = Stopwatch()..start();
  
  // These run in parallel on different threads
  final futures = [
    runCpuIntensiveTask('Task 1', 100000),
    runCpuIntensiveTask('Task 2', 100000),
    runCpuIntensiveTask('Task 3', 100000),
  ];
  
  final results = await Future.wait(futures);
  stopwatch.stop();
  
  print('Isolate results: $results');
  print('Total time: ${stopwatch.elapsedMilliseconds}ms');
  print('All operations ran in parallel on separate threads');
}

// Run CPU-intensive task in isolate
Future<String> runCpuIntensiveTask(String taskName, int iterations) async {
  final receivePort = ReceivePort();
  
  final params = TaskParams(
    sendPort: receivePort.sendPort,
    taskName: taskName,
    iterations: iterations,
  );
  
  await Isolate.spawn(cpuIntensiveIsolate, params);
  
  final result = await receivePort.first as String;
  return result;
}

class TaskParams {
  final SendPort sendPort;
  final String taskName;
  final int iterations;
  
  TaskParams({
    required this.sendPort,
    required this.taskName,
    required this.iterations,
  });
}

static void cpuIntensiveIsolate(TaskParams params) {
  print('${params.taskName} started in isolate');
  
  // CPU-intensive calculation
  double sum = 0;
  for (int i = 0; i < params.iterations; i++) {
    sum += sqrt(i * i + 1);
  }
  
  final result = '${params.taskName} completed: ${sum.toStringAsFixed(2)}';
  params.sendPort.send(result);
}

// Compare performance between blocking and non-blocking approaches
Future<void> comparePerformance() async {
  print('\n--- Performance Comparison ---');
  
  // Blocking approach (main thread)
  print('Testing blocking approach...');
  final stopwatch1 = Stopwatch()..start();
  
  final blockingResult = performHeavyCalculation(500000);
  
  stopwatch1.stop();
  print('Blocking result: $blockingResult');
  print('Blocking time: ${stopwatch1.elapsedMilliseconds}ms');
  print('Main thread was blocked during calculation');
  
  // Non-blocking approach (isolate)
  print('\nTesting non-blocking approach...');
  final stopwatch2 = Stopwatch()..start();
  
  // Start the isolate
  final isolateFuture = runCalculationInIsolate(500000);
  
  // Main thread can do other work
  for (int i = 0; i < 5; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    print('Main thread doing other work... $i');
  }
  
  final isolateResult = await isolateFuture;
  stopwatch2.stop();
  
  print('Isolate result: $isolateResult');
  print('Total time: ${stopwatch2.elapsedMilliseconds}ms');
  print('Main thread was free during calculation');
}

// Heavy calculation on main thread
double performHeavyCalculation(int iterations) {
  double result = 0;
  for (int i = 0; i < iterations; i++) {
    result += sqrt(pow(i, 2) + pow(i + 1, 2));
  }
  return result;
}

// Heavy calculation in isolate
Future<double> runCalculationInIsolate(int iterations) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(heavyCalculationIsolate, {
    'sendPort': receivePort.sendPort,
    'iterations': iterations,
  });
  
  return await receivePort.first as double;
}

static void heavyCalculationIsolate(Map<String, dynamic> params) {
  final sendPort = params['sendPort'] as SendPort;
  final iterations = params['iterations'] as int;
  
  double result = 0;
  for (int i = 0; i < iterations; i++) {
    result += sqrt(pow(i, 2) + pow(i + 1, 2));
  }
  
  sendPort.send(result);
}