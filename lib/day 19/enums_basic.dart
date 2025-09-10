// Basic Enums Examples

/// Basic enum for days of the week
enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

/// Basic enum for directions
enum Direction { north, south, east, west }

/// Basic enum for priority levels
enum Priority { low, medium, high, critical }

/// Practice: LightColors enum as requested
enum LightColors { red, green, yellow }

void main() {
  print('=== Basic Enums Examples ===\n');

  // Example 1: Days of the week
  print('1. Days of the Week:');
  for (Day day in Day.values) {
    print('${day.name} (index: ${day.index})');
  }

  // Example 2: Working with specific enum values
  print('\n2. Working with Direction enum:');
  Direction currentDirection = Direction.north;
  print('Current direction: ${currentDirection.name}');
  print('Direction index: ${currentDirection.index}');

  // Switch statement with enums
  String directionDescription = switch (currentDirection) {
    Direction.north => 'Going up',
    Direction.south => 'Going down',
    Direction.east => 'Going right',
    Direction.west => 'Going left',
  };
  print('Description: $directionDescription');

  // Example 3: Priority levels
  print('\n3. Priority Levels:');
  List<Priority> taskPriorities = [
    Priority.low,
    Priority.high,
    Priority.medium,
    Priority.critical,
  ];

  // Sort by priority (using index)
  taskPriorities.sort((a, b) => a.index.compareTo(b.index));
  print('Sorted priorities: ${taskPriorities.map((p) => p.name).join(', ')}');

  // Example 4: LightColors (Practice Exercise)
  print('\n4. LightColors (Practice Exercise):');
  print('Available light colors:');
  for (LightColors color in LightColors.values) {
    print('- ${color.name} (index: ${color.index})');
  }

  // Traffic light simulation
  print('\nTraffic Light Simulation:');
  LightColors currentLight = LightColors.red;

  for (int i = 0; i < 6; i++) {
    String action = switch (currentLight) {
      LightColors.red => 'STOP',
      LightColors.yellow => 'CAUTION',
      LightColors.green => 'GO',
    };

    print('Light: ${currentLight.name.toUpperCase()} - Action: $action');

    // Cycle through lights
    currentLight = switch (currentLight) {
      LightColors.red => LightColors.green,
      LightColors.green => LightColors.yellow,
      LightColors.yellow => LightColors.red,
    };
  }

  // Example 5: Enum comparison and equality
  print('\n5. Enum Comparison:');
  LightColors light1 = LightColors.red;
  LightColors light2 = LightColors.red;
  LightColors light3 = LightColors.green;

  print('light1 == light2: ${light1 == light2}'); // true
  print('light1 == light3: ${light1 == light3}'); // false
  print('light1.index < light3.index: ${light1.index < light3.index}');
}
