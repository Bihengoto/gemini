import 'todo_manager.dart';
import 'console_ui.dart';

/// Main entry point for the Todo List Manager application
///
/// This demonstrates the integration of all components:
/// - Task: Data model
/// - TodoManager: Business logic
/// - ConsoleUI: User interface
///
/// The application follows MVC pattern and demonstrates
/// object-oriented programming principles learned in Dart.
void main() {
  // Create the business logic layer
  final todoManager = TodoManager();

  // Optionally create some sample tasks for demonstration
  // Uncomment the next line to start with sample data
  // todoManager.createSampleTasks();

  // Create the user interface layer
  final consoleUI = ConsoleUI(todoManager);

  // Start the application
  try {
    consoleUI.run();
  } catch (e) {
    print('❌ An error occurred: $e');
    print('The application will now exit.');
  }
}

/// Alternative main function for testing with sample data
void mainWithSamples() {
  final todoManager = TodoManager();

  // Create sample tasks for demonstration
  todoManager.createSampleTasks();

  final consoleUI = ConsoleUI(todoManager);
  consoleUI.run();
}

/// Demonstration of the TodoManager API without UI
void demonstrateAPI() {
  print('=== TodoManager API Demonstration ===\n');

  final manager = TodoManager();

  // Add tasks
  print('1. Adding tasks...');
  manager.addTask('Learn Dart', 'Complete basic syntax and OOP concepts');
  manager.addTask('Build console app', 'Create a to-do list manager');
  manager.addTask('Practice algorithms', 'Solve coding challenges');

  // Display all tasks
  print('\n2. All tasks:');
  for (final task in manager.allTasks) {
    print('   ${task.toString()}');
  }

  // Complete a task
  print('\n3. Completing first task...');
  manager.completeTask(1);

  // Show statistics
  print('\n4. Statistics:');
  final stats = manager.getStatistics();
  print('   Total: ${stats['total']}');
  print('   Completed: ${stats['completed']}');
  print('   Pending: ${stats['pending']}');
  print('   Completion: ${stats['completion_percentage']}%');

  // Search tasks
  print('\n5. Searching for "Dart":');
  final results = manager.searchTasks('Dart');
  for (final task in results) {
    print('   ${task.toString()}');
  }

  // Show pending tasks only
  print('\n6. Pending tasks:');
  for (final task in manager.pendingTasks) {
    print('   ${task.toString()}');
  }

  print('\n=== Demonstration Complete ===');
}
