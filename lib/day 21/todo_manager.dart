import 'task.dart';

/// Manages a collection of tasks and provides business logic
///
/// This class follows the Single Responsibility Principle by focusing
/// solely on task management operations.
class TodoManager {
  // Private list to store tasks - encapsulation
  final List<Task> _tasks = [];

  /// Get all tasks (returns a copy to prevent external modification)
  List<Task> get allTasks => List.unmodifiable(_tasks);

  /// Get only completed tasks
  List<Task> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  /// Get only pending tasks
  List<Task> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  /// Get total number of tasks
  int get totalTasks => _tasks.length;

  /// Get number of completed tasks
  int get completedCount => completedTasks.length;

  /// Get number of pending tasks
  int get pendingCount => pendingTasks.length;

  /// Check if task list is empty
  bool get isEmpty => _tasks.isEmpty;

  /// Check if all tasks are completed
  bool get allCompleted => _tasks.isNotEmpty && pendingCount == 0;

  /// Add a new task
  /// Returns the created task for confirmation
  Task addTask(String title, [String description = '']) {
    if (title.trim().isEmpty) {
      throw ArgumentError('Task title cannot be empty');
    }

    final task = Task(title.trim(), description.trim());
    _tasks.add(task);
    return task;
  }

  /// Add a task object directly
  void addTaskObject(Task task) {
    if (!_tasks.contains(task)) {
      _tasks.add(task);
    }
  }

  /// Remove task by ID
  /// Returns true if task was found and removed
  bool removeTask(int id) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks.removeAt(taskIndex);
      return true;
    }
    return false;
  }

  /// Remove task by object reference
  bool removeTaskObject(Task task) {
    return _tasks.remove(task);
  }

  /// Find task by ID
  Task? findTaskById(int id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Toggle task completion status by ID
  /// Returns true if task was found and toggled
  bool toggleTask(int id) {
    final task = findTaskById(id);
    if (task != null) {
      task.toggle();
      return true;
    }
    return false;
  }

  /// Mark task as complete by ID
  bool completeTask(int id) {
    final task = findTaskById(id);
    if (task != null) {
      task.markComplete();
      return true;
    }
    return false;
  }

  /// Mark task as incomplete by ID
  bool uncompleteTask(int id) {
    final task = findTaskById(id);
    if (task != null) {
      task.markIncomplete();
      return true;
    }
    return false;
  }

  /// Update task title and description
  bool updateTask(int id, {String? title, String? description}) {
    final task = findTaskById(id);
    if (task != null) {
      if (title != null && title.trim().isNotEmpty) {
        task.title = title;
      }
      if (description != null) {
        task.description = description;
      }
      return true;
    }
    return false;
  }

  /// Clear all tasks
  void clearAll() {
    _tasks.clear();
  }

  /// Clear only completed tasks
  int clearCompleted() {
    final completedCount = this.completedCount;
    _tasks.removeWhere((task) => task.isCompleted);
    return completedCount;
  }

  /// Search tasks by title (case-insensitive)
  List<Task> searchTasks(String query) {
    if (query.trim().isEmpty) return [];

    final lowerQuery = query.toLowerCase();
    return _tasks
        .where(
          (task) =>
              task.title.toLowerCase().contains(lowerQuery) ||
              task.description.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }

  /// Get tasks created today
  List<Task> getTodaysTasks() {
    return _tasks.where((task) => task.isCreatedToday).toList();
  }

  /// Get completion percentage
  double get completionPercentage {
    if (_tasks.isEmpty) return 0.0;
    return (completedCount / totalTasks) * 100;
  }

  /// Get summary statistics
  Map<String, dynamic> getStatistics() {
    return {
      'total': totalTasks,
      'completed': completedCount,
      'pending': pendingCount,
      'completion_percentage': completionPercentage.toStringAsFixed(1),
      'all_completed': allCompleted,
    };
  }

  /// Sort tasks by creation date (newest first)
  void sortByDate({bool ascending = false}) {
    _tasks.sort(
      (a, b) =>
          ascending
              ? a.createdAt.compareTo(b.createdAt)
              : b.createdAt.compareTo(a.createdAt),
    );
  }

  /// Sort tasks by title (alphabetically)
  void sortByTitle({bool ascending = true}) {
    _tasks.sort(
      (a, b) =>
          ascending
              ? a.title.toLowerCase().compareTo(b.title.toLowerCase())
              : b.title.toLowerCase().compareTo(a.title.toLowerCase()),
    );
  }

  /// Sort tasks by completion status (completed last by default)
  void sortByStatus({bool completedFirst = false}) {
    _tasks.sort((a, b) {
      if (a.isCompleted == b.isCompleted) return 0;
      if (completedFirst) {
        return a.isCompleted ? -1 : 1;
      } else {
        return a.isCompleted ? 1 : -1;
      }
    });
  }

  /// Export tasks to a simple string format
  String exportToString() {
    final buffer = StringBuffer();
    buffer.writeln('=== TODO LIST EXPORT ===');
    buffer.writeln('Total Tasks: $totalTasks');
    buffer.writeln('Completed: $completedCount');
    buffer.writeln('Pending: $pendingCount');
    buffer.writeln('');

    for (final task in _tasks) {
      buffer.writeln(task.toDetailedString());
      buffer.writeln('---');
    }

    return buffer.toString();
  }

  /// Create sample tasks for testing
  void createSampleTasks() {
    addTask('Learn Dart basics', 'Complete the fundamentals course');
    addTask('Build a console app', 'Create a to-do list manager');
    addTask('Practice OOP concepts', 'Implement classes and methods');

    // Mark first task as completed for demonstration
    if (_tasks.isNotEmpty) {
      _tasks.first.markComplete();
    }
  }
}
