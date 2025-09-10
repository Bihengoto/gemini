// Day 13: Asynchronous Programming - Streams
// File 1: Introduction to Streams

/*
STREAMS IN DART - INTRODUCTION

What are Streams?
- A Stream is a sequence of asynchronous data events
- Think of it as a pipe where data flows through over time
- Unlike Future (single value), Stream can emit multiple values
- Perfect for handling continuous data like user input, network responses, file I/O

Key Concepts:
1. Stream: The source of asynchronous data
2. StreamSubscription: Controls listening to the stream
3. StreamController: Creates and controls custom streams
4. Sink: The input side of a stream

Types of Streams:
1. Single-subscription streams (default)
2. Broadcast streams (multiple listeners)

Stream States:
- Data events: Normal data flowing through
- Error events: When something goes wrong
- Done event: When stream is closed/completed
*/

import 'dart:async';

void main() {
  print('=== Streams Introduction ===\n');

  // Example 1: Simple stream from a list
  demonstrateBasicStream();

  // Example 2: Stream from periodic timer
  demonstratePeriodicStream();
}

void demonstrateBasicStream() {
  print('1. Basic Stream from List:');

  // Create a stream from a list
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  // Listen to the stream
  numberStream.listen(
    (data) => print('Received: $data'),
    onError: (error) => print('Error: $error'),
    onDone: () => print('Stream completed!\n'),
  );
}

void demonstratePeriodicStream() {
  print('2. Periodic Stream:');

  // Create a stream that emits data every second
  Stream<int> periodicStream = Stream.periodic(
    Duration(seconds: 1),
    (count) => count + 1,
  ).take(5); // Only take first 5 values

  periodicStream.listen(
    (data) => print('Timer tick: $data'),
    onDone: () => print('Periodic stream completed!\n'),
  );
}
