// Day 17: Practice Exercise
// Long-running calculation with isolates

import 'dart:isolate';
import 'dart:math';

void main() async {
  print('=== Practice Exercise: Long-running Calculation ===');
  
  await practiceExercise();
  await bonusExercise();
}

/*
PRACTICE EXERCISE:
Create a program that calculates the sum of all prime numbers up to a given limit
using an isolate. The main thread should remain responsive and show progress updates.

Requirements:
1. Calculate primes in an isolate
2. Show progress updates from the isolate
3. Allow the main thread to do other work while calculation runs
4. Compare performance with and without isolates
*/

Future<void> practiceExercise() async {
  print('\n--- Prime Number Calculator ---');
  
  const limit = 100000;
  print('Calculating sum of primes up to $limit...');
  
  // Method 1: Without isolate (blocking)
  await calculatePrimesBlocking(limit);
  
  // Method 2: With isolate (non-blocking)
  await calculatePrimesNonBlocking(limit);
}

// Blocking calculation on main thread
Future<void> calculatePrimesBlocking(int limit) async {
  print('\n--- Blocking Calculation ---');
  
  final stopwatch = Stopwatch()..start();
  
  final result = calculatePrimeSumBlocking(limit);
  
  stopwatch.stop();
  
  print('Blocking result: Sum = ${result['sum']}, Count = ${result['count']}');
  print('Time taken: ${stopwatch.elapsedMilliseconds}ms');
  print('Main thread was blocked during calculation');
}

Map<String, int> calculatePrimeSumBlocking(int limit) {
  int sum = 0;
  int count = 0;
  
  for (int i = 2; i <= limit; i++) {
    if (isPrime(i)) {
      sum += i;
      count++;
    }
  }
  
  return {'sum': sum, 'count': count};
}

// Non-blocking calculation with isolate
Future<void> calculatePrimesNonBlocking(int limit) async {
  print('\n--- Non-blocking Calculation with Progress ---');
  
  final stopwatch = Stopwatch()..start();
  
  // Start the calculation in isolate
  final calculationFuture = calculatePrimeSumWithProgress(limit);
  
  // Main thread can do other work
  final progressFuture = showProgress();
  
  // Wait for calculation to complete
  final result = await calculationFuture;
  
  stopwatch.stop();
  
  print('\nNon-blocking result: Sum = ${result['sum']}, Count = ${result['count']}');
  print('Time taken: ${stopwatch.elapsedMilliseconds}ms');
  print('Main thread remained responsive');
}

Future<Map<String, int>> calculatePrimeSumWithProgress(int limit) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(primeCalculationIsolate, {
    'limit': limit,
    'sendPort': receivePort.sendPort,
  });
  
  Map<String, int>? finalResult;
  
  await for (final message in receivePort) {
    if (message is Map<String, dynamic>) {
      if (message.containsKey('progress')) {
        final progress = message['progress'] as double;
        final current = message['current'] as int;
        print('Progress: ${(progress * 100).toStringAsFixed(1)}% (checking $current)');
      } else if (message.containsKey('sum')) {
        finalResult = {
          'sum': message['sum'] as int,
          'count': message['count'] as int,
        };
        break;
      }
    }
  }
  
  receivePort.close();
  return finalResult!;
}

static void primeCalculationIsolate(Map<String, dynamic> params) {
  final limit = params['limit'] as int;
  final sendPort = params['sendPort'] as SendPort;
  
  int sum = 0;
  int count = 0;
  final progressInterval = limit ~/ 20; // Report progress 20 times
  
  for (int i = 2; i <= limit; i++) {
    if (isPrime(i)) {
      sum += i;
      count++;
    }
    
    // Send progress updates
    if (i % progressInterval == 0) {
      sendPort.send({
        'progress': i / limit,
        'current': i,
      });
    }
  }
  
  // Send final result
  sendPort.send({
    'sum': sum,
    'count': count,
  });
}

// Helper function to check if a number is prime
bool isPrime(int n) {
  if (n < 2) return false;
  if (n == 2) return true;
  if (n % 2 == 0) return false;
  
  for (int i = 3; i <= sqrt(n); i += 2) {
    if (n % i == 0) return false;
  }
  
  return true;
}

// Simulate other work on main thread
Future<void> showProgress() async {
  final messages = [
    'Main thread: Updating UI...',
    'Main thread: Handling user input...',
    'Main thread: Processing events...',
    'Main thread: Refreshing display...',
    'Main thread: Managing state...',
  ];
  
  for (int i = 0; i < 10; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    print(messages[i % messages.length]);
  }
}

// Bonus exercise: Multiple isolates working together
Future<void> bonusExercise() async {
  print('\n--- Bonus: Multiple Isolates ---');
  print('Calculating primes using multiple isolates...');
  
  const limit = 50000;
  const numIsolates = 4;
  
  final stopwatch = Stopwatch()..start();
  
  // Divide work among multiple isolates
  final rangeSize = limit ~/ numIsolates;
  final futures = <Future<Map<String, int>>>[];
  
  for (int i = 0; i < numIsolates; i++) {
    final start = i * rangeSize + (i == 0 ? 2 : i * rangeSize + 1);
    final end = (i == numIsolates - 1) ? limit : (i + 1) * rangeSize;
    
    futures.add(calculatePrimesInRange(start, end, i + 1));
  }
  
  final results = await Future.wait(futures);
  
  // Combine results
  int totalSum = 0;
  int totalCount = 0;
  
  for (int i = 0; i < results.length; i++) {
    totalSum += results[i]['sum']!;
    totalCount += results[i]['count']!;
    print('Isolate ${i + 1}: Sum = ${results[i]['sum']}, Count = ${results[i]['count']}');
  }
  
  stopwatch.stop();
  
  print('\nCombined result: Sum = $totalSum, Count = $totalCount');
  print('Time taken with $numIsolates isolates: ${stopwatch.elapsedMilliseconds}ms');
}

Future<Map<String, int>> calculatePrimesInRange(int start, int end, int isolateId) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(rangeCalculationIsolate, {
    'start': start,
    'end': end,
    'isolateId': isolateId,
    'sendPort': receivePort.sendPort,
  });
  
  return await receivePort.first as Map<String, int>;
}

static void rangeCalculationIsolate(Map<String, dynamic> params) {
  final start = params['start'] as int;
  final end = params['end'] as int;
  final isolateId = params['isolateId'] as int;
  final sendPort = params['sendPort'] as SendPort;
  
  print('Isolate $isolateId: Processing range $start to $end');
  
  int sum = 0;
  int count = 0;
  
  for (int i = start; i <= end; i++) {
    if (isPrime(i)) {
      sum += i;
      count++;
    }
  }
  
  print('Isolate $isolateId: Completed');
  
  sendPort.send({
    'sum': sum,
    'count': count,
  });
}