// Basic Callable Classes Examples

/// A simple callable class that acts like a mathematical function
class Multiplier {
  final int factor;

  Multiplier(this.factor);

  // The call method makes this class callable
  int call(int value) {
    return value * factor;
  }
}

/// A callable class that maintains state
class Counter {
  int _count = 0;

  int get count => _count;

  // Call method increments and returns the count
  int call() {
    return ++_count;
  }

  void reset() {
    _count = 0;
  }
}

/// A callable class for string formatting
class Formatter {
  final String prefix;
  final String suffix;

  Formatter({this.prefix = '', this.suffix = ''});

  // Call method formats the input string
  String call(String input) {
    return '$prefix$input$suffix';
  }
}

void main() {
  print('=== Basic Callable Classes Examples ===\n');

  // Example 1: Multiplier
  print('1. Multiplier Example:');
  var doubler = Multiplier(2);
  var tripler = Multiplier(3);

  print('doubler(5) = ${doubler(5)}'); // Output: 10
  print('tripler(4) = ${tripler(4)}'); // Output: 12

  // Example 2: Counter
  print('\n2. Counter Example:');
  var counter = Counter();

  print('counter() = ${counter()}'); // Output: 1
  print('counter() = ${counter()}'); // Output: 2
  print('counter() = ${counter()}'); // Output: 3
  print('Current count: ${counter.count}'); // Output: 3

  counter.reset();
  print('After reset: ${counter()}'); // Output: 1

  // Example 3: Formatter
  print('\n3. Formatter Example:');
  var htmlFormatter = Formatter(prefix: '<b>', suffix: '</b>');
  var bracketFormatter = Formatter(prefix: '[', suffix: ']');

  print('htmlFormatter("Hello") = ${htmlFormatter("Hello")}');
  print('bracketFormatter("World") = ${bracketFormatter("World")}');
}
