# Day 14: Error Handling in Dart

## Overview
Error handling is crucial for building robust applications. Dart provides several mechanisms to handle exceptions gracefully and maintain application stability.

## Key Concepts

### 1. Exception vs Error
- **Exception**: Recoverable conditions that can be caught and handled
- **Error**: Programming errors that usually indicate bugs (like null pointer errors)

### 2. Try-Catch-Finally Structure

```dart
try {
  // Risky code that might throw an exception
} on SpecificException catch (e) {
  // Handle specific exception type
} catch (e) {
  // Handle any other exception
} finally {
  // Always executes (cleanup code)
}
```

### 3. Exception Handling Keywords

#### `try`
- Wraps code that might throw an exception
- Required for exception handling

#### `catch`
- Catches any type of exception
- Provides access to the exception object
- Can be used with or without `on`

#### `on`
- Catches specific exception types
- More precise than generic `catch`
- Can be combined with `catch` for exception object access

#### `finally`
- Always executes, regardless of whether an exception occurred
- Used for cleanup operations (closing files, connections, etc.)
- Optional block

### 4. Throwing Exceptions

#### Built-in Exceptions
```dart
throw ArgumentError('Invalid argument');
throw RangeError('Index out of range');
throw FormatException('Invalid format');
throw StateError('Invalid state');
```

#### Custom Exceptions
```dart
class CustomException implements Exception {
  final String message;
  CustomException(this.message);
  
  @override
  String toString() => 'CustomException: $message';
}
```

## Best Practices

### 1. Be Specific with Exception Types
- Use `on` to catch specific exception types
- Handle different exceptions differently
- Avoid catching all exceptions with generic `catch`

### 2. Provide Meaningful Error Messages
- Include context about what went wrong
- Help users understand how to fix the issue
- Log detailed information for debugging

### 3. Use Finally for Cleanup
- Close resources (files, network connections)
- Reset application state
- Ensure cleanup happens even if exceptions occur

### 4. Don't Ignore Exceptions
- Always handle or log exceptions
- Provide fallback behavior when possible
- Inform users about errors appropriately

### 5. Create Custom Exceptions for Domain Logic
- Make exceptions specific to your application
- Include relevant data in custom exceptions
- Use meaningful names that describe the error condition

## Common Exception Types in Dart

| Exception Type | Description | Common Causes |
|----------------|-------------|---------------|
| `ArgumentError` | Invalid argument passed to function | Null values, wrong types, invalid ranges |
| `RangeError` | Index out of bounds | Array/List access beyond limits |
| `FormatException` | String parsing failed | Invalid number format, JSON parsing |
| `StateError` | Object in invalid state | Calling methods on closed streams |
| `FileSystemException` | File operation failed | Missing files, permission issues |
| `TimeoutException` | Operation timed out | Network requests, long operations |

## Error Handling Patterns

### 1. Graceful Degradation
```dart
String loadUserPreference(String key) {
  try {
    return preferences.getString(key);
  } catch (e) {
    return getDefaultValue(key); // Fallback to default
  }
}
```

### 2. Retry Logic
```dart
Future<String> fetchDataWithRetry(String url, {int maxRetries = 3}) async {
  for (int attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      return await httpClient.get(url);
    } catch (e) {
      if (attempt == maxRetries) rethrow;
      await Future.delayed(Duration(seconds: attempt));
    }
  }
  throw StateError('This should never be reached');
}
```

### 3. Resource Management
```dart
void processFile(String path) {
  File? file;
  try {
    file = File(path);
    // Process file
  } catch (e) {
    print('Error processing file: $e');
  } finally {
    file?.close(); // Always close the file
  }
}
```

## Testing Error Handling

### 1. Test Exception Throwing
```dart
test('should throw ArgumentError for negative values', () {
  expect(() => calculateSquareRoot(-1), throwsA(isA<ArgumentError>()));
});
```

### 2. Test Exception Handling
```dart
test('should handle network errors gracefully', () {
  // Mock network failure
  when(mockClient.get(any)).thenThrow(NetworkException('Connection failed'));
  
  expect(() => fetchUserData('123'), returnsNormally);
});
```

## Performance Considerations

1. **Exception handling has overhead** - don't use for normal control flow
2. **Stack traces are expensive** - avoid in performance-critical code
3. **Finally blocks always execute** - keep them lightweight
4. **Specific catches are faster** - use `on` instead of generic `catch`

## Summary

Error handling in Dart provides powerful tools for building resilient applications:
- Use `try-catch-finally` for structured exception handling
- Create custom exceptions for domain-specific errors
- Always clean up resources in `finally` blocks
- Be specific about which exceptions you handle
- Provide meaningful error messages and fallback behavior
- Test your error handling code thoroughly

Remember: Good error handling makes the difference between a fragile application and a robust, user-friendly one.