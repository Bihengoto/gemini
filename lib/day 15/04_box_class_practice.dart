/*
 * Day 15: Practice - Generic Box Class
 * 
 * This file contains the practice exercise: Create a generic Box class
 * that can hold any type of object with various useful methods.
 */

void main() {
  print('=== Generic Box Class Practice ===');

  demonstrateBasicBox();
  demonstrateBoxOperations();
  demonstrateBoxComparison();
  demonstrateBoxTransformation();
  demonstrateSpecializedBoxes();
}

/// A generic Box class that can hold any type of object
class Box<T> {
  T? _content;
  final String _label;
  final DateTime _createdAt;

  // Constructor
  Box(this._content, {String label = 'Unlabeled'})
    : _label = label,
      _createdAt = DateTime.now();

  // Named constructor for empty box
  Box.empty({String label = 'Empty Box'})
    : _content = null,
      _label = label,
      _createdAt = DateTime.now();

  // Getters
  T? get content => _content;
  String get label => _label;
  DateTime get createdAt => _createdAt;
  bool get isEmpty => _content == null;
  bool get isNotEmpty => _content != null;

  // Methods
  void put(T item) {
    _content = item;
  }

  T? take() {
    T? item = _content;
    _content = null;
    return item;
  }

  T? peek() => _content;

  void clear() {
    _content = null;
  }

  // Transform the content to another type
  Box<U> transform<U>(U Function(T) transformer) {
    if (_content == null) {
      return Box<U>.empty(label: 'Transformed $_label');
    }
    return Box<U>(transformer(_content!), label: 'Transformed $_label');
  }

  // Apply a function to the content if it exists
  void ifPresent(void Function(T) action) {
    if (_content != null) {
      action(_content!);
    }
  }

  // Get content or return default value
  T orElse(T defaultValue) {
    return _content ?? defaultValue;
  }

  // Check if content matches a condition
  bool matches(bool Function(T) predicate) {
    return _content != null && predicate(_content!);
  }

  @override
  String toString() {
    return 'Box<${T.toString()}>($_label: ${_content ?? 'empty'})';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Box<T> &&
        other._content == _content &&
        other._label == _label;
  }

  @override
  int get hashCode => Object.hash(_content, _label);
}

/// Specialized Box for numbers with mathematical operations
class NumberBox<T extends num> extends Box<T> {
  NumberBox(T content, {String label = 'Number Box'})
    : super(content, label: label);
  NumberBox.empty({String label = 'Empty Number Box'})
    : super.empty(label: label);

  // Mathematical operations
  NumberBox<T> add(T value) {
    if (_content == null)
      return NumberBox<T>.empty(label: 'Result of $label + $value');
    return NumberBox<T>(
      (_content! + value) as T,
      label: 'Result of $label + $value',
    );
  }

  NumberBox<T> multiply(T value) {
    if (_content == null)
      return NumberBox<T>.empty(label: 'Result of $label * $value');
    return NumberBox<T>(
      (_content! * value) as T,
      label: 'Result of $label * $value',
    );
  }

  bool isPositive() => _content != null && _content! > 0;
  bool isNegative() => _content != null && _content! < 0;
  bool isZero() => _content != null && _content! == 0;
}

/// Specialized Box for collections
class CollectionBox<T> extends Box<List<T>> {
  CollectionBox(List<T> content, {String label = 'Collection Box'})
    : super(content, label: label);
  CollectionBox.empty({String label = 'Empty Collection Box'})
    : super.empty(label: label);

  // Collection-specific operations
  void addItem(T item) {
    if (_content == null) {
      _content = [item];
    } else {
      _content!.add(item);
    }
  }

  void addAll(List<T> items) {
    if (_content == null) {
      _content = List.from(items);
    } else {
      _content!.addAll(items);
    }
  }

  T? removeFirst() {
    if (_content == null || _content!.isEmpty) return null;
    return _content!.removeAt(0);
  }

  int get size => _content?.length ?? 0;
  bool get isEmptyCollection => _content?.isEmpty ?? true;

  List<T> get items => _content != null ? List.unmodifiable(_content!) : [];
}

void demonstrateBasicBox() {
  print('\n--- Basic Box Operations ---');

  // Create boxes with different types
  var stringBox = Box<String>('Hello, World!', label: 'Greeting Box');
  var intBox = Box<int>(42, label: 'Answer Box');
  var boolBox = Box<bool>(true, label: 'Truth Box');
  var emptyBox = Box<String>.empty(label: 'Empty String Box');

  print('String box: $stringBox');
  print('Int box: $intBox');
  print('Bool box: $boolBox');
  print('Empty box: $emptyBox');

  // Check if boxes are empty
  print('String box is empty: ${stringBox.isEmpty}');
  print('Empty box is empty: ${emptyBox.isEmpty}');

  // Peek at content
  print('String box content: ${stringBox.peek()}');
  print('Empty box content: ${emptyBox.peek()}');
}

void demonstrateBoxOperations() {
  print('\n--- Box Operations ---');

  var box = Box<String>.empty(label: 'Dynamic Box');
  print('Initial: $box');

  // Put something in the box
  box.put('First item');
  print('After putting: $box');

  // Take item out
  String? item = box.take();
  print('Taken item: $item');
  print('After taking: $box');

  // Put something else
  box.put('Second item');
  print('After putting again: $box');

  // Clear the box
  box.clear();
  print('After clearing: $box');
}

void demonstrateBoxComparison() {
  print('\n--- Box Comparison and Conditions ---');

  var box1 = Box<int>(10, label: 'Box 1');
  var box2 = Box<int>(10, label: 'Box 1');
  var box3 = Box<int>(20, label: 'Box 3');

  print('Box 1: $box1');
  print('Box 2: $box2');
  print('Box 3: $box3');

  print('Box 1 == Box 2: ${box1 == box2}');
  print('Box 1 == Box 3: ${box1 == box3}');

  // Using orElse
  var emptyBox = Box<int>.empty();
  print('Empty box or else 0: ${emptyBox.orElse(0)}');
  print('Box 1 or else 0: ${box1.orElse(0)}');

  // Using matches
  print('Box 1 matches (> 5): ${box1.matches((x) => x > 5)}');
  print('Box 3 matches (even): ${box3.matches((x) => x % 2 == 0)}');
}

void demonstrateBoxTransformation() {
  print('\n--- Box Transformation ---');

  var intBox = Box<int>(42, label: 'Number Box');
  print('Original: $intBox');

  // Transform int to string
  var stringBox = intBox.transform<String>((x) => 'Number: $x');
  print('Transformed to string: $stringBox');

  // Transform string to length
  var lengthBox = stringBox.transform<int>((s) => s.length);
  print('Transformed to length: $lengthBox');

  // Chain transformations
  var chainedBox = Box<double>(3.14159, label: 'Pi Box')
      .transform<String>((d) => d.toStringAsFixed(2))
      .transform<int>((s) => s.length);
  print('Chained transformation: $chainedBox');

  // Using ifPresent
  intBox.ifPresent((value) => print('Box contains: $value'));
  Box<int>.empty().ifPresent((value) => print('This won\'t print'));
}

void demonstrateSpecializedBoxes() {
  print('\n--- Specialized Boxes ---');

  // NumberBox
  var numberBox = NumberBox<int>(10, label: 'Math Box');
  print('Number box: $numberBox');
  print('Is positive: ${numberBox.isPositive()}');

  var addedBox = numberBox.add(5);
  var multipliedBox = numberBox.multiply(3);
  print('After adding 5: $addedBox');
  print('After multiplying by 3: $multipliedBox');

  // CollectionBox
  var collectionBox = CollectionBox<String>([
    'apple',
    'banana',
  ], label: 'Fruit Box');
  print('Collection box: $collectionBox');
  print('Size: ${collectionBox.size}');

  collectionBox.addItem('cherry');
  collectionBox.addAll(['date', 'elderberry']);
  print('After adding items: $collectionBox');
  print('Items: ${collectionBox.items}');

  String? firstFruit = collectionBox.removeFirst();
  print('Removed first: $firstFruit');
  print('After removal: $collectionBox');
}
