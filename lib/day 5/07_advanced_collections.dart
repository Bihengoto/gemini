// Day 5: Advanced Collections - Maps and Sets
// Advanced techniques and real-world examples

void main() {
  print('=== Advanced Collections ===\n');

  // 1. Nested Maps and Sets
  print('1. Nested Maps and Sets:');

  Map<String, Set<String>> userSkills = {
    'Alice': {'Dart', 'Flutter', 'JavaScript', 'Python'},
    'Bob': {'Java', 'Spring', 'MySQL', 'Docker'},
    'Charlie': {'Python', 'Django', 'PostgreSQL', 'AWS'},
  };

  print('User Skills:');
  userSkills.forEach((user, skills) {
    print('  $user: ${skills.join(', ')}');
  });

  // 2. Map of Maps (Database-like structure)
  print('\n2. Map of Maps (Database-like):');

  Map<String, Map<String, dynamic>> inventory = {
    'laptop001': {
      'name': 'MacBook Pro',
      'price': 1299.99,
      'category': 'Electronics',
      'inStock': true,
      'tags': {'premium', 'apple', 'laptop'},
    },
    'phone001': {
      'name': 'iPhone 15',
      'price': 999.99,
      'category': 'Electronics',
      'inStock': false,
      'tags': {'premium', 'apple', 'smartphone'},
    },
  };

  print('Inventory:');
  inventory.forEach((id, product) {
    print('  $id: ${product['name']} - \$${product['price']}');
    print('    In Stock: ${product['inStock']}');
    print('    Tags: ${product['tags']}');
  });

  // 3. Set Operations for Data Analysis
  print('\n3. Set Operations for Data Analysis:');

  Set<String> webDevelopers = {'Alice', 'Bob', 'David', 'Eve'};
  Set<String> mobileDevelopers = {'Bob', 'Charlie', 'Eve', 'Frank'};
  Set<String> backendDevelopers = {'Alice', 'Charlie', 'David', 'Grace'};

  print('Web Developers: $webDevelopers');
  print('Mobile Developers: $mobileDevelopers');
  print('Backend Developers: $backendDevelopers');

  // Full-stack developers (web + backend)
  Set<String> fullStackDevelopers = webDevelopers.intersection(
    backendDevelopers,
  );
  print('\nFull-stack Developers: $fullStackDevelopers');

  // Versatile developers (all three skills)
  Set<String> versatileDevelopers = webDevelopers
      .intersection(mobileDevelopers)
      .intersection(backendDevelopers);
  print('Versatile Developers: $versatileDevelopers');

  // All developers
  Set<String> allDevelopers = webDevelopers
      .union(mobileDevelopers)
      .union(backendDevelopers);
  print('All Developers: $allDevelopers');

  // 4. Frequency Counter using Maps
  print('\n4. Frequency Counter:');

  String text = 'hello world hello dart programming world';
  List<String> words = text.split(' ');

  Map<String, int> wordFrequency = {};

  for (String word in words) {
    wordFrequency[word] = (wordFrequency[word] ?? 0) + 1;
  }

  print('Word frequencies:');
  wordFrequency.forEach((word, count) {
    print('  "$word": $count');
  });

  // 5. Caching with Maps
  print('\n5. Simple Cache Implementation:');

  Map<String, String> cache = {};

  String getCachedData(String key) {
    if (cache.containsKey(key)) {
      print('Cache hit for: $key');
      return cache[key]!;
    } else {
      print('Cache miss for: $key, fetching data...');
      String data = 'Data for $key'; // Simulate data fetching
      cache[key] = data;
      return data;
    }
  }

  // Test caching
  print(getCachedData('user123'));
  print(getCachedData('user456'));
  print(getCachedData('user123')); // Should be cache hit

  print('Cache contents: $cache');

  // 6. Set-based Permissions System
  print('\n6. Permissions System:');

  Map<String, Set<String>> userPermissions = {
    'admin': {'read', 'write', 'delete', 'manage_users'},
    'editor': {'read', 'write'},
    'viewer': {'read'},
  };

  bool hasPermission(String userRole, String permission) {
    return userPermissions[userRole]?.contains(permission) ?? false;
  }

  print('Admin can delete: ${hasPermission('admin', 'delete')}');
  print('Editor can delete: ${hasPermission('editor', 'delete')}');
  print('Viewer can read: ${hasPermission('viewer', 'read')}');
}
