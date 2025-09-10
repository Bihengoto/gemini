// Common Getter and Setter Patterns in Dart

// Pattern 1: Simple Property Access
class SimpleProperty {
  String _value;

  SimpleProperty(this._value);

  String get value => _value;
  set value(String newValue) => _value = newValue;
}

// Pattern 2: Validation in Setters
class ValidatedProperty {
  String _email;

  ValidatedProperty(this._email) {
    if (!_isValidEmail(_email)) {
      throw ArgumentError('Invalid email format');
    }
  }

  String get email => _email;

  set email(String value) {
    if (_isValidEmail(value)) {
      _email = value;
    } else {
      throw ArgumentError('Invalid email format');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

// Pattern 3: Computed Properties
class ComputedProperties {
  String _firstName;
  String _lastName;
  DateTime _birthDate;

  ComputedProperties(this._firstName, this._lastName, this._birthDate);

  String get firstName => _firstName;
  set firstName(String value) => _firstName = value;

  String get lastName => _lastName;
  set lastName(String value) => _lastName = value;

  DateTime get birthDate => _birthDate;
  set birthDate(DateTime value) => _birthDate = value;

  // Computed properties
  String get fullName => '$_firstName $_lastName';
  int get age => DateTime.now().difference(_birthDate).inDays ~/ 365;
  String get ageGroup {
    int currentAge = age;
    if (currentAge < 13) return 'Child';
    if (currentAge < 20) return 'Teenager';
    if (currentAge < 60) return 'Adult';
    return 'Senior';
  }
}

// Pattern 4: Lazy Loading
class LazyLoading {
  String _data;
  String? _processedData;

  LazyLoading(this._data);

  String get data => _data;

  set data(String value) {
    _data = value;
    _processedData = null; // Clear cache when data changes
  }

  // Expensive operation - only computed when needed
  String get processedData {
    _processedData ??= _expensiveProcessing(_data);
    return _processedData!;
  }

  String _expensiveProcessing(String input) {
    // Simulate expensive operation
    return input.toUpperCase().split('').reversed.join();
  }
}

// Pattern 5: Transformation in Getters/Setters
class TransformationPattern {
  List<String> _items = [];

  // Getter returns immutable view
  List<String> get items => List.unmodifiable(_items);

  // Setter accepts various formats
  set items(dynamic value) {
    if (value is List<String>) {
      _items = List.from(value);
    } else if (value is String) {
      _items = value.split(',').map((s) => s.trim()).toList();
    } else {
      throw ArgumentError(
        'Items must be List<String> or comma-separated String',
      );
    }
  }

  // Additional convenience setters
  set itemsFromString(String csvString) {
    items = csvString; // Uses the main setter
  }

  set itemsFromList(List<String> list) {
    items = list; // Uses the main setter
  }

  // Computed properties
  int get count => _items.length;
  bool get isEmpty => _items.isEmpty;
  bool get isNotEmpty => _items.isNotEmpty;
  String get asString => _items.join(', ');
}

// Pattern 6: State Management with Getters/Setters
enum Status { pending, processing, completed, failed }

class StateMachine {
  Status _status = Status.pending;
  String? _errorMessage;
  DateTime? _completedAt;

  Status get status => _status;

  set status(Status newStatus) {
    switch (newStatus) {
      case Status.pending:
        _errorMessage = null;
        _completedAt = null;
        break;
      case Status.processing:
        _errorMessage = null;
        _completedAt = null;
        break;
      case Status.completed:
        _errorMessage = null;
        _completedAt = DateTime.now();
        break;
      case Status.failed:
        _completedAt = null;
        // Error message should be set separately
        break;
    }
    _status = newStatus;
  }

  String? get errorMessage => _errorMessage;

  set errorMessage(String? message) {
    _errorMessage = message;
    if (message != null) {
      _status = Status.failed;
    }
  }

  DateTime? get completedAt => _completedAt;

  // Computed properties
  bool get isCompleted => _status == Status.completed;
  bool get isFailed => _status == Status.failed;
  bool get isInProgress => _status == Status.processing;

  Duration? get processingTime {
    if (_completedAt != null) {
      // This is simplified - in real app you'd track start time
      return Duration(seconds: 5); // Mock processing time
    }
    return null;
  }
}

void main() {
  print('=== Simple Property ===');
  var simple = SimpleProperty('Hello');
  print('Value: ${simple.value}');
  simple.value = 'World';
  print('Updated: ${simple.value}');

  print('\n=== Validated Property ===');
  var validated = ValidatedProperty('user@example.com');
  print('Email: ${validated.email}');

  try {
    validated.email = 'invalid-email';
  } catch (e) {
    print('Validation error: $e');
  }

  print('\n=== Computed Properties ===');
  var person = ComputedProperties('John', 'Doe', DateTime(1990, 5, 15));
  print('Full name: ${person.fullName}');
  print('Age: ${person.age}');
  print('Age group: ${person.ageGroup}');

  print('\n=== Lazy Loading ===');
  var lazy = LazyLoading('hello world');
  print('Original: ${lazy.data}');
  print('Processed: ${lazy.processedData}'); // First calculation
  print('Processed again: ${lazy.processedData}'); // Uses cached value

  print('\n=== Transformation Pattern ===');
  var transform = TransformationPattern();
  transform.items = 'apple, banana, cherry';
  print('Items: ${transform.items}');
  print('Count: ${transform.count}');
  print('As string: ${transform.asString}');

  transform.items = ['orange', 'grape', 'kiwi'];
  print('Updated items: ${transform.items}');

  print('\n=== State Machine ===');
  var machine = StateMachine();
  print('Initial status: ${machine.status}');

  machine.status = Status.processing;
  print('Processing: ${machine.isInProgress}');

  machine.status = Status.completed;
  print('Completed: ${machine.isCompleted}');
  print('Completed at: ${machine.completedAt}');

  machine.errorMessage = 'Something went wrong';
  print('Failed: ${machine.isFailed}');
  print('Error: ${machine.errorMessage}');
}
