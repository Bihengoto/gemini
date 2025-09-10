// Day 5: Practice - User Profile with Maps
// Creating and managing user profiles using Maps

void main() {
  print('=== User Profile Practice ===\n');

  // 1. Creating User Profiles
  print('1. Creating User Profiles:');

  // Basic user profile
  Map<String, String> userProfile = {
    'name': 'Gemini',
    'email': 'gemini@example.com',
    'role': 'AI Assistant',
    'location': 'Cloud',
  };

  print('User Profile: $userProfile\n');

  // 2. More Complex User Profile
  print('2. Complex User Profile:');

  Map<String, dynamic> detailedProfile = {
    'personalInfo': {
      'firstName': 'Gemini',
      'lastName': 'AI',
      'age': 1,
      'email': 'gemini@google.com',
    },
    'preferences': {
      'theme': 'dark',
      'language': 'English',
      'notifications': true,
    },
    'skills': ['Programming', 'Problem Solving', 'Communication'],
    'projects': 15,
    'isActive': true,
  };

  print('Detailed Profile:');
  detailedProfile.forEach((key, value) {
    print('  $key: $value');
  });

  // 3. User Profile Operations
  print('\n3. User Profile Operations:');

  // Adding new information
  userProfile['phone'] = '+1-234-567-8900';
  userProfile['joinDate'] = '2024-01-01';

  // Updating existing information
  userProfile['role'] = 'Senior AI Assistant';

  print('Updated Profile: $userProfile');

  // 4. Profile Validation
  print('\n4. Profile Validation:');

  List<String> requiredFields = ['name', 'email', 'role'];
  bool isProfileComplete = true;

  for (String field in requiredFields) {
    if (!userProfile.containsKey(field) || userProfile[field]!.isEmpty) {
      print('Missing required field: $field');
      isProfileComplete = false;
    }
  }

  print('Profile complete: $isProfileComplete');

  // 5. Multiple User Profiles
  print('\n5. Multiple User Profiles:');

  Map<String, Map<String, String>> userDatabase = {
    'user1': {
      'name': 'Alice Johnson',
      'email': 'alice@example.com',
      'role': 'Developer',
    },
    'user2': {
      'name': 'Bob Smith',
      'email': 'bob@example.com',
      'role': 'Designer',
    },
    'user3': {
      'name': 'Charlie Brown',
      'email': 'charlie@example.com',
      'role': 'Manager',
    },
  };

  print('User Database:');
  userDatabase.forEach((userId, profile) {
    print('  $userId: ${profile['name']} (${profile['role']})');
  });

  // Finding users by role
  print('\nDevelopers in database:');
  userDatabase.forEach((userId, profile) {
    if (profile['role'] == 'Developer') {
      print('  ${profile['name']}');
    }
  });
}
