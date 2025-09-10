// Day 25: Exploring dart:core Library
// The dart:core library is automatically imported and contains fundamental classes

import 'dart:core'; // Usually not needed as it's imported by default

void main() {
  print('=== DART:CORE LIBRARY EXPLORATION ===\n');

  // Core data types
  coreDataTypes();

  // String operations
  stringOperations();

  // Number operations
  numberOperations();

  // DateTime operations
  dateTimeOperations();

  // Duration operations
  durationOperations();

  // Uri operations
  uriOperations();

  // Pattern matching
  patternMatching();

  // Iterables and collections
  iterableOperations();
}

// 1. Core Data Types
void coreDataTypes() {
  print('1. CORE DATA TYPES');
  print('-------------------');

  // Object - base class for all Dart objects
  Object obj = 'Hello';
  print('Object type: ${obj.runtimeType}');
  print('Object string: ${obj.toString()}');
  print('Object hash: ${obj.hashCode}');

  // Null type
  Null nullValue = null;
  print('Null value: $nullValue');

  // Type checking
  print('obj is String: ${obj is String}');
  print('obj is! int: ${obj is! int}');

  // Type casting
  String str = obj as String;
  print('Casted string: $str');
  print('');
}

// 2. String Operations
void stringOperations() {
  print('2. STRING OPERATIONS');
  print('--------------------');

  String text = 'Hello, Dart World!';

  // Basic properties
  print('Length: ${text.length}');
  print('Is empty: ${text.isEmpty}');
  print('Is not empty: ${text.isNotEmpty}');

  // Case operations
  print('Uppercase: ${text.toUpperCase()}');
  print('Lowercase: ${text.toLowerCase()}');

  // Substring operations
  print('Substring(0, 5): ${text.substring(0, 5)}');
  print('Contains "Dart": ${text.contains("Dart")}');
  print('Starts with "Hello": ${text.startsWith("Hello")}');
  print('Ends with "!": ${text.endsWith("!")}');

  // Index operations
  print('Index of "Dart": ${text.indexOf("Dart")}');
  print('Last index of "l": ${text.lastIndexOf("l")}');

  // Split and join
  List<String> words = text.split(' ');
  print('Split words: $words');
  print('Joined with "-": ${words.join("-")}');

  // Replace operations
  print(
    'Replace "World" with "Universe": ${text.replaceAll("World", "Universe")}',
  );

  // Trim operations
  String paddedText = '  Hello Dart  ';
  print('Original: "$paddedText"');
  print('Trimmed: "${paddedText.trim()}"');
  print('Trim left: "${paddedText.trimLeft()}"');
  print('Trim right: "${paddedText.trimRight()}"');

  // String interpolation and raw strings
  String name = 'Alice';
  int age = 25;
  print('Interpolation: Hello, $name! You are $age years old.');
  print('Expression: ${name.toUpperCase()} is ${age > 18 ? "adult" : "minor"}');

  String rawString = r'Raw string with \n and \t';
  print('Raw string: $rawString');
  print('');
}

// 3. Number Operations
void numberOperations() {
  print('3. NUMBER OPERATIONS');
  print('--------------------');

  // int operations
  int a = 10;
  int b = 3;

  print('Integer operations:');
  print('$a + $b = ${a + b}');
  print('$a - $b = ${a - b}');
  print('$a * $b = ${a * b}');
  print('$a / $b = ${a / b}'); // Returns double
  print('$a ~/ $b = ${a ~/ b}'); // Integer division
  print('$a % $b = ${a % b}'); // Modulo

  // int properties and methods
  print('$a is even: ${a.isEven}');
  print('$a is odd: ${a.isOdd}');
  print('$a absolute: ${a.abs()}');
  print('$a sign: ${a.sign}');

  // double operations
  double x = 3.14159;
  double y = 2.5;

  print('\nDouble operations:');
  print('$x + $y = ${x + y}');
  print('$x rounded: ${x.round()}');
  print('$x floor: ${x.floor()}');
  print('$x ceiling: ${x.ceil()}');
  print('$x truncated: ${x.truncate()}');

  // Number parsing
  String numStr = '42';
  String doubleStr = '3.14';

  print('\nParsing:');
  print('Parse int "$numStr": ${int.parse(numStr)}');
  print('Parse double "$doubleStr": ${double.parse(doubleStr)}');
  print('Try parse invalid: ${int.tryParse("abc") ?? "null"}');

  // Number formatting
  print('\nFormatting:');
  print('$x to string: ${x.toString()}');
  print('$x to string as fixed(2): ${x.toStringAsFixed(2)}');
  print('$x to string as exponential: ${x.toStringAsExponential(2)}');
  print('$x to string with precision(4): ${x.toStringAsPrecision(4)}');
  print('');
}

// 4. DateTime Operations
void dateTimeOperations() {
  print('4. DATETIME OPERATIONS');
  print('----------------------');

  // Current date and time
  DateTime now = DateTime.now();
  print('Current time: $now');
  print('Current UTC: ${DateTime.now().toUtc()}');

  // Creating specific dates
  DateTime specificDate = DateTime(2024, 12, 25, 10, 30, 45);
  print('Specific date: $specificDate');

  DateTime utcDate = DateTime.utc(2024, 1, 1);
  print('UTC date: $utcDate');

  // Date components
  print('\nDate components:');
  print('Year: ${now.year}');
  print('Month: ${now.month}');
  print('Day: ${now.day}');
  print('Hour: ${now.hour}');
  print('Minute: ${now.minute}');
  print('Second: ${now.second}');
  print('Millisecond: ${now.millisecond}');
  print('Weekday: ${now.weekday}'); // 1 = Monday, 7 = Sunday

  // Date arithmetic
  DateTime tomorrow = now.add(Duration(days: 1));
  DateTime lastWeek = now.subtract(Duration(days: 7));

  print('\nDate arithmetic:');
  print('Tomorrow: $tomorrow');
  print('Last week: $lastWeek');

  // Date comparison
  print('\nDate comparison:');
  print('Tomorrow is after now: ${tomorrow.isAfter(now)}');
  print('Last week is before now: ${lastWeek.isBefore(now)}');
  print('Dates are equal: ${now.isAtSameMomentAs(now)}');

  // Date difference
  Duration difference = tomorrow.difference(now);
  print('Difference to tomorrow: ${difference.inHours} hours');

  // Parsing and formatting
  String dateString = '2024-12-25 10:30:45';
  DateTime parsed = DateTime.parse(dateString);
  print('\nParsed date: $parsed');
  print('ISO string: ${now.toIso8601String()}');
  print('');
}

// 5. Duration Operations
void durationOperations() {
  print('5. DURATION OPERATIONS');
  print('----------------------');

  // Creating durations
  Duration duration1 = Duration(days: 1, hours: 2, minutes: 30, seconds: 45);
  Duration duration2 = Duration(milliseconds: 5000);
  Duration duration3 = Duration(microseconds: 1000000);

  print('Duration 1: $duration1');
  print('Duration 2: $duration2');
  print('Duration 3: $duration3');

  // Duration properties
  print('\nDuration properties:');
  print('Total milliseconds: ${duration1.inMilliseconds}');
  print('Total seconds: ${duration1.inSeconds}');
  print('Total minutes: ${duration1.inMinutes}');
  print('Total hours: ${duration1.inHours}');
  print('Total days: ${duration1.inDays}');

  // Duration arithmetic
  Duration sum = duration1 + duration2;
  Duration difference = duration1 - duration2;
  Duration multiplied = duration2 * 3;

  print('\nDuration arithmetic:');
  print('Sum: $sum');
  print('Difference: $difference');
  print('Multiplied: $multiplied');

  // Duration comparison
  print('\nDuration comparison:');
  print('Duration1 > Duration2: ${duration1 > duration2}');
  print('Duration1 < Duration2: ${duration1 < duration2}');
  print('Duration1 == Duration2: ${duration1 == duration2}');

  // Absolute duration
  Duration negative = Duration(seconds: -30);
  print('Negative duration: $negative');
  print('Absolute duration: ${negative.abs()}');
  print('');
}

// 6. Uri Operations
void uriOperations() {
  print('6. URI OPERATIONS');
  print('-----------------');

  // Creating URIs
  Uri uri1 = Uri.parse('https://dart.dev/guides/language/language-tour');
  Uri uri2 = Uri(
    scheme: 'https',
    host: 'api.example.com',
    path: '/users',
    queryParameters: {'page': '1', 'limit': '10'},
  );

  print('Parsed URI: $uri1');
  print('Constructed URI: $uri2');

  // URI components
  print('\nURI components:');
  print('Scheme: ${uri1.scheme}');
  print('Host: ${uri1.host}');
  print('Port: ${uri1.port}');
  print('Path: ${uri1.path}');
  print('Query: ${uri1.query}');
  print('Fragment: ${uri1.fragment}');

  // Query parameters
  print('\nQuery parameters:');
  uri2.queryParameters.forEach((key, value) {
    print('$key: $value');
  });

  // URI manipulation
  Uri newUri = uri1.replace(
    path: '/new-path',
    queryParameters: {'search': 'dart'},
  );
  print('\nModified URI: $newUri');

  // URI encoding/decoding
  String encoded = Uri.encodeComponent('Hello World!');
  String decoded = Uri.decodeComponent(encoded);
  print('\nEncoded: $encoded');
  print('Decoded: $decoded');
  print('');
}

// 7. Pattern Matching (RegExp)
void patternMatching() {
  print('7. PATTERN MATCHING');
  print('-------------------');

  String text =
      'The quick brown fox jumps over the lazy dog. Email: test@example.com';

  // Basic pattern matching
  RegExp wordPattern = RegExp(r'\b\w+\b');
  Iterable<Match> words = wordPattern.allMatches(text);
  print('Words found: ${words.length}');

  // Email pattern
  RegExp emailPattern = RegExp(
    r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
  );
  Match? emailMatch = emailPattern.firstMatch(text);
  if (emailMatch != null) {
    print('Email found: ${emailMatch.group(0)}');
  }

  // Case insensitive matching
  RegExp caseInsensitive = RegExp(r'QUICK', caseSensitive: false);
  print('Case insensitive match: ${caseInsensitive.hasMatch(text)}');

  // Replace with pattern
  String replaced = text.replaceAll(RegExp(r'\b\w{4}\b'), '****');
  print('4-letter words replaced: $replaced');

  // Split with pattern
  List<String> parts = text.split(RegExp(r'[.!?]'));
  print('Sentences: ${parts.where((s) => s.trim().isNotEmpty).toList()}');
  print('');
}

// 8. Iterable Operations
void iterableOperations() {
  print('8. ITERABLE OPERATIONS');
  print('----------------------');

  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // Basic iterable operations
  print('Original: $numbers');
  print('Length: ${numbers.length}');
  print('Is empty: ${numbers.isEmpty}');
  print('First: ${numbers.first}');
  print('Last: ${numbers.last}');

  // Filtering
  Iterable<int> evens = numbers.where((n) => n % 2 == 0);
  print('Even numbers: ${evens.toList()}');

  // Mapping
  Iterable<String> strings = numbers.map((n) => 'Number $n');
  print('Mapped strings: ${strings.take(3).toList()}...');

  // Reducing
  int sum = numbers.reduce((a, b) => a + b);
  print('Sum: $sum');

  // Folding
  String concatenated = numbers.fold('', (prev, element) => '$prev$element');
  print('Concatenated: $concatenated');

  // Any and every
  print('Any even: ${numbers.any((n) => n % 2 == 0)}');
  print('All positive: ${numbers.every((n) => n > 0)}');

  // Skip and take
  print('Skip 3, take 4: ${numbers.skip(3).take(4).toList()}');

  // Contains
  print('Contains 5: ${numbers.contains(5)}');

  // Single element operations
  try {
    int single = [42].single;
    print('Single element: $single');
  } catch (e) {
    print('Error getting single: $e');
  }

  // Element at
  print('Element at index 2: ${numbers.elementAt(2)}');

  // Where type
  List<Object> mixed = [1, 'hello', 2, 'world', 3];
  Iterable<String> onlyStrings = mixed.whereType<String>();
  print('Only strings: ${onlyStrings.toList()}');
  print('');
}
