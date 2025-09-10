// Day 17: Practical Isolate Examples
// Real-world use cases for isolates

import 'dart:isolate';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

void main() async {
  print('=== Practical Isolate Examples ===');
  
  await jsonParsingExample();
  await imageProcessingExample();
  await dataAnalysisExample();
  await encryptionExample();
}

// Example 1: Large JSON parsing
Future<void> jsonParsingExample() async {
  print('\n--- Large JSON Parsing Example ---');
  
  // Generate large JSON data
  final largeData = generateLargeJsonData(10000);
  final jsonString = jsonEncode(largeData);
  
  print('JSON size: ${jsonString.length} characters');
  
  final stopwatch = Stopwatch()..start();
  
  // Parse in isolate to avoid blocking UI
  final parsedData = await parseJsonInIsolate(jsonString);
  
  stopwatch.stop();
  
  print('Parsed ${parsedData.length} items');
  print('Parsing time: ${stopwatch.elapsedMilliseconds}ms');
  print('Main thread remained responsive');
}

Map<String, dynamic> generateLargeJsonData(int itemCount) {
  final random = Random();
  final items = <Map<String, dynamic>>[];
  
  for (int i = 0; i < itemCount; i++) {
    items.add({
      'id': i,
      'name': 'Item $i',
      'value': random.nextDouble() * 1000,
      'category': 'Category ${random.nextInt(10)}',
      'tags': List.generate(5, (j) => 'tag${random.nextInt(100)}'),
      'metadata': {
        'created': DateTime.now().millisecondsSinceEpoch,
        'updated': DateTime.now().millisecondsSinceEpoch,
        'version': random.nextInt(10),
      }
    });
  }
  
  return {'items': items, 'total': itemCount};
}

Future<List<dynamic>> parseJsonInIsolate(String jsonString) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(jsonParsingIsolate, {
    'jsonString': jsonString,
    'sendPort': receivePort.sendPort,
  });
  
  final result = await receivePort.first as Map<String, dynamic>;
  return result['items'] as List<dynamic>;
}

static void jsonParsingIsolate(Map<String, dynamic> params) {
  final jsonString = params['jsonString'] as String;
  final sendPort = params['sendPort'] as SendPort;
  
  try {
    final parsed = jsonDecode(jsonString) as Map<String, dynamic>;
    sendPort.send(parsed);
  } catch (e) {
    sendPort.send({'error': e.toString()});
  }
}

// Example 2: Image processing simulation
Future<void> imageProcessingExample() async {
  print('\n--- Image Processing Example ---');
  
  // Simulate image data
  final imageData = generateImageData(1000, 1000);
  print('Processing ${imageData.length} pixels');
  
  final stopwatch = Stopwatch()..start();
  
  final processedImage = await processImageInIsolate(imageData);
  
  stopwatch.stop();
  
  print('Image processed: ${processedImage.length} pixels');
  print('Processing time: ${stopwatch.elapsedMilliseconds}ms');
}

Uint8List generateImageData(int width, int height) {
  final random = Random();
  final data = Uint8List(width * height * 4); // RGBA
  
  for (int i = 0; i < data.length; i++) {
    data[i] = random.nextInt(256);
  }
  
  return data;
}

Future<Uint8List> processImageInIsolate(Uint8List imageData) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(imageProcessingIsolate, {
    'imageData': imageData,
    'sendPort': receivePort.sendPort,
  });
  
  return await receivePort.first as Uint8List;
}

static void imageProcessingIsolate(Map<String, dynamic> params) {
  final imageData = params['imageData'] as Uint8List;
  final sendPort = params['sendPort'] as SendPort;
  
  // Apply a simple filter (brightness adjustment)
  final processed = Uint8List(imageData.length);
  
  for (int i = 0; i < imageData.length; i += 4) {
    // Increase brightness by 20%
    processed[i] = (imageData[i] * 1.2).clamp(0, 255).toInt();     // R
    processed[i + 1] = (imageData[i + 1] * 1.2).clamp(0, 255).toInt(); // G
    processed[i + 2] = (imageData[i + 2] * 1.2).clamp(0, 255).toInt(); // B
    processed[i + 3] = imageData[i + 3]; // A (alpha)
  }
  
  sendPort.send(processed);
}

// Example 3: Data analysis
Future<void> dataAnalysisExample() async {
  print('\n--- Data Analysis Example ---');
  
  // Generate sample data
  final data = generateSampleData(100000);
  print('Analyzing ${data.length} data points');
  
  final stopwatch = Stopwatch()..start();
  
  final analysis = await analyzeDataInIsolate(data);
  
  stopwatch.stop();
  
  print('Analysis results:');
  print('  Mean: ${analysis['mean']?.toStringAsFixed(2)}');
  print('  Median: ${analysis['median']?.toStringAsFixed(2)}');
  print('  Standard Deviation: ${analysis['stdDev']?.toStringAsFixed(2)}');
  print('  Min: ${analysis['min']}');
  print('  Max: ${analysis['max']}');
  print('Analysis time: ${stopwatch.elapsedMilliseconds}ms');
}

List<double> generateSampleData(int count) {
  final random = Random();
  return List.generate(count, (i) => random.nextGaussian() * 100 + 50);
}

extension RandomGaussian on Random {
  double nextGaussian() {
    double u1 = nextDouble();
    double u2 = nextDouble();
    return sqrt(-2 * log(u1)) * cos(2 * pi * u2);
  }
}

Future<Map<String, double>> analyzeDataInIsolate(List<double> data) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(dataAnalysisIsolate, {
    'data': data,
    'sendPort': receivePort.sendPort,
  });
  
  return await receivePort.first as Map<String, double>;
}

static void dataAnalysisIsolate(Map<String, dynamic> params) {
  final data = params['data'] as List<double>;
  final sendPort = params['sendPort'] as SendPort;
  
  // Calculate statistics
  data.sort();
  
  final mean = data.reduce((a, b) => a + b) / data.length;
  final median = data.length % 2 == 0
      ? (data[data.length ~/ 2 - 1] + data[data.length ~/ 2]) / 2
      : data[data.length ~/ 2];
  
  final variance = data
      .map((x) => pow(x - mean, 2))
      .reduce((a, b) => a + b) / data.length;
  final stdDev = sqrt(variance);
  
  final min = data.first;
  final max = data.last;
  
  sendPort.send({
    'mean': mean,
    'median': median,
    'stdDev': stdDev,
    'min': min,
    'max': max,
  });
}

// Example 4: Encryption/Decryption
Future<void> encryptionExample() async {
  print('\n--- Encryption Example ---');
  
  final plaintext = 'This is a secret message that needs to be encrypted!';
  final key = 'mySecretKey123';
  
  print('Original: $plaintext');
  
  // Encrypt in isolate
  final encrypted = await encryptInIsolate(plaintext, key);
  print('Encrypted: $encrypted');
  
  // Decrypt in isolate
  final decrypted = await decryptInIsolate(encrypted, key);
  print('Decrypted: $decrypted');
}

Future<String> encryptInIsolate(String plaintext, String key) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(encryptionIsolate, {
    'operation': 'encrypt',
    'text': plaintext,
    'key': key,
    'sendPort': receivePort.sendPort,
  });
  
  return await receivePort.first as String;
}

Future<String> decryptInIsolate(String ciphertext, String key) async {
  final receivePort = ReceivePort();
  
  await Isolate.spawn(encryptionIsolate, {
    'operation': 'decrypt',
    'text': ciphertext,
    'key': key,
    'sendPort': receivePort.sendPort,
  });
  
  return await receivePort.first as String;
}

static void encryptionIsolate(Map<String, dynamic> params) {
  final operation = params['operation'] as String;
  final text = params['text'] as String;
  final key = params['key'] as String;
  final sendPort = params['sendPort'] as SendPort;
  
  String result;
  
  if (operation == 'encrypt') {
    result = simpleEncrypt(text, key);
  } else {
    result = simpleDecrypt(text, key);
  }
  
  sendPort.send(result);
}

// Simple XOR encryption (for demonstration only)
String simpleEncrypt(String plaintext, String key) {
  final encrypted = <int>[];
  
  for (int i = 0; i < plaintext.length; i++) {
    final keyChar = key[i % key.length].codeUnitAt(0);
    final textChar = plaintext[i].codeUnitAt(0);
    encrypted.add(textChar ^ keyChar);
  }
  
  return base64Encode(encrypted);
}

String simpleDecrypt(String ciphertext, String key) {
  final encrypted = base64Decode(ciphertext);
  final decrypted = <int>[];
  
  for (int i = 0; i < encrypted.length; i++) {
    final keyChar = key[i % key.length].codeUnitAt(0);
    decrypted.add(encrypted[i] ^ keyChar);
  }
  
  return String.fromCharCodes(decrypted);
}