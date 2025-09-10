// Practical Exercises for Asynchronous Programming

import 'dart:math';

/// Exercise 1: Basic Future Creation
/// Create a function that returns a Future with your name after 2 seconds
Future<String> getMyName() async {
  // TODO: Implement this function
  // Hint: Use Future.delayed() and return your name
  await Future.delayed(Duration(seconds: 2));
  return "Your Name Here"; // Replace with your actual name
}

/// Exercise 2: Simulate API Call
/// Create a function that simulates fetching weather data
/// Should return temperature, humidity, and city name
Future<Map<String, dynamic>> fetchWeatherData(String city) async {
  // TODO: Implement this function
  // 1. Add a random delay between 1-3 seconds
  // 2. Return a map with weather data
  // 3. Include: temperature, humidity, city, description

  int delaySeconds = Random().nextInt(3) + 1;
  await Future.delayed(Duration(seconds: delaySeconds));

  return {
    'city': city,
    'temperature': Random().nextInt(35) + 5, // 5-40°C
    'humidity': Random().nextInt(60) + 30, // 30-90%
    'description': ['Sunny', 'Cloudy', 'Rainy', 'Snowy'][Random().nextInt(4)],
    'timestamp': DateTime.now().toIso8601String(),
  };
}

/// Exercise 3: Error Handling
/// Create a function that randomly fails 30% of the time
Future<String> unreliableService() async {
  await Future.delayed(Duration(seconds: 1));

  // TODO: Add logic to randomly throw an exception 30% of the time
  if (Random().nextInt(10) < 3) {
    throw Exception("Service temporarily unavailable");
  }

  return "Service response: Operation successful";
}

/// Exercise 4: Multiple Async Operations
/// Fetch data from multiple sources and combine the results
Future<Map<String, dynamic>> fetchCombinedData() async {
  // TODO: Implement this function
  // 1. Fetch weather data for "London"
  // 2. Fetch your name
  // 3. Get current timestamp
  // 4. Combine all data into a single map
  // 5. Handle any errors that might occur

  try {
    // Start all operations in parallel
    Future<Map<String, dynamic>> weatherFuture = fetchWeatherData("London");
    Future<String> nameFuture = getMyName();

    // Wait for all to complete
    List results = await Future.wait([weatherFuture, nameFuture]);

    return {
      'weather': results[0],
      'user': results[1],
      'timestamp': DateTime.now().toIso8601String(),
      'status': 'success',
    };
  } catch (error) {
    return {
      'error': error.toString(),
      'timestamp': DateTime.now().toIso8601String(),
      'status': 'failed',
    };
  }
}

/// Exercise 5: Sequential vs Parallel
/// Compare the performance of sequential vs parallel execution
Future<void> compareExecutionMethods() async {
  print("=== Comparing Sequential vs Parallel Execution ===\n");

  // Sequential execution
  print("🔄 Sequential Execution:");
  Stopwatch sequentialTimer = Stopwatch()..start();

  // TODO: Fetch weather data for 3 cities sequentially
  // Cities: "New York", "London", "Tokyo"
  Map<String, dynamic> nyWeather = await fetchWeatherData("New York");
  Map<String, dynamic> londonWeather = await fetchWeatherData("London");
  Map<String, dynamic> tokyoWeather = await fetchWeatherData("Tokyo");

  sequentialTimer.stop();
  print("✅ Sequential completed in ${sequentialTimer.elapsedMilliseconds}ms\n");

  // Parallel execution
  print("⚡ Parallel Execution:");
  Stopwatch parallelTimer = Stopwatch()..start();

  // TODO: Fetch weather data for the same 3 cities in parallel
  List<Map<String, dynamic>> parallelResults = await Future.wait([
    fetchWeatherData("New York"),
    fetchWeatherData("London"),
    fetchWeatherData("Tokyo"),
  ]);

  parallelTimer.stop();
  print("✅ Parallel completed in ${parallelTimer.elapsedMilliseconds}ms\n");

  // Show the difference
  int timeSaved =
      sequentialTimer.elapsedMilliseconds - parallelTimer.elapsedMilliseconds;
  print("⚡ Time saved with parallel execution: ${timeSaved}ms");
}

/// Exercise 6: Timeout Handling
/// Create a function that times out if it takes too long
Future<String> fetchWithTimeout(
  String url, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  // TODO: Implement timeout functionality
  // 1. Create a Future that simulates a slow network request
  // 2. Use Future.timeout() to add a timeout
  // 3. Handle TimeoutException

  try {
    return await Future.delayed(
      Duration(seconds: Random().nextInt(8) + 1), // 1-8 seconds
      () => "Data from $url",
    ).timeout(timeout);
  } catch (error) {
    if (error.toString().contains('TimeoutException')) {
      return "Request timed out for $url";
    }
    rethrow;
  }
}

/// Exercise 7: Stream Simulation
/// Create a function that returns periodic updates
Stream<String> simulateDataStream() async* {
  // TODO: Create a stream that yields data every 2 seconds
  // Yield 5 different status messages

  List<String> statuses = [
    "Initializing...",
    "Connecting to server...",
    "Authenticating...",
    "Fetching data...",
    "Complete!",
  ];

  for (String status in statuses) {
    await Future.delayed(Duration(seconds: 2));
    yield status;
  }
}

/// Test all exercises
Future<void> runAllExercises() async {
  print("🎯 Running Async Programming Exercises\n");

  // Exercise 1
  print("Exercise 1: Basic Future");
  String name = await getMyName();
  print("✅ Name: $name\n");

  // Exercise 2
  print("Exercise 2: Weather API Simulation");
  Map<String, dynamic> weather = await fetchWeatherData("Paris");
  print(
    "✅ Weather in ${weather['city']}: ${weather['temperature']}°C, ${weather['description']}\n",
  );

  // Exercise 3
  print("Exercise 3: Error Handling");
  for (int i = 1; i <= 3; i++) {
    try {
      String result = await unreliableService();
      print("✅ Attempt $i: $result");
      break;
    } catch (error) {
      print("❌ Attempt $i failed: $error");
    }
  }
  print("");

  // Exercise 4
  print("Exercise 4: Combined Data");
  Map<String, dynamic> combined = await fetchCombinedData();
  print("✅ Combined data status: ${combined['status']}");
  if (combined['status'] == 'success') {
    print("   User: ${combined['user']}");
    print(
      "   Weather: ${combined['weather']['temperature']}°C in ${combined['weather']['city']}",
    );
  }
  print("");

  // Exercise 5
  await compareExecutionMethods();
  print("");

  // Exercise 6
  print("Exercise 6: Timeout Handling");
  String result = await fetchWithTimeout(
    "https://api.example.com/data",
    timeout: Duration(seconds: 3),
  );
  print("✅ Result: $result\n");

  // Exercise 7
  print("Exercise 7: Stream Simulation");
  await for (String status in simulateDataStream()) {
    print("📡 Status: $status");
  }

  print("\n🎉 All exercises completed!");
}

/// Main function
Future<void> main() async {
  await runAllExercises();
}
