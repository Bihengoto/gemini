import 'dart:io';
import 'task.dart';
import 'todo_manager.dart';

/// Handles all user interface interactions for the console application
///
/// This class follows the Single Responsibility Principle by focusing
/// only on user interface concerns, separate from business logic.
class ConsoleUI {
  final TodoManager _todoManager;

  ConsoleUI(this._todoManager);

  /// Main application loop
  void run() {
    _showWelcome();

    while (true) {
      _showMainMenu();
      final choice = _getMenuChoice();

      if (!_handleMenuChoice(choice)) {
        break; // Exit application
      }
    }

    _showGoodbye();
  }

  /// Display welcome message
  void _showWelcome() {
    _clearScreen();
    print('╔══════════════════════════════════════╗');
    print('║        📝 TODO LIST MANAGER          ║');
    print('║     Your Personal Task Organizer     ║');
    print('╚══════════════════════════════════════╝');
    print('');
    _showStatistics();
    _pauseForUser();
  }

  /// Display main menu options
  void _showMainMenu() {
    _clearScreen();
    _showHeader();
    print('┌─────────────────────────────────────┐');
    print('│              MAIN MENU              │');
    print('├─────────────────────────────────────┤');
    print('│ 1. 📋 List all tasks                │');
    print('│ 2. ➕ Add new task                  │');
    print('│ 3. ✅ Complete task                 │');
    print('│ 4. ❌ Remove task                   │');
    print('│ 5. 🔄 Toggle task status            │');
    print('│ 6. ✏️  Edit task                    │');
    print('│ 7. 🔍 Search tasks                  │');
    print('│ 8. 📊 View statistics               │');
    print('│ 9. 🧹 Clear completed tasks         │');
    print('│ 0. 🚪 Exit                          │');
    print('└─────────────────────────────────────┘');
    print('');
  }

  /// Get user menu choice with validation
  int _getMenuChoice() {
    while (true) {
      stdout.write('Enter your choice (0-9): ');
      final input = stdin.readLineSync()?.trim();

      if (input == null || input.isEmpty) {
        print('❌ Please enter a valid choice.');
        continue;
      }

      final choice = int.tryParse(input);
      if (choice == null || choice < 0 || choice > 9) {
        print('❌ Please enter a number between 0 and 9.');
        continue;
      }

      return choice;
    }
  }

  /// Handle menu choice and return false if user wants to exit
  bool _handleMenuChoice(int choice) {
    switch (choice) {
      case 1:
        _listTasks();
        break;
      case 2:
        _addTask();
        break;
      case 3:
        _completeTask();
        break;
      case 4:
        _removeTask();
        break;
      case 5:
        _toggleTask();
        break;
      case 6:
        _editTask();
        break;
      case 7:
        _searchTasks();
        break;
      case 8:
        _showDetailedStatistics();
        break;
      case 9:
        _clearCompletedTasks();
        break;
      case 0:
        return false; // Exit application
      default:
        print('❌ Invalid choice. Please try again.');
    }

    return true; // Continue application
  }

  /// List all tasks with formatting
  void _listTasks() {
    _clearScreen();
    _showHeader();

    if (_todoManager.isEmpty) {
      print('📭 No tasks found. Add some tasks to get started!');
      _pauseForUser();
      return;
    }

    print('┌─────────────────────────────────────┐');
    print('│              ALL TASKS              │');
    print('└─────────────────────────────────────┘');
    print('');

    // Show pending tasks first
    final pendingTasks = _todoManager.pendingTasks;
    final completedTasks = _todoManager.completedTasks;

    if (pendingTasks.isNotEmpty) {
      print('🔄 PENDING TASKS:');
      print('─' * 40);
      for (final task in pendingTasks) {
        _printTask(task);
      }
      print('');
    }

    if (completedTasks.isNotEmpty) {
      print('✅ COMPLETED TASKS:');
      print('─' * 40);
      for (final task in completedTasks) {
        _printTask(task);
      }
    }

    print('');
    _showStatistics();
    _pauseForUser();
  }

  /// Add a new task
  void _addTask() {
    _clearScreen();
    _showHeader();
    print('┌─────────────────────────────────────┐');
    print('│             ADD NEW TASK            │');
    print('└─────────────────────────────────────┘');
    print('');

    // Get task title
    stdout.write('Enter task title: ');
    final title = stdin.readLineSync()?.trim();

    if (title == null || title.isEmpty) {
      print('❌ Task title cannot be empty.');
      _pauseForUser();
      return;
    }

    // Get optional description
    stdout.write('Enter description (optional): ');
    final description = stdin.readLineSync()?.trim() ?? '';

    try {
      final task = _todoManager.addTask(title, description);
      print('✅ Task added successfully!');
      print('   ${task.toString()}');
    } catch (e) {
      print('❌ Error adding task: $e');
    }

    _pauseForUser();
  }

  /// Complete a task
  void _completeTask() {
    if (_todoManager.isEmpty) {
      _showEmptyListMessage();
      return;
    }

    _clearScreen();
    _showHeader();
    print('┌─────────────────────────────────────┐');
    print('│            COMPLETE TASK            │');
    print('└─────────────────────────────────────┘');
    print('');

    _listTasksForSelection();

    final taskId = _getTaskIdFromUser('Enter task ID to complete: ');
    if (taskId == null) return;

    if (_todoManager.completeTask(taskId)) {
      print('✅ Task marked as completed!');
    } else {
      print('❌ Task not found.');
    }

    _pauseForUser();
  }

  /// Remove a task
  void _removeTask() {
    if (_todoManager.isEmpty) {
      _showEmptyListMessage();
      return;
    }

    _clearScreen();
    _showHeader();
    print('┌─────────────────────────────────────┐');
    print('│             REMOVE TASK             │');
    print('└─────────────────────────────────────┘');
    print('');

    _listTasksForSelection();

    final taskId = _getTaskIdFromUser('Enter task ID to remove: ');
    if (taskId == null) return;

    final task = _todoManager.findTaskById(taskId);
    if (task == null) {
      print('❌ Task not found.');
      _pauseForUser();
      return;
    }

    // Confirm deletion
    print('Are you sure you want to remove this task?');
    print('   ${task.toString()}');
    stdout.write('Type "yes" to confirm: ');
    final confirmation = stdin.readLineSync()?.trim().toLowerCase();

    if (confirmation == 'yes') {
      if (_todoManager.removeTask(taskId)) {
        print('✅ Task removed successfully!');
      } else {
        print('❌ Failed to remove task.');
      }
    } else {
      print('❌ Task removal cancelled.');
    }

    _pauseForUser();
  }

  /// Toggle task completion status
  void _toggleTask() {
    if (_todoManager.isEmpty) {
      _showEmptyListMessage();
      return;
    }

    _clearScreen();
    _showHeader();
    print('┌─────────────────────────────────────┐');
    print('│           TOGGLE TASK STATUS        │');
    print('└─────────────────────────────────────┘');
    print('');

    _listTasksForSelection();

    final taskId = _getTaskIdFromUser('Enter task ID to toggle: ');
    if (taskId == null) return;

    if (_todoManager.toggleTask(taskId)) {
      final task = _todoManager.findTaskById(taskId);
      print('✅ Task status toggled!');
      print('   ${task.toString()}');
    } else {
      print('❌ Task not found.');
    }

    _pauseForUser();
  }

  /// Edit a task
  void _editTask() {
    if (_todoManager.isEmpty) {
      _showEmptyListMessage();
      return;
    }

    _clearScreen();
    _showHeader();
    print('┌─────────────────────────────────────┐');
    print('│              EDIT TASK              │');
    print('└─────────────────────────────────────┘');
    print('');

    _listTasksForSelection();

    final taskId = _getTaskIdFromUser('Enter task ID to edit: ');
    if (taskId == null) return;

    final task = _todoManager.findTaskById(taskId);
    if (task == null) {
      print('❌ Task not found.');
      _pauseForUser();
      return;
    }

    print('Current task:');
    print('   ${task.toString()}');
    print('');

    // Get new title
    stdout.write('Enter new title (press Enter to keep current): ');
    final newTitle = stdin.readLineSync()?.trim();

    // Get new description
    stdout.write('Enter new description (press Enter to keep current): ');
    final newDescription = stdin.readLineSync()?.trim();

    final titleToUpdate = (newTitle?.isNotEmpty == true) ? newTitle : null;
    final descToUpdate = (newDescription != null) ? newDescription : null;

    if (titleToUpdate != null || descToUpdate != null) {
      if (_todoManager.updateTask(
        taskId,
        title: titleToUpdate,
        description: descToUpdate,
      )) {
        print('✅ Task updated successfully!');
        final updatedTask = _todoManager.findTaskById(taskId);
        print('   ${updatedTask.toString()}');
      } else {
        print('❌ Failed to update task.');
      }
    } else {
      print('❌ No changes made.');
    }

    _pauseForUser();
  }

  /// Search tasks
  void _searchTasks() {
    _clearScreen();
    _showHeader();
    print('┌─────────────────────────────────────┐');
    print('│             SEARCH TASKS            │');
    print('└─────────────────────────────────────┘');
    print('');

    stdout.write('Enter search query: ');
    final query = stdin.readLineSync()?.trim();

    if (query == null || query.isEmpty) {
      print('❌ Search query cannot be empty.');
      _pauseForUser();
      return;
    }

    final results = _todoManager.searchTasks(query);

    if (results.isEmpty) {
      print('🔍 No tasks found matching "$query"');
    } else {
      print('🔍 Found ${results.length} task(s) matching "$query":');
      print('─' * 40);
      for (final task in results) {
        _printTask(task);
      }
    }

    _pauseForUser();
  }

  /// Show detailed statistics
  void _showDetailedStatistics() {
    _clearScreen();
    _showHeader();
    print('┌─────────────────────────────────────┐');
    print('│            STATISTICS               │');
    print('└─────────────────────────────────────┘');
    print('');

    final stats = _todoManager.getStatistics();

    print('📊 Task Overview:');
    print('   Total Tasks: ${stats['total']}');
    print('   Completed: ${stats['completed']}');
    print('   Pending: ${stats['pending']}');
    print('   Completion Rate: ${stats['completion_percentage']}%');
    print('');

    if (_todoManager.totalTasks > 0) {
      final todaysTasks = _todoManager.getTodaysTasks();
      print('📅 Today\'s Tasks: ${todaysTasks.length}');

      if (stats['all_completed'] as bool) {
        print('🎉 Congratulations! All tasks completed!');
      }
    }

    _pauseForUser();
  }

  /// Clear completed tasks
  void _clearCompletedTasks() {
    if (_todoManager.completedCount == 0) {
      print('❌ No completed tasks to clear.');
      _pauseForUser();
      return;
    }

    _clearScreen();
    _showHeader();
    print('┌─────────────────────────────────────┐');
    print('│         CLEAR COMPLETED TASKS       │');
    print('└─────────────────────────────────────┘');
    print('');

    print('This will remove ${_todoManager.completedCount} completed task(s).');
    stdout.write('Type "yes" to confirm: ');
    final confirmation = stdin.readLineSync()?.trim().toLowerCase();

    if (confirmation == 'yes') {
      final clearedCount = _todoManager.clearCompleted();
      print('✅ Cleared $clearedCount completed task(s)!');
    } else {
      print('❌ Operation cancelled.');
    }

    _pauseForUser();
  }

  // Helper methods

  void _showHeader() {
    print('📝 TODO LIST MANAGER');
    print('═' * 40);
  }

  void _showStatistics() {
    final total = _todoManager.totalTasks;
    final completed = _todoManager.completedCount;
    final pending = _todoManager.pendingCount;

    print(
      '📊 Tasks: $total total | ✅ $completed completed | 🔄 $pending pending',
    );
  }

  void _printTask(Task task) {
    print('${task.id.toString().padLeft(3)}. ${task.toString()}');
  }

  void _listTasksForSelection() {
    print('Available tasks:');
    print('─' * 40);
    for (final task in _todoManager.allTasks) {
      _printTask(task);
    }
    print('');
  }

  int? _getTaskIdFromUser(String prompt) {
    stdout.write(prompt);
    final input = stdin.readLineSync()?.trim();

    if (input == null || input.isEmpty) {
      print('❌ Please enter a valid task ID.');
      _pauseForUser();
      return null;
    }

    final taskId = int.tryParse(input);
    if (taskId == null) {
      print('❌ Please enter a valid number.');
      _pauseForUser();
      return null;
    }

    return taskId;
  }

  void _showEmptyListMessage() {
    _clearScreen();
    _showHeader();
    print('📭 No tasks found. Add some tasks first!');
    _pauseForUser();
  }

  void _pauseForUser() {
    print('');
    stdout.write('Press Enter to continue...');
    stdin.readLineSync();
  }

  void _clearScreen() {
    // Clear screen for different platforms
    if (Platform.isWindows) {
      Process.runSync('cls', [], runInShell: true);
    } else {
      Process.runSync('clear', [], runInShell: true);
    }
  }

  void _showGoodbye() {
    _clearScreen();
    print('╔══════════════════════════════════════╗');
    print('║            GOODBYE! 👋               ║');
    print('║     Thanks for using TODO Manager    ║');
    print('║        Stay productive! 🚀           ║');
    print('╚══════════════════════════════════════╝');
  }
}
