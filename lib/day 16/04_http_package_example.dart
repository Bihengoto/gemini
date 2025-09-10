// Day 16: HTTP Package - Practical Example
// ========================================

/*
THE HTTP PACKAGE

The 'http' package is one of the most commonly used packages in Flutter.
It provides a simple way to make HTTP requests (GET, POST, PUT, DELETE).

FEATURES:
- Simple API for HTTP requests
- Support for all HTTP methods
- JSON handling
- Error handling
- Timeout support
- Custom headers

TO USE THIS EXAMPLE:
1. Add to pubspec.yaml:
   dependencies:
     http: ^1.1.0

2. Run: flutter pub get

3. Uncomment the import statement below
*/

import 'dart:convert';
import 'dart:io';
// import 'package:http/http.dart' as http; // Uncomment when package is added

class HttpService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET request example
  static Future<Map<String, dynamic>?> getPost(int id) async {
    print('Making GET request to fetch post $id...');

    // Uncomment when http package is added:
    /*
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Network error: $e');
      return null;
    }
    */

    // Simulated response for demonstration
    return {
      'id': id,
      'title': 'Sample Post Title',
      'body': 'This is a sample post body',
      'userId': 1,
    };
  }

  // POST request example
  static Future<Map<String, dynamic>?> createPost({
    required String title,
    required String body,
    required int userId,
  }) async {
    print('Making POST request to create new post...');

    // Uncomment when http package is added:
    /*
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/posts'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': title,
          'body': body,
          'userId': userId,
        }),
      );
      
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Network error: $e');
      return null;
    }
    */

    // Simulated response for demonstration
    return {'id': 101, 'title': title, 'body': body, 'userId': userId};
  }

  // GET request for multiple items
  static Future<List<Map<String, dynamic>>> getAllPosts() async {
    print('Making GET request to fetch all posts...');

    // Uncomment when http package is added:
    /*
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        return jsonList.cast<Map<String, dynamic>>();
      } else {
        print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Network error: $e');
      return [];
    }
    */

    // Simulated response for demonstration
    return [
      {'id': 1, 'title': 'Post 1', 'body': 'Body 1', 'userId': 1},
      {'id': 2, 'title': 'Post 2', 'body': 'Body 2', 'userId': 1},
      {'id': 3, 'title': 'Post 3', 'body': 'Body 3', 'userId': 2},
    ];
  }
}

// Example usage
void main() async {
  print('=== HTTP Package Example ===\n');

  // Example 1: Get a single post
  print('1. Fetching single post:');
  final post = await HttpService.getPost(1);
  if (post != null) {
    print('Title: ${post['title']}');
    print('Body: ${post['body']}\n');
  }

  // Example 2: Create a new post
  print('2. Creating new post:');
  final newPost = await HttpService.createPost(
    title: 'My New Post',
    body: 'This is the content of my new post',
    userId: 1,
  );
  if (newPost != null) {
    print('Created post with ID: ${newPost['id']}');
    print('Title: ${newPost['title']}\n');
  }

  // Example 3: Get all posts
  print('3. Fetching all posts:');
  final allPosts = await HttpService.getAllPosts();
  print('Found ${allPosts.length} posts');
  for (var post in allPosts.take(3)) {
    print('- ${post['title']}');
  }
}
