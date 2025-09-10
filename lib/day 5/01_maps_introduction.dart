// Day 5: Collections - Maps Introduction
// Maps are key-value pair collections in Dart

void main() {
  print('=== Maps Introduction ===\n');

  // 1. Creating Maps
  print('1. Creating Maps:');

  // Empty map
  Map<String, int> emptyMap = {};
  Map<String, int> emptyMap2 = Map<String, int>();

  // Map with initial values
  Map<String, String> colors = {
    'red': '#FF0000',
    'green': '#00FF00',
    'blue': '#0000FF',
  };

  // Dynamic map (not recommended for production)
  Map dynamicMap = {'name': 'John', 'age': 25, 'isStudent': true};

  print('Colors map: $colors');
  print('Dynamic map: $dynamicMap\n');

  // 2. Map Properties
  print('2. Map Properties:');
  print('Length: ${colors.length}');
  print('Is empty: ${colors.isEmpty}');
  print('Is not empty: ${colors.isNotEmpty}');
  print('Keys: ${colors.keys}');
  print('Values: ${colors.values}\n');

  // 3. Accessing Map Elements
  print('3. Accessing Map Elements:');
  print('Red color code: ${colors['red']}');
  print('Non-existent key: ${colors['yellow']}'); // Returns null

  // Safe access with null check
  String? yellowCode = colors['yellow'];
  print('Yellow with null check: ${yellowCode ?? 'Not found'}\n');
}
