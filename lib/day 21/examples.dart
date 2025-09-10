import 'task.dart';
import 'todo_manager.dart';
import 'console_ui.dart';

/// Examples and usage demonstrations for the Todo List Manager
///
/// This file contains various examples showing how to use the
/// different components of the application.

void main() {
  print('Choose an example to run:');
  print('1. Basic Task Operations');
  print('2. TodoManager Features');
  print('3. Advanced Task Management');
  print('4. Error Handling Examples');
  print('5. Performance Test');

  // For demonstration, run all examples
  runAllExamples();
}

/// Run all example demonstrations
void runAllExamples() {
  print('🚀 Running all Todo List Manager examples...\n');

  basicTaskOperations();
  print('\n' + '=' * 50 + '\n');

  todoManagerFeatures();
  print('\n' + '=' * 50 + '\n');

  advancedTaskManagement();
  print('\n' + '=' * 50 + '\n');

  errorHandlingExamples();
  print('\n' + '=' * 50 + '\n');

  performanceTest();

  print('\n🎉 All examples completed!');
}

/// Example 1: Basic Task Operations
void basicTaskOperations() {
  print('📝 Example 1: Basic Task Operations');
  print('─' * 40);

  // Creating tasks with different constructors
  final task1 = Task('Learn Dart basics');
  final task2 = Task('Build a project', 'Create a console application');
  final task3 = Task.completed('Read documentation');
  final task4 = Task.withStatus('Practice coding', false, 'Daily practice');

  print('Created tasks:');
  print('1. ${task1.toString()}');
  print('2. ${task2.toString()}');
  print('3. ${task3.toString()}');
  print('4. ${task4.toString()}');

  // Task operations
  print('\nTask operations:');
  task1.markComplete();
  print('After completing task 1: ${task1.toString()}');

  task3.toggle();
  print('After toggling task 3: ${task3.toString()}');

  // Task properties
  print('\nTask properties:');
  print('Task 2 ID: ${task2.id}');
  print('Task 2 status: ${task2.status}');
  print('Task 2 created today: ${task2.isCreatedToday}');
  print('Task 2 formatted date: ${task2.formattedDate}');

  // Detailed information
  print('\nDetailed task information:');
  print(task2.toDetailedString());
}

/// Example 2: TodoManager Features
void todoManagerFeatures() {
  print('📋 Example 2: TodoManager Features');
  print('─' * 40);

  final manager = TodoManager();

  // Adding tasks
  print('Adding tasks...');
  manager.addTask('Morning workout', 'Go for a 30-minute run');
  manager.addTask('Read a book', 'Read at least 20 pages');
  manager.addTask('Code review', 'Review team\'s pull requests');
  manager.addTask('Grocery shopping', 'Buy vegetables and fruits');
  manager.addTask('Call mom', 'Weekly check-in call');

  print('Total tasks added: ${manager.totalTasks}');

  // Complete some tasks
  manager.completeTask(1); // Morning workout
  manager.completeTask(3); // Code review
  manager.completeTask(5); // Call mom

  // Show statistics
  print('\nStatistics:');
  final stats = manager.getStatistics();
  stats.forEach((key, value) => print('$key: $value'));

  // Show different task lists
  print('\nPending tasks (${manager.pendingCount}):');
  for (final task in manager.pendingTasks) {
    print('  ${task.toString()}');
  }

  print('\nCompleted tasks (${manager.completedCount}):');
  for (final task in manager.completedTasks) {
    print('  ${task.toString()}');
  }

  // Search functionality
  print('\nSearching for "read":');
  final searchResults = manager.searchTasks('read');
  for (final task in searchResults) {
    print('  ${task.toString()}');
  }
}

/// Example 3: Advanced Task Management
void advancedTaskManagement() {
  print('🔧 Example 3: Advanced Task Management');
  print('─' * 40);

  final manager = TodoManager();

  // Create a variety of tasks
  final tasks = [
    'Zebra project planning',
    'Apple store visit',
    'Beta testing',
    'Code documentation',
    'Database optimization',
  ];

  for (final taskTitle in tasks) {
    manager.addTask(taskTitle, 'Description for $taskTitle');
  }

  // Complete some tasks randomly
  manager.completeTask(2); // Apple store visit
  manager.completeTask(4); // Code documentation

  print('Original order:');
  _printTaskList(manager.allTasks);

  // Sort by title
  manager.sortByTitle();
  print('\nSorted by title (ascending):');
  _printTaskList(manager.allTasks);

  // Sort by status (pending first)
  manager.sortByStatus(completedFirst: false);
  print('\nSorted by status (pending first):');
  _printTaskList(manager.allTasks);

  // Update a task
  print('\nUpdating task 1...');
  manager.updateTask(
    1,
    title: 'Updated: Zebra project planning',
    description: 'Updated description with more details',
  );

  final updatedTask = manager.findTaskById(1);
  print('Updated task: ${updatedTask?.toString()}');

  // Clear completed tasks
  print('\nClearing completed tasks...');
  final clearedCount = manager.clearCompleted();
  print('Cleared $clearedCount completed tasks');
  print('Remaining tasks: ${manager.totalTasks}');
}

/// Example 4: Error Handling
void errorHandlingExamples() {
  print('⚠️  Example 4: Error Handling');
  print('─' * 40);

  final manager = TodoManager();

  // Test empty title validation
  print('Testing empty title validation:');
  try {
    manager.addTask('');
  } catch (e) {
    print('✅ Caught expected error: $e');
  }

  try {
    manager.addTask('   '); // Only whitespace
  } catch (e) {
    print('✅ Caught expected error: $e');
  }

  // Test invalid task operations
  print('\nTesting operations on non-existent tasks:');
  final found = manager.findTaskById(999);
  print('Finding non-existent task (ID 999): ${found ?? "null"}');

  final removed = manager.removeTask(999);
  print('Removing non-existent task: $removed');

  final toggled = manager.toggleTask(999);
  print('Toggling non-existent task: $toggled');

  // Test Task constructor validation
  print('\nTesting Task constructor validation:');
  try {
    Task('');
  } catch (e) {
    print('✅ Caught expected error: $e');
  }

  try {
    Task('   '); // Only whitespace
  } catch (e) {
    print('✅ Caught expected error: $e');
  }

  // Test valid operations
  print('\nTesting valid operations:');
  final task = manager.addTask('Valid task');
  print('✅ Successfully added task: ${task.toString()}');

  final success = manager.toggleTask(task.id);
  print('✅ Successfully toggled task: $success');
}

/// Example 5: Performance Test
void performanceTest() {
  print('🚀 Example 5: Performance Test');
  print('─' * 40);

  final manager = TodoManager();
  final stopwatch = Stopwatch();

  // Test adding many tasks
  print('Adding 1000 tasks...');
  stopwatch.start();

  for (int i = 1; i <= 1000; i++) {
    manager.addTask('Task $i', 'Description for task $i');
  }

  stopwatch.stop();
  print('✅ Added 1000 tasks in ${stopwatch.elapsedMilliseconds}ms');

  // Test completing tasks
  stopwatch.reset();
  stopwatch.start();

  for (int i = 1; i <= 500; i += 2) {
    // Complete every other task
    manager.completeTask(i);
  }

  stopwatch.stop();
  print('✅ Completed 500 tasks in ${stopwatch.elapsedMilliseconds}ms');

  // Test search performance
  stopwatch.reset();
  stopwatch.start();

  final searchResults = manager.searchTasks('Task 5');

  stopwatch.stop();
  print('✅ Searched 1000 tasks in ${stopwatch.elapsedMicroseconds}μs');
  print('   Found ${searchResults.length} matching tasks');

  // Test sorting performance
  stopwatch.reset();
  stopwatch.start();

  manager.sortByTitle();

  stopwatch.stop();
  print('✅ Sorted 1000 tasks by title in ${stopwatch.elapsedMilliseconds}ms');

  // Final statistics
  print('\nFinal statistics:');
  final stats = manager.getStatistics();
  print('Total tasks: ${stats['total']}');
  print('Completed: ${stats['completed']}');
  print('Pending: ${stats['pending']}');
  print('Completion rate: ${stats['completion_percentage']}%');
}

/// Helper function to print task lists
void _printTaskList(List<Task> tasks) {
  for (int i = 0; i < tasks.length && i < 5; i++) {
    // Show first 5 tasks
    print('  ${tasks[i].toString()}');
  }
  if (tasks.length > 5) {
    print('  ... and ${tasks.length - 5} more tasks');
  }
}

/// Interactive example runner
void runInteractiveExample() {
  print('🎮 Interactive Example');
  print('This will start the full application with sample data.');
  print('Press Enter to continue or Ctrl+C to exit...');

  // Wait for user input
  // stdin.readLineSync();

  final manager = TodoManager();
  manager.createSampleTasks();

  final ui = ConsoleUI(manager);
  ui.run();
}

/// Minimal usage example
void minimalExample() {
  print('📝 Minimal Usage Example');
  print('─' * 30);

  // Create manager and add tasks
  final manager = TodoManager();
  manager.addTask('Learn Dart');
  manager.addTask('Build an app');

  // Complete first task
  manager.completeTask(1);

  // Show results
  print('Tasks:');
  for (final task in manager.allTasks) {
    print('  ${task.toString()}');
  }

  print('\nStats: ${manager.completedCount}/${manager.totalTasks} completed');
}
