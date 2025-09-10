// Day 25: Review of Difficult Dart Concepts
// This file covers commonly challenging concepts in Dart

void main() async {
  print('=== DIFFICULT DART CONCEPTS REVIEW ===\n');
  
  // Null safety and nullable types
  nullSafetyReview();
  
  // Generics and type parameters
  genericsReview();
  
  // Mixins and multiple inheritance
  mixinsReview();
  
  // Extension methods
  extensionMethodsReview();
  
  // Async/await and Future handling
  await asyncAwaitReview();
  
  // Stream handling and transformations
  await streamHandlingReview();
  
  // Memory management and weak references
  memoryManagementReview();
  
  // Isolates and concurrency
  await isolatesReview();
  
  // Advanced OOP concepts
  advancedOOPReview();
  
  // Functional programming concepts
  functionalProgrammingReview();
}

// 1. Null Safety and Nullable Types
void nullSafetyReview() {
  print('1. NULL SAFETY AND NULLABLE TYPES');
  print('----------------------------------');
  
  // Non-nullable vs nullable types
  String nonNullable = 'Hello'; // Cannot be null
  String? nullable = null; // Can be null
  
  print('Non-nullable: $nonNullable');
  print('Nullable: $nullable');
  
  // Null-aware operators
  String? name;
  
  // Null-aware access (?.)
  int? length = name?.length;
  print('Length with null-aware: $length');
  
  // Null coalescing (??)
  String displayName = name ?? 'Anonymous';
  print('Display name: $displayName');
  
  // Null assignment (??=)
  name ??= 'Default Name';
  print('Name after null assignment: $name');
  
  // Null assertion (!)
  String? definitelyNotNull = 'Definitely not null';
  String assertedString = definitelyNotNull!; // Use with caution!
  print('Asserted string: $assertedString');
  
  // Late variables
  late String lateInitialized;
  // lateInitialized = 'Initialized later'; // Must initialize before use
  
  // Null-aware cascade (.?..)
  List<String>? nullableList;
  nullableList
    ?..add('Item 1')
    ..add('Item 2');
  print('Nullable list after cascade: $nullableList');
  
  // Pattern matching with null
  String? getValue() => null;
  
  switch (getValue()) {
    case String value:
      print('Got string: $value');
      break;
    case null:
      print('Got null value');
      break;
  }
  
  // Null-aware spread operator
  List<String>? optionalList = ['a', 'b'];
  List<String> combinedList = ['start', ...?optionalList, 'end'];
  print('Combined list: $combinedList');
  
  print('');
}

// 2. Generics and Type Parameters
void genericsReview() {
  print('2. GENERICS AND TYPE PARAMETERS');
  print('-------------------------------');
  
  // Generic classes
  Box<String> stringBox = Box<String>('Hello');
  Box<int> intBox = Box<int>(42);
  
  print('String box: ${stringBox.getValue()}');
  print('Int box: ${intBox.getValue()}');
  
  // Generic methods
  T getFirst<T>(List<T> list) {
    return list.first;
  }
  
  String firstString = getFirst<String>(['a', 'b', 'c']);
  int firstInt = getFirst([1, 2, 3]); // Type inference
  print('First string: $firstString');
  print('First int: $firstInt');
  
  // Bounded generics
  NumberBox<int> intNumberBox = NumberBox<int>(100);
  NumberBox<double> doubleNumberBox = NumberBox<double>(3.14);
  
  print('Int number box doubled: ${intNumberBox.double()}');
  print('Double number box doubled: ${doubleNumberBox.double()}');
  
  // Generic constraints with multiple bounds
  ComparableBox<String> stringComparableBox = ComparableBox<String>('hello');
  print('String comparable: ${stringComparableBox.compare('world')}');
  
  // Covariance and contravariance
  List<Animal> animals = <Dog>[Dog('Buddy')]; // Covariant
  animals.forEach((animal) => animal.makeSound());
  
  // Generic type aliases
  typedef StringMap<T> = Map<String, T>;
  StringMap<int> scores = {'Alice': 100, 'Bob': 85};
  print('Scores: $scores');
  
  // Generic functions with multiple type parameters
  Pair<String, int> pair = createPair<String, int>('Age', 25);
  print('Pair: ${pair.first}, ${pair.second}');
  
  print('');
}

// Generic classes and methods for the examples above
class Box<T> {
  final T _value;
  Box(this._value);
  T getValue() => _value;
}

class NumberBox<T extends num> {
  final T _value;
  NumberBox(this._value);
  T double() => (_value * 2) as T;
}

class ComparableBox<T extends Comparable<T>> {
  final T _value;
  ComparableBox(this._value);
  int compare(T other) => _value.compareTo(other);
}

class Pair<T, U> {
  final T first;
  final U second;
  Pair(this.first, this.second);
}

Pair<T, U> createPair<T, U>(T first, U second) => Pair(first, second);

class Animal {
  void makeSound() => print('Some animal sound');
}

class Dog extends Animal {
  final String name;
  Dog(this.name);
  
  @override
  void makeSound() => print('$name barks');
}

// 3. Mixins and Multiple Inheritance
void mixinsReview() {
  print('3. MIXINS AND MULTIPLE INHERITANCE');
  print('----------------------------------');
  
  // Using mixins
  FlyingCar flyingCar = FlyingCar();
  flyingCar.drive();
  flyingCar.fly();
  flyingCar.startEngine();
  
  // Mixin with super calls
  SmartPhone phone = SmartPhone();
  phone.makeCall();
  phone.connectToInternet();
  phone.takePicture();
  
  // Mixin constraints
  ElectricCar electricCar = ElectricCar();
  electricCar.drive();
  electricCar.charge();
  
  print('');
}

// Mixin examples
mixin Flyable {
  void fly() => print('Flying through the air');
}

mixin Drivable {
  void drive() => print('Driving on the road');
}

mixin Engine {
  void startEngine() => print('Engine started');
}

class FlyingCar with Drivable, Flyable, Engine {}

// Mixin with super calls
mixin Callable {
  void makeCall() {
    print('Making a call');
  }
}

mixin InternetConnectable {
  void connectToInternet() {
    print('Connecting to internet');
  }
}

mixin Camera {
  void takePicture() {
    print('Taking a picture');
  }
}

class SmartPhone with Callable, InternetConnectable, Camera {}

// Mixin with constraints
mixin Electric on Vehicle {
  void charge() => print('Charging battery');
}

abstract class Vehicle {
  void drive();
}

class ElectricCar extends Vehicle with Electric {
  @override
  void drive() => print('Driving electric car');
}

// 4. Extension Methods
void extensionMethodsReview() {
  print('4. EXTENSION METHODS');
  print('--------------------');
  
  // String extensions
  String text = 'hello world';
  print('Capitalized: ${text.capitalize()}');
  print('Is palindrome: ${text.isPalindrome()}');
  print('Word count: ${text.wordCount()}');
  
  // Number extensions
  int number = 5;
  print('$number factorial: ${number.factorial()}');
  print('$number is even: ${number.isEven}');
  print('$number squared: ${number.squared()}');
  
  // List extensions
  List<int> numbers = [1, 2, 3, 4, 5];
  print('Sum: ${numbers.sum()}');
  print('Average: ${numbers.average()}');
  print('Second element: ${numbers.secondOrNull}');
  
  // DateTime extensions
  DateTime now = DateTime.now();
  print('Is today weekend: ${now.isWeekend}');
  print('Days until new year: ${now.daysUntilNewYear()}');
  
  print('');
}

// Extension method definitions
extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  bool isPalindrome() {
    String cleaned = toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return cleaned == cleaned.split('').reversed.join('');
  }
  
  int wordCount() => split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
}

extension IntExtensions on int {
  int factorial() {
    if (this <= 1) return 1;
    return this * (this - 1).factorial();
  }
  
  int squared() => this * this;
}

extension ListExtensions<T extends num> on List<T> {
  T sum() => reduce((a, b) => (a + b) as T);
  double average() => sum() / length;
}

extension ListSafeAccess<T> on List<T> {
  T? get secondOrNull => length > 1 ? this[1] : null;
}

extension DateTimeExtensions on DateTime {
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
  
  int daysUntilNewYear() {
    DateTime newYear = DateTime(year + 1, 1, 1);
    return newYear.difference(this).inDays;
  }
}

// 5. Async/Await and Future Handling
Future<void> asyncAwaitReview() async {
  print('5. ASYNC/AWAIT AND FUTURE HANDLING');
  print('-----------------------------------');
  
  // Basic async/await
  String result = await fetchData();
  print('Fetched data: $result');
  
  // Error handling with try-catch
  try {
    String riskyResult = await riskyOperation();
    print('Risky result: $riskyResult');
  } catch (e) {
    print('Caught error: $e');
  }
  
  // Multiple async operations
  List<String> results = await Future.wait([
    fetchData(),
    fetchData(),
    fetchData(),
  ]);
  print('Multiple results: $results');
  
  // Async with timeout
  try {
    String timeoutResult = await fetchSlowData().timeout(Duration(seconds: 1));
    print('Timeout result: $timeoutResult');
  } on TimeoutException {
    print('Operation timed out');
  }
  
  // Future chaining vs async/await
  String chainedResult = await fetchData()
      .then((data) => processData(data))
      .then((processed) => finalizeData(processed));
  print('Chained result: $chainedResult');
  
  // Equivalent with async/await
  String data = await fetchData();
  String processed = await processData(data);
  String finalized = await finalizeData(processed);
  print('Sequential result: $finalized');
  
  // Parallel vs sequential execution
  Stopwatch stopwatch = Stopwatch()..start();
  
  // Sequential (slower)
  await fetchData();
  await fetchData();
  await fetchData();
  int sequentialTime = stopwatch.elapsedMilliseconds;
  
  stopwatch.reset();
  
  // Parallel (faster)
  await Future.wait([
    fetchData(),
    fetchData(),
    fetchData(),
  ]);
  int parallelTime = stopwatch.elapsedMilliseconds;
  
  print('Sequential time: ${sequentialTime}ms');
  print('Parallel time: ${parallelTime}ms');
  
  print('');
}

// Helper functions for async examples
Future<String> fetchData() async {
  await Future.delayed(Duration(milliseconds: 100));
  return 'Data fetched';
}

Future<String> fetchSlowData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Slow data fetched';
}

Future<String> riskyOperation() async {
  await Future.delayed(Duration(milliseconds: 50));
  throw Exception('Something went wrong');
}

Future<String> processData(String data) async {
  await Future.delayed(Duration(milliseconds: 50));
  return 'Processed: $data';
}

Future<String> finalizeData(String data) async {
  await Future.delayed(Duration(milliseconds: 50));
  return 'Finalized: $data';
}

// 6. Stream Handling and Transformations
Future<void> streamHandlingReview() async {
  print('6. STREAM HANDLING AND TRANSFORMATIONS');
  print('--------------------------------------');
  
  // Basic stream consumption
  Stream<int> numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);
  await for (int number in numberStream) {
    print('Number: $number');
  }
  
  // Stream transformations
  Stream<String> transformedStream = Stream.fromIterable([1, 2, 3, 4, 5])
      .where((n) => n % 2 == 0)
      .map((n) => 'Even: $n')
      .take(2);
  
  List<String> transformedList = await transformedStream.toList();
  print('Transformed: $transformedList');
  
  // Stream with error handling
  Stream<int> errorStream = Stream.fromIterable([1, 2, 3])
      .asyncMap((n) async {
        if (n == 2) throw Exception('Error at $n');
        return n * 10;
      });
  
  await for (int value in errorStream.handleError((error) {
    print('Stream error handled: $error');
  })) {
    print('Stream value: $value');
  }
  
  // Custom stream transformer
  StreamTransformer<int, String> customTransformer = 
      StreamTransformer<int, String>.fromHandlers(
    handleData: (int data, EventSink<String> sink) {
      sink.add('Custom: ${data * 2}');
    },
    handleError: (Object error, StackTrace stackTrace, EventSink<String> sink) {
      sink.add('Error: $error');
    },
  );
  
  Stream<String> customTransformed = Stream.fromIterable([1, 2, 3])
      .transform(customTransformer);
  
  await for (String value in customTransformed) {
    print('Custom transformed: $value');
  }
  
  // Broadcast streams
  Stream<int> broadcastStream = Stream.periodic(
    Duration(milliseconds: 100),
    (count) => count,
  ).take(3).asBroadcastStream();
  
  // Multiple listeners
  broadcastStream.listen((data) => print('Listener 1: $data'));
  broadcastStream.listen((data) => print('Listener 2: $data'));
  
  await Future.delayed(Duration(milliseconds: 400));
  
  print('');
}

// 7. Memory Management and Weak References
void memoryManagementReview() {
  print('7. MEMORY MANAGEMENT AND WEAK REFERENCES');
  print('----------------------------------------');
  
  // Dart uses garbage collection, but understanding references is important
  
  // Strong references (normal references)
  List<String> strongList = ['item1', 'item2', 'item3'];
  List<String> anotherReference = strongList; // Strong reference
  
  print('Strong list: $strongList');
  print('Another reference: $anotherReference');
  
  // Weak references (using WeakReference)
  Object target = 'Target object';
  WeakReference<Object> weakRef = WeakReference(target);
  
  print('Weak reference target: ${weakRef.target}');
  
  // The target can be garbage collected even if weakRef exists
  // target = null; // Remove strong reference
  // After GC, weakRef.target might be null
  
  // Finalizers for cleanup
  Object resourceOwner = 'Resource owner';
  Finalizer<String> finalizer = Finalizer<String>((String value) {
    print('Finalizer called for: $value');
    // Cleanup code here
  });
  
  finalizer.attach(resourceOwner, 'Resource cleanup data');
  
  // Memory-efficient patterns
  
  // 1. Use const constructors when possible
  const List<int> constList = [1, 2, 3]; // Shared instance
  
  // 2. Avoid memory leaks with listeners
  // Always cancel subscriptions and close streams
  
  // 3. Use object pools for frequently created objects
  ObjectPool<StringBuilder> stringBuilderPool = ObjectPool<StringBuilder>(
    () => StringBuilder(),
    (sb) => sb.clear(),
  );
  
  StringBuilder sb = stringBuilderPool.acquire();
  sb.write('Hello');
  sb.write(' World');
  print('String builder result: ${sb.toString()}');
  stringBuilderPool.release(sb);
  
  print('');
}

// Helper classes for memory management examples
class StringBuilder {
  final StringBuffer _buffer = StringBuffer();
  
  void write(String text) => _buffer.write(text);
  void clear() => _buffer.clear();
  
  @override
  String toString() => _buffer.toString();
}

class ObjectPool<T> {
  final List<T> _pool = [];
  final T Function() _factory;
  final void Function(T) _reset;
  
  ObjectPool(this._factory, this._reset);
  
  T acquire() {
    if (_pool.isNotEmpty) {
      return _pool.removeLast();
    }
    return _factory();
  }
  
  void release(T object) {
    _reset(object);
    _pool.add(object);
  }
}

// 8. Isolates and Concurrency
Future<void> isolatesReview() async {
  print('8. ISOLATES AND CONCURRENCY');
  print('---------------------------');
  
  // Note: Full isolate examples require more setup
  // This shows the concepts and patterns
  
  print('Main isolate: ${Isolate.current.debugName}');
  
  // Compute function for CPU-intensive tasks
  int result = await compute(heavyComputation, 1000000);
  print('Heavy computation result: $result');
  
  // Isolate communication patterns would involve:
  // 1. Spawning isolates with Isolate.spawn()
  // 2. Setting up ReceivePorts and SendPorts
  // 3. Sending messages between isolates
  // 4. Handling isolate lifecycle
  
  print('Isolates provide true parallelism in Dart');
  print('Each isolate has its own memory heap');
  print('Communication happens via message passing');
  
  print('');
}

// Heavy computation function for compute example
int heavyComputation(int n) {
  int sum = 0;
  for (int i = 1; i <= n; i++) {
    sum += i;
  }
  return sum;
}

// Mock compute function (simplified)
Future<R> compute<Q, R>(R Function(Q) callback, Q message) async {
  // In real Dart, this would run in a separate isolate
  return callback(message);
}

class Isolate {
  static Isolate current = Isolate._();
  String? debugName = 'main';
  
  Isolate._();
}

// 9. Advanced OOP Concepts
void advancedOOPReview() {
  print('9. ADVANCED OOP CONCEPTS');
  print('------------------------');
  
  // Abstract classes and interfaces
  Shape circle = Circle(5);
  Shape rectangle = Rectangle(4, 6);
  
  print('Circle area: ${circle.area()}');
  print('Rectangle area: ${rectangle.area()}');
  
  // Polymorphism
  List<Shape> shapes = [circle, rectangle];
  for (Shape shape in shapes) {
    print('Shape area: ${shape.area()}');
    shape.draw(); // Polymorphic method call
  }
  
  // Factory constructors
  Logger fileLogger = Logger.file('app.log');
  Logger consoleLogger = Logger.console();
  
  fileLogger.log('File log message');
  consoleLogger.log('Console log message');
  
  // Singleton pattern
  Database db1 = Database.instance;
  Database db2 = Database.instance;
  print('Singleton check: ${identical(db1, db2)}');
  
  // Method cascading
  Person person = Person('Alice', 25)
    ..introduce()
    ..celebrateBirthday()
    ..introduce();
  
  // Operator overloading
  Vector v1 = Vector(3, 4);
  Vector v2 = Vector(1, 2);
  Vector sum = v1 + v2;
  
  print('Vector sum: (${sum.x}, ${sum.y})');
  print('Vectors equal: ${v1 == Vector(3, 4)}');
  
  print('');
}

// Advanced OOP examples
abstract class Shape {
  double area();
  void draw();
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);
  
  @override
  double area() => 3.14159 * radius * radius;
  
  @override
  void draw() => print('Drawing a circle');
}

class Rectangle extends Shape {
  final double width, height;
  Rectangle(this.width, this.height);
  
  @override
  double area() => width * height;
  
  @override
  void draw() => print('Drawing a rectangle');
}

// Factory constructor example
abstract class Logger {
  void log(String message);
  
  factory Logger.file(String filename) = FileLogger;
  factory Logger.console() = ConsoleLogger;
}

class FileLogger implements Logger {
  final String filename;
  FileLogger(this.filename);
  
  @override
  void log(String message) => print('File($filename): $message');
}

class ConsoleLogger implements Logger {
  @override
  void log(String message) => print('Console: $message');
}

// Singleton pattern
class Database {
  static Database? _instance;
  
  Database._internal();
  
  static Database get instance {
    _instance ??= Database._internal();
    return _instance!;
  }
}

// Method cascading example
class Person {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  void introduce() => print('Hi, I\'m $name, age $age');
  void celebrateBirthday() {
    age++;
    print('Happy birthday! Now $age years old');
  }
}

// Operator overloading
class Vector {
  final double x, y;
  Vector(this.x, this.y);
  
  Vector operator +(Vector other) => Vector(x + other.x, y + other.y);
  Vector operator -(Vector other) => Vector(x - other.x, y - other.y);
  
  @override
  bool operator ==(Object other) =>
      other is Vector && x == other.x && y == other.y;
  
  @override
  int get hashCode => Object.hash(x, y);
}

// 10. Functional Programming Concepts
void functionalProgrammingReview() {
  print('10. FUNCTIONAL PROGRAMMING CONCEPTS');
  print('-----------------------------------');
  
  // Higher-order functions
  List<int> numbers = [1, 2, 3, 4, 5];
  
  // Functions as first-class objects
  Function doubler = (int x) => x * 2;
  Function adder = (int x, int y) => x + y;
  
  print('Doubled 5: ${doubler(5)}');
  print('Added 3 + 7: ${adder(3, 7)}');
  
  // Map, filter, reduce
  List<int> doubled = numbers.map((n) => n * 2).toList();
  List<int> evens = numbers.where((n) => n % 2 == 0).toList();
  int sum = numbers.reduce((a, b) => a + b);
  
  print('Doubled: $doubled');
  print('Evens: $evens');
  print('Sum: $sum');
  
  // Function composition
  Function<int, int> addOne = (x) => x + 1;
  Function<int, int> multiplyByTwo = (x) => x * 2;
  Function<int, int> composed = compose(multiplyByTwo, addOne);
  
  print('Composed function (5): ${composed(5)}'); // (5 + 1) * 2 = 12
  
  // Currying
  Function<int, Function<int, int>> curriedAdd = (x) => (y) => x + y;
  Function<int, int> addFive = curriedAdd(5);
  
  print('Curried add 5 to 3: ${addFive(3)}');
  
  // Partial application
  int multiply(int x, int y, int z) => x * y * z;
  Function<int, int> multiplyBy2And3 = (z) => multiply(2, 3, z);
  
  print('Partial application (4): ${multiplyBy2And3(4)}');
  
  // Immutable data patterns
  ImmutableList<int> immutableList = ImmutableList([1, 2, 3]);
  ImmutableList<int> newList = immutableList.add(4);
  
  print('Original immutable list: ${immutableList.items}');
  print('New immutable list: ${newList.items}');
  
  // Monadic patterns (simplified)
  Optional<String> optionalValue = Optional.of('Hello');
  Optional<String> mappedValue = optionalValue.map((s) => s.toUpperCase());
  
  print('Optional value: ${mappedValue.value}');
  
  // Function pipelining
  int result = 5
      .pipe((x) => x + 1)
      .pipe((x) => x * 2)
      .pipe((x) => x - 3);
  
  print('Pipeline result: $result'); // ((5 + 1) * 2) - 3 = 9
  
  print('');
}

// Helper functions for functional programming examples
Function<A, C> compose<A, B, C>(Function<B, C> f, Function<A, B> g) {
  return (A x) => f(g(x));
}

class ImmutableList<T> {
  final List<T> _items;
  
  ImmutableList(List<T> items) : _items = List.unmodifiable(items);
  
  List<T> get items => _items;
  
  ImmutableList<T> add(T item) {
    return ImmutableList([..._items, item]);
  }
  
  ImmutableList<T> remove(T item) {
    return ImmutableList(_items.where((i) => i != item).toList());
  }
}

class Optional<T> {
  final T? _value;
  
  Optional._(this._value);
  
  factory Optional.of(T value) => Optional._(value);
  factory Optional.empty() => Optional._(null);
  
  T? get value => _value;
  bool get hasValue => _value != null;
  
  Optional<U> map<U>(U Function(T) mapper) {
    return hasValue ? Optional.of(mapper(_value!)) : Optional.empty();
  }
  
  Optional<U> flatMap<U>(Optional<U> Function(T) mapper) {
    return hasValue ? mapper(_value!) : Optional.empty();
  }
}

extension FunctionPipeline<T> on T {
  U pipe<U>(U Function(T) transform) => transform(this);
}