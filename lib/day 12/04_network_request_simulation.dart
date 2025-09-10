// Network Request Simulation using Future.delayed()

import 'dart:math';

/// Simulates a network request that fetches user data
/// Returns a Future that completes after a random delay (1-3 seconds)
Future<Map<String, dynamic>> fetchUserData(int userId) async {
  print("🌐 Starting network request for user $userId...");

  // Simulate network delay (1-3 seconds)
  int delaySeconds = Random().nextInt(3) + 1;
  await Future.delayed(Duration(seconds: delaySeconds));

  // Simulate occasional network failures (20% chance)
  if (Random().nextInt(5) == 0) {
    throw Exception("Network error: Failed to fetch user data");
  }

  // Return simulated user data
  return {
    'id': userId,
    'name': 'User $userId',
    'email': 'user$userId@example.com',
    'age': Random().nextInt(50) + 18,
    'city': ['New York', 'London', 'Tokyo', 'Paris'][Random().nextInt(4)],
    'fetchTime': DateTime.now().toIso8601String(),
  };
}

/// Simulates fetching a list of posts for a user
Future<List<Map<String, String>>> fetchUserPosts(int userId) async {
  print("📝 Fetching posts for user $userId...");

  // Simulate network delay
  await Future.delayed(Duration(milliseconds: 500 + Random().nextInt(1500)));

  // Generate random number of posts (1-5)
  int postCount = Random().nextInt(5) + 1;
  List<Map<String, String>> posts = [];

  for (int i = 1; i <= postCount; i++) {
    posts.add({
      'id': '${userId}_$i',
      'title': 'Post $i by User $userId',
      'content':
          'This is the content of post $i. It contains some interesting information.',
      'timestamp': DateTime.now().subtract(Duration(days: i)).toIso8601String(),
    });
  }

  return posts;
}

/// Simulates downloading a file with progress updates
Future<String> downloadFile(String fileName) async {
  print("⬇️ Starting download of $fileName...");

  // Simulate download progress
  for (int progress = 0; progress <= 100; progress += 10) {
    await Future.delayed(Duration(milliseconds: 200));
    print("Download progress: $progress%");
  }

  print("✅ Download completed: $fileName");
  return "Downloaded content of $fileName";
}

/// Example of handling multiple async operations
Future<void> demonstrateAsyncOperations() async {
  print("=== Async Operations Demo ===\n");

  try {
    // Sequential operations
    print("1. Sequential Operations:");
    Map<String, dynamic> userData = await fetchUserData(1);
    print("✅ User data received: ${userData['name']} from ${userData['city']}");

    List<Map<String, String>> posts = await fetchUserPosts(1);
    print("✅ Found ${posts.length} posts for user\n");

    // Parallel operations
    print("2. Parallel Operations:");
    List<Future> futures = [
      fetchUserData(2),
      fetchUserData(3),
      downloadFile("document.pdf"),
    ];

    List results = await Future.wait(futures);
    print("✅ All parallel operations completed!");
    print("   - User 2: ${results[0]['name']}");
    print("   - User 3: ${results[1]['name']}");
    print("   - File: Downloaded\n");
  } catch (error) {
    print("❌ Error occurred: $error");
  }
}

/// Example with error handling and retry logic
Future<Map<String, dynamic>> fetchUserDataWithRetry(
  int userId, {
  int maxRetries = 3,
}) async {
  int attempts = 0;

  while (attempts < maxRetries) {
    try {
      attempts++;
      print("🔄 Attempt $attempts to fetch user $userId data...");

      return await fetchUserData(userId);
    } catch (error) {
      print("❌ Attempt $attempts failed: $error");

      if (attempts >= maxRetries) {
        print("💥 Max retries reached. Giving up.");
        rethrow; // Re-throw the error
      }

      // Wait before retrying (exponential backoff)
      int waitTime = attempts * 2;
      print("⏳ Waiting ${waitTime}s before retry...");
      await Future.delayed(Duration(seconds: waitTime));
    }
  }

  throw Exception("This should never be reached");
}

/// Main function to run all examples
Future<void> main() async {
  print("🚀 Starting Async Programming Examples\n");

  // Basic async operations
  await demonstrateAsyncOperations();

  print("=== Retry Logic Demo ===");
  try {
    Map<String, dynamic> userData = await fetchUserDataWithRetry(99);
    print("✅ Successfully fetched: ${userData['name']}");
  } catch (error) {
    print("❌ Final error: $error");
  }

  print("\n🎉 All examples completed!");
}
