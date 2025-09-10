// Day 17: Basic Isolate Example
// Simple isolate creation and communication

import 'dart:isolate';
import 'dart:math';

void main() async {
  print('=== Basic Isolate Example ===');
  print('Main isolate: ${Isolate.current.debugName}');
  
  await basicIsolateExample();
  await isolateWithParameters();
}

// Basic isolate creation and communication
Future<void> basicIsolateExample() async {
  print('\n--- Basic Isolate Communication ---');
  
  // Create a ReceivePort to get messages from the isolate
  final receivePort = ReceivePort();
  
  // Spawn a new isolate
  final isolate = await Isolate.spawn(
    simpleIsolateFunction,
    receivePort.sendPort,
  );
  
  // Listen for messages from the isolate
  receivePort.listen((message) {
    print('Received from isolate: $message');
    
    // Clean up
    receivePort.close();
    isolate.kill();
  });
  
  // Wait a bit to see the result
  await Future.delayed(Duration(seconds: 1));
}

// Simple isolate function
static void simpleIsolateFunction(SendPort sendPort) {
  print('Inside isolate: ${Isolate.current.debugName}');
  
  // Do some work
  final result = 'Hello from isolate! Current time: ${DateTime.now()}';
  
  // Send result back to main isolate
  sendPort.send(result);
}

// Isolate with parameters
Future<void> isolateWithParameters() async {
  print('\n--- Isolate with Parameters ---');
  
  final receivePort = ReceivePort();
  
  // Create a data structure to pass multiple parameters
  final params = IsolateParams(
    sendPort: receivePort.sendPort,
    number: 42,
    message: 'Calculate factorial',
  );
  
  await Isolate.spawn(parameterizedIsolateFunction, params);
  
  final result = await receivePort.first;
  print('Factorial result: $result');
}

// Data class for passing parameters to isolate
class IsolateParams {
  final SendPort sendPort;
  final int number;
  final String message;
  
  IsolateParams({
    required this.sendPort,
    required this.number,
    required this.message,
  });
}

// Isolate function that accepts parameters
static void parameterizedIsolateFunction(IsolateParams params) {
  print('Isolate received: ${params.message}');
  print('Calculating factorial of ${params.number}');
  
  // Calculate factorial
  int factorial = 1;
  for (int i = 1; i <= params.number; i++) {
    factorial *= i;
  }
  
  // Send result back
  params.sendPort.send('Factorial of ${params.number} is $factorial');
}