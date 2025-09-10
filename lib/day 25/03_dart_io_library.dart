// Day 25: Exploring dart:io Library
// The dart:io library provides I/O operations for files, directories, processes, and more

import 'dart:io';
import 'dart:convert';

void main() async {
  print('=== DART:IO LIBRARY EXPLORATION ===\n');

  // File operations
  await fileOperations();

  // Directory operations
  await directoryOperations();

  // Process operations
  await processOperations();

  // HTTP client operations
  await httpClientOperations();

  // Platform information
  platformInformation();

  // Environment variables
  environmentVariables();

  // Standard I/O
  await standardIOOperations();
}

// 1. File Operations
Future<void> fileOperations() async {
  print('1. FILE OPERATIONS');
  print('------------------');

  try {
    // Create a test file
    File testFile = File('test_file.txt');

    // Write to file
    await testFile.writeAsString('Hello, Dart I/O!\nThis is a test file.\n');
    print('File created and written to: ${testFile.path}');

    // Check if file exists
    bool exists = await testFile.exists();
    print('File exists: $exists');

    // Read file content
    String content = await testFile.readAsString();
    print('File content:\n$content');

    // Read as lines
    List<String> lines = await testFile.readAsLines();
    print('File lines: $lines');

    // Append to file
    await testFile.writeAsString('Appended line.\n', mode: FileMode.append);
    print('Content appended to file');

    // Read updated content
    String updatedContent = await testFile.readAsString();
    print('Updated content:\n$updatedContent');

    // File properties
    FileStat stat = await testFile.stat();
    print('File size: ${stat.size} bytes');
    print('Modified: ${stat.modified}');
    print('File type: ${stat.type}');

    // Copy file
    File copiedFile = await testFile.copy('copied_file.txt');
    print('File copied to: ${copiedFile.path}');

    // Rename file
    File renamedFile = await testFile.rename('renamed_file.txt');
    print('File renamed to: ${renamedFile.path}');

    // Working with bytes
    List<int> bytes = utf8.encode('Binary data example');
    await File('binary_file.bin').writeAsBytes(bytes);
    List<int> readBytes = await File('binary_file.bin').readAsBytes();
    String decodedString = utf8.decode(readBytes);
    print('Binary file content: $decodedString');

    // Stream operations
    print('\nReading file as stream:');
    Stream<List<int>> stream = File('renamed_file.txt').openRead();
    await for (List<int> chunk in stream) {
      String chunkString = utf8.decode(chunk);
      print('Chunk: ${chunkString.trim()}');
    }

    // Clean up test files
    await File('copied_file.txt').delete();
    await File('renamed_file.txt').delete();
    await File('binary_file.bin').delete();
    print('Test files cleaned up');
  } catch (e) {
    print('File operation error: $e');
  }
  print('');
}

// 2. Directory Operations
Future<void> directoryOperations() async {
  print('2. DIRECTORY OPERATIONS');
  print('-----------------------');

  try {
    // Create directory
    Directory testDir = Directory('test_directory');
    await testDir.create();
    print('Directory created: ${testDir.path}');

    // Check if directory exists
    bool exists = await testDir.exists();
    print('Directory exists: $exists');

    // Create nested directories
    Directory nestedDir = Directory('test_directory/nested/deep');
    await nestedDir.create(recursive: true);
    print('Nested directory created: ${nestedDir.path}');

    // Create some test files in directory
    await File('test_directory/file1.txt').writeAsString('File 1 content');
    await File('test_directory/file2.txt').writeAsString('File 2 content');
    await File(
      'test_directory/nested/file3.txt',
    ).writeAsString('File 3 content');

    // List directory contents
    print('\nDirectory contents:');
    await for (FileSystemEntity entity in testDir.list()) {
      print('  ${entity.path} (${entity is File ? 'File' : 'Directory'})');
    }

    // List recursively
    print('\nRecursive directory listing:');
    await for (FileSystemEntity entity in testDir.list(recursive: true)) {
      String type = entity is File ? 'File' : 'Directory';
      print('  ${entity.path} ($type)');
    }

    // Get current directory
    Directory currentDir = Directory.current;
    print('\nCurrent directory: ${currentDir.path}');

    // Get system temp directory
    Directory tempDir = Directory.systemTemp;
    print('System temp directory: ${tempDir.path}');

    // Directory properties
    FileStat dirStat = await testDir.stat();
    print('Directory modified: ${dirStat.modified}');
    print('Directory type: ${dirStat.type}');

    // Rename directory
    Directory renamedDir = await testDir.rename('renamed_directory');
    print('Directory renamed to: ${renamedDir.path}');

    // Clean up
    await renamedDir.delete(recursive: true);
    print('Test directory cleaned up');
  } catch (e) {
    print('Directory operation error: $e');
  }
  print('');
}

// 3. Process Operations
Future<void> processOperations() async {
  print('3. PROCESS OPERATIONS');
  print('---------------------');

  try {
    // Run a simple command
    ProcessResult result = await Process.run('echo', ['Hello from process!']);
    print('Exit code: ${result.exitCode}');
    print('Stdout: ${result.stdout}');
    print('Stderr: ${result.stderr}');

    // Get current process info
    print('\nCurrent process info:');
    print('Process ID: ${pid}');

    // Platform-specific commands
    if (Platform.isWindows) {
      // Windows command
      ProcessResult dirResult = await Process.run('dir', [], runInShell: true);
      print('Directory listing (first 200 chars):');
      String output = dirResult.stdout.toString();
      print(output.length > 200 ? '${output.substring(0, 200)}...' : output);
    } else {
      // Unix-like command
      ProcessResult lsResult = await Process.run('ls', ['-la']);
      print('Directory listing: ${lsResult.stdout}');
    }

    // Start a process and interact with it
    print('\nStarting interactive process:');
    Process process = await Process.start('echo', ['Interactive process']);

    // Listen to stdout
    process.stdout.transform(utf8.decoder).listen((data) {
      print('Process output: $data');
    });

    // Listen to stderr
    process.stderr.transform(utf8.decoder).listen((data) {
      print('Process error: $data');
    });

    // Wait for process to complete
    int exitCode = await process.exitCode;
    print('Process completed with exit code: $exitCode');
  } catch (e) {
    print('Process operation error: $e');
  }
  print('');
}

// 4. HTTP Client Operations
Future<void> httpClientOperations() async {
  print('4. HTTP CLIENT OPERATIONS');
  print('-------------------------');

  HttpClient client = HttpClient();

  try {
    // Simple GET request
    HttpClientRequest request = await client.getUrl(
      Uri.parse('https://httpbin.org/get'),
    );
    HttpClientResponse response = await request.close();

    print('Response status: ${response.statusCode}');
    print('Response headers:');
    response.headers.forEach((name, values) {
      print('  $name: ${values.join(', ')}');
    });

    // Read response body
    String responseBody = await response.transform(utf8.decoder).join();
    print('Response body (first 200 chars):');
    print(
      responseBody.length > 200
          ? '${responseBody.substring(0, 200)}...'
          : responseBody,
    );

    // POST request with data
    print('\nMaking POST request:');
    HttpClientRequest postRequest = await client.postUrl(
      Uri.parse('https://httpbin.org/post'),
    );
    postRequest.headers.contentType = ContentType.json;

    Map<String, dynamic> postData = {
      'name': 'Dart',
      'version': '3.0',
      'message': 'Hello from Dart!',
    };

    postRequest.write(jsonEncode(postData));
    HttpClientResponse postResponse = await postRequest.close();

    print('POST response status: ${postResponse.statusCode}');
    String postResponseBody = await postResponse.transform(utf8.decoder).join();
    print('POST response body (first 300 chars):');
    print(
      postResponseBody.length > 300
          ? '${postResponseBody.substring(0, 300)}...'
          : postResponseBody,
    );
  } catch (e) {
    print('HTTP operation error: $e');
  } finally {
    client.close();
  }
  print('');
}

// 5. Platform Information
void platformInformation() {
  print('5. PLATFORM INFORMATION');
  print('-----------------------');

  print('Operating System: ${Platform.operatingSystem}');
  print('Operating System Version: ${Platform.operatingSystemVersion}');
  print('Path Separator: ${Platform.pathSeparator}');
  print('Number of Processors: ${Platform.numberOfProcessors}');
  print('Locale Name: ${Platform.localeName}');
  print('Host Name: ${Platform.localHostname}');

  print('\nPlatform checks:');
  print('Is Android: ${Platform.isAndroid}');
  print('Is Fuchsia: ${Platform.isFuchsia}');
  print('Is iOS: ${Platform.isIOS}');
  print('Is Linux: ${Platform.isLinux}');
  print('Is macOS: ${Platform.isMacOS}');
  print('Is Windows: ${Platform.isWindows}');

  print('\nExecutable info:');
  print('Executable: ${Platform.executable}');
  print('Resolved Executable: ${Platform.resolvedExecutable}');
  print('Script: ${Platform.script}');

  print('\nDart version: ${Platform.version}');
  print('');
}

// 6. Environment Variables
void environmentVariables() {
  print('6. ENVIRONMENT VARIABLES');
  print('------------------------');

  Map<String, String> env = Platform.environment;

  print('Total environment variables: ${env.length}');

  // Common environment variables
  List<String> commonVars = [
    'PATH',
    'HOME',
    'USER',
    'USERPROFILE',
    'TEMP',
    'TMP',
  ];

  print('\nCommon environment variables:');
  for (String varName in commonVars) {
    String? value = env[varName];
    if (value != null) {
      String displayValue =
          value.length > 50 ? '${value.substring(0, 50)}...' : value;
      print('$varName: $displayValue');
    }
  }

  // Check for specific variables
  print('\nChecking specific variables:');
  print('DART_SDK: ${env['DART_SDK'] ?? 'Not set'}');
  print('PUB_CACHE: ${env['PUB_CACHE'] ?? 'Not set'}');

  // Platform-specific variables
  if (Platform.isWindows) {
    print('COMPUTERNAME: ${env['COMPUTERNAME'] ?? 'Not set'}');
    print(
      'PROCESSOR_ARCHITECTURE: ${env['PROCESSOR_ARCHITECTURE'] ?? 'Not set'}',
    );
  } else {
    print('SHELL: ${env['SHELL'] ?? 'Not set'}');
    print('TERM: ${env['TERM'] ?? 'Not set'}');
  }
  print('');
}

// 7. Standard I/O Operations
Future<void> standardIOOperations() async {
  print('7. STANDARD I/O OPERATIONS');
  print('--------------------------');

  // Standard output
  stdout.writeln('This is written to stdout');
  stdout.write('This is written without newline');
  stdout.writeln(' - and this continues the line');

  // Standard error
  stderr.writeln('This is written to stderr');

  // Standard input (commented out to avoid blocking in automated runs)
  /*
  print('Enter your name:');
  String? name = stdin.readLineSync();
  print('Hello, ${name ?? 'Anonymous'}!');
  */

  // Working with stdin as stream
  print('\nStdin properties:');
  print('Stdin has terminal: ${stdin.hasTerminal}');
  print('Stdin supports ANSI: ${stdin.supportsAnsiEscapes}');

  // Stdout properties
  print('\nStdout properties:');
  print('Stdout has terminal: ${stdout.hasTerminal}');
  print('Stdout supports ANSI: ${stdout.supportsAnsiEscapes}');
  print('Terminal columns: ${stdout.terminalColumns}');
  print('Terminal lines: ${stdout.terminalLines}');

  // Exit codes
  print('\nExit codes:');
  print('Success: ${exitCode}');
  // exitCode = 1; // Uncomment to set exit code

  print('Standard I/O operations completed');
  print('');
}
