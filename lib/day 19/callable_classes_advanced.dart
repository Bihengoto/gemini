// Advanced Callable Classes Examples

/// A callable class that acts as a validator
class Validator {
  final List<String Function(String)> _rules = [];

  // Add validation rules
  void addRule(String Function(String) rule) {
    _rules.add(rule);
  }

  // Call method validates input against all rules
  List<String> call(String input) {
    List<String> errors = [];
    for (var rule in _rules) {
      String result = rule(input);
      if (result.isNotEmpty) {
        errors.add(result);
      }
    }
    return errors;
  }
}

/// A callable class for mathematical operations
class MathOperation {
  final String name;
  final double Function(double, double) operation;

  MathOperation(this.name, this.operation);

  // Call method performs the operation
  double call(double a, double b) {
    return operation(a, b);
  }

  @override
  String toString() => name;
}

/// A callable class that caches results
class CachedFunction<T, R> {
  final R Function(T) _function;
  final Map<T, R> _cache = {};

  CachedFunction(this._function);

  // Call method with caching
  R call(T input) {
    if (_cache.containsKey(input)) {
      print('Cache hit for: $input');
      return _cache[input]!;
    }

    print('Computing for: $input');
    R result = _function(input);
    _cache[input] = result;
    return result;
  }

  void clearCache() {
    _cache.clear();
  }

  int get cacheSize => _cache.length;
}

/// A callable class for event handling
class EventHandler<T> {
  final List<void Function(T)> _listeners = [];

  void addListener(void Function(T) listener) {
    _listeners.add(listener);
  }

  void removeListener(void Function(T) listener) {
    _listeners.remove(listener);
  }

  // Call method triggers all listeners
  void call(T event) {
    for (var listener in _listeners) {
      listener(event);
    }
  }

  int get listenerCount => _listeners.length;
}

void main() {
  print('=== Advanced Callable Classes Examples ===\n');

  // Example 1: Validator
  print('1. Validator Example:');
  var emailValidator = Validator();

  emailValidator.addRule(
    (input) => input.contains('@') ? '' : 'Email must contain @',
  );
  emailValidator.addRule(
    (input) => input.length >= 5 ? '' : 'Email must be at least 5 characters',
  );

  var errors1 = emailValidator('test');
  var errors2 = emailValidator('test@example.com');

  print('Errors for "test": $errors1');
  print('Errors for "test@example.com": $errors2');

  // Example 2: Math Operations
  print('\n2. Math Operations Example:');
  var add = MathOperation('Addition', (a, b) => a + b);
  var multiply = MathOperation('Multiplication', (a, b) => a * b);

  print('${add.name}: ${add(5, 3)}');
  print('${multiply.name}: ${multiply(4, 7)}');

  // Example 3: Cached Function
  print('\n3. Cached Function Example:');
  var expensiveFunction = CachedFunction<int, int>((n) {
    // Simulate expensive computation
    return n * n * n;
  });

  print('Result 1: ${expensiveFunction(5)}');
  print('Result 2: ${expensiveFunction(5)}'); // Cache hit
  print('Result 3: ${expensiveFunction(3)}');
  print('Cache size: ${expensiveFunction.cacheSize}');

  // Example 4: Event Handler
  print('\n4. Event Handler Example:');
  var buttonClickHandler = EventHandler<String>();

  buttonClickHandler.addListener((event) => print('Listener 1: $event'));
  buttonClickHandler.addListener(
    (event) => print('Listener 2: $event clicked!'),
  );

  buttonClickHandler('Button A');
  print('Listeners count: ${buttonClickHandler.listenerCount}');
}
