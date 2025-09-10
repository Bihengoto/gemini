// Null Safety and Nullable Operator Examples

void main() {
  // Non-nullable variables (default behavior)
  String name = 'Alice';
  int age = 30;
  bool isStudent = false;

  print('Non-nullable: $name, $age, $isStudent');

  // These would cause compile-time errors:
  // name = null; // ❌ Error
  // age = null;  // ❌ Error

  // Nullable variables (with ? operator)
  String? nullableName;
  int? nullableAge;
  bool? nullableStatus;

  print(
    'Nullable (uninitialized): $nullableName, $nullableAge, $nullableStatus',
  );

  // Assigning values to nullable variables
  nullableName = 'Bob';
  nullableAge = 25;
  nullableStatus = true;

  print('Nullable (assigned): $nullableName, $nullableAge, $nullableStatus');

  // Setting back to null
  nullableName = null;
  nullableAge = null;
  nullableStatus = null;

  print('Nullable (null): $nullableName, $nullableAge, $nullableStatus');

  // Null-aware access operator (?.)
  String? firstName = 'John';
  String? lastName;

  int? firstNameLength = firstName?.length; // Returns 4
  int? lastNameLength = lastName?.length; // Returns null

  print('First name length: $firstNameLength');
  print('Last name length: $lastNameLength');

  // Null coalescing operator (??)
  String? username;
  String displayName = username ?? 'Guest';

  print('Display name: $displayName');

  username = 'alice123';
  displayName = username ?? 'Guest';
  print('Display name after assignment: $displayName');

  // Null assignment operator (??=)
  String? config;
  config ??= 'default_config'; // Assigns only if config is null
  print('Config: $config');

  config ??= 'another_config'; // Won't assign because config is not null
  print('Config after second assignment: $config');

  // Null assertion operator (!) - use with caution
  String? definitelyNotNull = 'Hello';
  int length = definitelyNotNull!.length; // Assert it's not null
  print('Length using null assertion: $length');

  // This would throw a runtime exception:
  // String? definitelyNull = null;
  // int badLength = definitelyNull!.length; // ❌ Runtime error

  // Safe null checking with if statements
  String? maybeNull = 'World';

  if (maybeNull != null) {
    // Inside this block, maybeNull is promoted to non-nullable
    print('Length of maybeNull: ${maybeNull.length}');
    print('Uppercase: ${maybeNull.toUpperCase()}');
  }

  // Late variables
  late String description;
  // description must be initialized before use
  description = 'This is initialized later';
  print('Late variable: $description');

  // Practical example: User profile
  demonstrateUserProfile();
}

void demonstrateUserProfile() {
  print('\n--- User Profile Example ---');

  // User data that might be incomplete
  String name = 'Alice Johnson';
  String? email; // Might not be provided
  int? age; // Might not be provided
  String? phone; // Might not be provided

  // Display user information safely
  print('Name: $name');
  print('Email: ${email ?? 'Not provided'}');
  print('Age: ${age?.toString() ?? 'Not specified'}');
  print('Phone: ${phone ?? 'Not available'}');

  // Check if contact info is complete
  bool hasCompleteContact = email != null && phone != null;
  print('Has complete contact info: $hasCompleteContact');

  // Safe method calls
  String emailDomain = email?.split('@').last ?? 'unknown';
  print('Email domain: $emailDomain');

  // Conditional operations
  if (age != null && age >= 18) {
    print('User is an adult');
  } else {
    print('User is a minor or age unknown');
  }
}
