// Day 17: Using compute() Function
// Flutter's simplified isolate API

import 'dart:isolate';
import 'dart:math';

// Note: In a real Flutter app, you would import:
// import 'package:flutter/foundation.dart';
// and use the compute() function directly

void main() async {
  print('=== Compute Function Examples ===');
  
  await manualComputeExample();
  await multipleComputeExample();
}

// Manual implementation of compute-like functionality
Future<R> compute<Q, R>(R Function(Q) callback, Q message) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(_isolateEntryPoint, {
    'callback': callback,
    'message': message,
    'sendPort': receivePort.sendPort,
  });
  
  return await receivePort.first as R;
}

static void _isolateEntryPoint<Q, R>(Map<String, dynamic> params) {
  final callback = params['callback'] as R Function(Q);
  final message = params['message'] as Q;
  final sendPort = params['sendPort'] as SendPort;
  
  try {
    final result = callback(message);
    sendPort.send(result);
  } catch (e) {
    sendPort.send(e);
  }
}

// Example using manual compute implementation
Future<void> manualComputeExample() async {
  print('\n--- Manual Compute Example ---');
  
  // Simple calculation
  final result1 = await compute(calculateFactorial, 10);
  print('Factorial of 10: $result1');
  
  // Complex calculation
  final result2 = await compute(calculatePrimes, 1000);
  print('Number of primes up to 1000: ${result2.length}');
  
  // Data processing
  final data = List.generate(1000, (i) => i + 1);
  final result3 = await compute(processNumbers, data);
  print('Sum of squares: $result3');
}

// Functions to run in isolates
int calculateFactorial(int n) {
  if (n <= 1) return 1;
  int result = 1;
  for (int i = 2; i <= n; i++) {
    result *= i;
  }
  return result;
}

List<int> calculatePrimes(int limit) {
  List<int> primes = [];
  
  for (int i = 2; i <= limit; i++) {
    bool isPrime = true;
    for (int j = 2; j <= sqrt(i); j++) {
      if (i % j == 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) {
      primes.add(i);
    }
  }
  
  return primes;
}

int processNumbers(List<int> numbers) {
  return numbers.map((n) => n * n).reduce((a, b) => a + b);
}

// Multiple compute operations
Future<void> multipleComputeExample() async {
  print('\n--- Multiple Compute Operations ---');
  
  final stopwatch = Stopwatch()..start();
  
  // Run multiple heavy computations in parallel
  final futures = [
    compute(heavyMathOperation, {'iterations': 100000, 'multiplier': 1}),
    compute(heavyMathOperation, {'iterations': 100000, 'multiplier': 2}),
    compute(heavyMathOperation, {'iterations': 100000, 'multiplier': 3}),
    compute(heavyMathOperation, {'iterations': 100000, 'multiplier': 4}),
  ];
  
  final results = await Future.wait(futures);
  stopwatch.stop();
  
  print('Results: $results');
  print('Total time: ${stopwatch.elapsedMilliseconds}ms');
  print('All computations ran in parallel');
}

double heavyMathOperation(Map<String, int> params) {
  final iterations = params['iterations']!;
  final multiplier = params['multiplier']!;
  
  double sum = 0;
  for (int i = 0; i < iterations; i++) {
    sum += sqrt(i * multiplier) + sin(i * 0.001);
  }
  
  return sum;
}

// Example of error handling with compute
Future<void> computeWithErrorHandling() async {
  print('\n--- Compute with Error Handling ---');
  
  try {
    final result = await compute(riskyOperation, -5);
    print('Result: $result');
  } catch (e) {
    print('Error caught: $e');
  }
}

int riskyOperation(int value) {
  if (value < 0) {
    throw ArgumentError('Value must be positive');
  }
  return value * value;
}