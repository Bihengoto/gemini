// Day 17: Bidirectional Communication with Isolates
// Advanced isolate communication patterns

import 'dart:isolate';
import 'dart:math';

void main() async {
  print('=== Bidirectional Communication ===');
  
  await simpleBidirectionalExample();
  await longRunningIsolateExample();
}

// Simple bidirectional communication
Future<void> simpleBidirectionalExample() async {
  print('\n--- Simple Bidirectional Communication ---');
  
  final mainReceivePort = ReceivePort();
  final isolate = await Isolate.spawn(
    bidirectionalIsolate,
    mainReceivePort.sendPort,
  );
  
  SendPort? isolateSendPort;
  
  // Listen for messages from isolate
  mainReceivePort.listen((message) {
    if (message is SendPort) {
      // First message is the isolate's SendPort
      isolateSendPort = message;
      print('Received isolate SendPort');
      
      // Send a message to the isolate
      isolateSendPort!.send('Hello from main!');
    } else {
      // Regular message from isolate
      print('Main received: $message');
      
      // Send response back
      isolateSendPort!.send('Thanks for the message!');
    }
  });
  
  // Wait for communication to complete
  await Future.delayed(Duration(seconds: 2));
  
  // Clean up
  isolate.kill();
  mainReceivePort.close();
}

static void bidirectionalIsolate(SendPort mainSendPort) {
  final isolateReceivePort = ReceivePort();
  
  // Send our SendPort to main isolate
  mainSendPort.send(isolateReceivePort.sendPort);
  
  // Listen for messages from main
  isolateReceivePort.listen((message) {
    print('Isolate received: $message');
    
    // Send response back to main
    mainSendPort.send('Isolate processed: $message');
  });
}

// Long-running isolate with continuous communication
Future<void> longRunningIsolateExample() async {
  print('\n--- Long-running Isolate Example ---');
  
  final controller = IsolateController();
  await controller.start();
  
  // Send multiple tasks
  for (int i = 1; i <= 5; i++) {
    await controller.sendTask('Calculate square of $i', i);
    await Future.delayed(Duration(milliseconds: 500));
  }
  
  // Send shutdown command
  await controller.shutdown();
}

class IsolateController {
  Isolate? _isolate;
  ReceivePort? _receivePort;
  SendPort? _sendPort;
  
  Future<void> start() async {
    _receivePort = ReceivePort();
    
    _isolate = await Isolate.spawn(
      workerIsolate,
      _receivePort!.sendPort,
    );
    
    // Wait for isolate to send its SendPort
    _sendPort = await _receivePort!.first as SendPort;
    print('Worker isolate started');
    
    // Listen for results
    _receivePort!.listen((message) {
      if (message is Map) {
        print('Result: ${message['task']} = ${message['result']}');
      }
    });
  }
  
  Future<void> sendTask(String taskName, int number) async {
    if (_sendPort != null) {
      _sendPort!.send({
        'command': 'calculate',
        'task': taskName,
        'number': number,
      });
    }
  }
  
  Future<void> shutdown() async {
    if (_sendPort != null) {
      _sendPort!.send({'command': 'shutdown'});
    }
    
    await Future.delayed(Duration(milliseconds: 100));
    
    _isolate?.kill();
    _receivePort?.close();
    print('Worker isolate shut down');
  }
}

static void workerIsolate(SendPort mainSendPort) {
  final receivePort = ReceivePort();
  
  // Send our SendPort to main
  mainSendPort.send(receivePort.sendPort);
  
  print('Worker isolate ready');
  
  // Listen for commands
  receivePort.listen((message) {
    if (message is Map) {
      final command = message['command'] as String;
      
      switch (command) {
        case 'calculate':
          final task = message['task'] as String;
          final number = message['number'] as int;
          
          // Simulate some work
          final result = number * number;
          
          // Send result back
          mainSendPort.send({
            'task': task,
            'result': result,
          });
          break;
          
        case 'shutdown':
          print('Worker isolate shutting down');
          receivePort.close();
          break;
      }
    }
  });
}