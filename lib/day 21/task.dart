/// Represents a single task in the to-do list
///
/// This class encapsulates all the properties and behaviors
/// of a task item, following object-oriented principles.
class Task {
  // Private fields - encapsulation principle
  String _title;
  String _description;
  bool _isCompleted;
  DateTime _createdAt;
  int _id;

  // Static counter for generating unique IDs
  static int _nextId = 1;

  /// Default constructor
  Task(this._title, [this._description = ''])
    : _isCompleted = false,
      _createdAt = DateTime.now(),
      _id = _nextId++ {
    // Validation in constructor
    if (_title.trim().isEmpty) {
      throw ArgumentError('Task title cannot be empty');
    }
  }

  /// Named constructor for creating completed tasks
  Task.completed(this._title, [this._description = ''])
    : _isCompleted = true,
      _createdAt = DateTime.now(),
      _id = _nextId++;

  /// Named constructor for creating task with specific completion status
  Task.withStatus(this._title, this._isCompleted, [this._description = ''])
    : _createdAt = DateTime.now(),
      _id = _nextId++;

  // Getters - controlled access to private fields
  int get id => _id;
  String get title => _title;
  String get description => _description;
  bool get isCompleted => _isCompleted;
  DateTime get createdAt => _createdAt;

  // Setters with validation
  set title(String newTitle) {
    if (newTitle.trim().isEmpty) {
      throw ArgumentError('Task title cannot be empty');
    }
    _title = newTitle.trim();
  }

  set description(String newDescription) {
    _description = newDescription.trim();
  }

  /// Mark task as completed
  void markComplete() {
    _isCompleted = true;
  }

  /// Mark task as incomplete
  void markIncomplete() {
    _isCompleted = false;
  }

  /// Toggle completion status
  void toggle() {
    _isCompleted = !_isCompleted;
  }

  /// Get status as a string
  String get status => _isCompleted ? 'Completed' : 'Pending';

  /// Get status symbol for display
  String get statusSymbol => _isCompleted ? '✓' : '○';

  /// Check if task was created today
  bool get isCreatedToday {
    final now = DateTime.now();
    return _createdAt.year == now.year &&
        _createdAt.month == now.month &&
        _createdAt.day == now.day;
  }

  /// Get formatted creation date
  String get formattedDate {
    return '${_createdAt.day}/${_createdAt.month}/${_createdAt.year}';
  }

  /// Create a copy of this task
  Task copy() {
    return Task.withStatus(_title, _isCompleted, _description);
  }

  /// Convert task to string representation
  @override
  String toString() {
    final desc = _description.isNotEmpty ? ' - $_description' : '';
    return '[$statusSymbol] $_title$desc';
  }

  /// Detailed string representation
  String toDetailedString() {
    final buffer = StringBuffer();
    buffer.writeln('ID: $_id');
    buffer.writeln('Title: $_title');
    if (_description.isNotEmpty) {
      buffer.writeln('Description: $_description');
    }
    buffer.writeln('Status: $status');
    buffer.writeln('Created: $formattedDate');
    return buffer.toString();
  }

  /// Check equality based on ID
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task && other._id == _id;
  }

  /// Hash code based on ID
  @override
  int get hashCode => _id.hashCode;
}
