// Day 25: Practice Exercises for Dart Concepts
// This file contains practical exercises to reinforce learning

import 'dart:async';
import 'dart:io';
import 'dart:math';

void main() async {
  print('=== DART PRACTICE EXERCISES ===\n');

  // Exercise 1: String manipulation
  stringManipulationExercise();

  // Exercise 2: Collection operations
  collectionOperationsExercise();

  // Exercise 3: Object-oriented programming
  oopExercise();

  // Exercise 4: Async programming
  await asyncProgrammingExercise();

  // Exercise 5: Stream processing
  await streamProcessingExercise();
}

// Exercise 1: String Manipulation
void stringManipulationExercise() {
  print('EXERCISE 1: STRING MANIPULATION');
  print('-------------------------------');

  // Task: Create a text analyzer
  String text = '''
    The quick brown fox jumps over the lazy dog.
    This sentence contains every letter of the alphabet.
    It's commonly used for testing fonts and keyboards.
  ''';

  TextAnalyzer analyzer = TextAnalyzer(text);

  print('Original text length: ${analyzer.length}');
  print('Word count: ${analyzer.wordCount}');
  print('Sentence count: ${analyzer.sentenceCount}');
  print('Most common word: ${analyzer.mostCommonWord}');
  print('Text reversed: ${analyzer.reverse()}');
  print('');
}

class TextAnalyzer {
  final String _text;

  TextAnalyzer(this._text);

  int get length => _text.length;

  int get wordCount =>
      _text
          .split(RegExp(r'\s+'))
          .where((word) => word.trim().isNotEmpty)
          .length;

  int get sentenceCount =>
      _text
          .split(RegExp(r'[.!?]+'))
          .where((sentence) => sentence.trim().isNotEmpty)
          .length;

  String get mostCommonWord {
    Map<String, int> wordFreq = {};
    List<String> words =
        _text
            .toLowerCase()
            .replaceAll(RegExp(r'[^\w\s]'), '')
            .split(RegExp(r'\s+'))
            .where((word) => word.isNotEmpty)
            .toList();

    for (String word in words) {
      wordFreq[word] = (wordFreq[word] ?? 0) + 1;
    }

    return wordFreq.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  String reverse() => _text.split('').reversed.join('');
}

// Exercise 2: Collection Operations
void collectionOperationsExercise() {
  print('EXERCISE 2: COLLECTION OPERATIONS');
  print('---------------------------------');

  // Task: Implement a data processor for student grades
  List<Student> students = [
    Student('Alice', [85, 92, 78, 96, 88]),
    Student('Bob', [76, 84, 91, 73, 89]),
    Student('Charlie', [95, 87, 92, 98, 94]),
    Student('Diana', [82, 79, 85, 88, 91]),
    Student('Eve', [90, 93, 87, 95, 92]),
  ];

  GradeProcessor processor = GradeProcessor(students);

  print('Class average: ${processor.classAverage.toStringAsFixed(2)}');
  print(
    'Top student: ${processor.topStudent.name} (${processor.topStudent.average.toStringAsFixed(2)})',
  );
  print(
    'Students above average: ${processor.studentsAboveAverage.map((s) => s.name).join(', ')}',
  );
  print('');
}

class Student {
  final String name;
  final List<int> grades;

  Student(this.name, this.grades);

  double get average => grades.reduce((a, b) => a + b) / grades.length;
}

class GradeProcessor {
  final List<Student> students;

  GradeProcessor(this.students);

  double get classAverage =>
      students.map((s) => s.average).reduce((a, b) => a + b) / students.length;

  Student get topStudent =>
      students.reduce((a, b) => a.average > b.average ? a : b);

  List<Student> get studentsAboveAverage =>
      students.where((s) => s.average > classAverage).toList();
}

// Exercise 3: Object-Oriented Programming
void oopExercise() {
  print('EXERCISE 3: OBJECT-ORIENTED PROGRAMMING');
  print('---------------------------------------');

  // Task: Create a library management system
  Library library = Library('City Library');

  // Add books
  library.addBook(Book('1984', 'George Orwell', '978-0-452-28423-4', 1949));
  library.addBook(
    Book('To Kill a Mockingbird', 'Harper Lee', '978-0-06-112008-4', 1960),
  );

  // Add members
  library.addMember(Member('Alice Johnson', 'M001'));

  print('Library: ${library.name}');
  print('Total books: ${library.totalBooks}');
  print('Available books: ${library.availableBooks}');
  print('');
}

class Book {
  final String title;
  final String author;
  final String isbn;
  final int publishYear;
  bool _isAvailable = true;

  Book(this.title, this.author, this.isbn, this.publishYear);

  bool get isAvailable => _isAvailable;

  void _setAvailability(bool available) {
    _isAvailable = available;
  }
}

class Member {
  final String name;
  final String memberId;
  final List<Book> _borrowedBooks = [];

  Member(this.name, this.memberId);

  List<Book> get borrowedBooks => List.unmodifiable(_borrowedBooks);
}

class Library {
  final String name;
  final List<Book> _books = [];
  final List<Member> _members = [];

  Library(this.name);

  void addBook(Book book) => _books.add(book);
  void addMember(Member member) => _members.add(member);

  int get totalBooks => _books.length;
  int get availableBooks => _books.where((book) => book.isAvailable).length;
}

// Exercise 4: Async Programming
Future<void> asyncProgrammingExercise() async {
  print('EXERCISE 4: ASYNC PROGRAMMING');
  print('------------------------------');

  // Task: Create a web scraper simulator
  WebScraper scraper = WebScraper();

  List<String> urls = [
    'https://example.com/page1',
    'https://example.com/page2',
    'https://example.com/page3',
  ];

  print('Starting web scraping...');

  // Sequential scraping
  Stopwatch stopwatch = Stopwatch()..start();
  List<String> sequentialResults = [];
  for (String url in urls) {
    try {
      String content = await scraper.scrapeUrl(url);
      sequentialResults.add(content);
    } catch (e) {
      print('Error scraping $url: $e');
    }
  }
  int sequentialTime = stopwatch.elapsedMilliseconds;

  print('Sequential scraping completed in ${sequentialTime}ms');
  print('Results: ${sequentialResults.length} pages scraped');

  // Parallel scraping
  stopwatch.reset();
  List<Future<String>> futures =
      urls.map((url) => scraper.scrapeUrl(url)).toList();
  List<String> parallelResults = await Future.wait(futures, eagerError: false);
  int parallelTime = stopwatch.elapsedMilliseconds;

  print('Parallel scraping completed in ${parallelTime}ms');
  print(
    'Results: ${parallelResults.where((r) => r.isNotEmpty).length} pages scraped',
  );
  print('');
}

class WebScraper {
  final Random _random = Random();

  Future<String> scrapeUrl(String url) async {
    // Simulate network delay
    await Future.delayed(Duration(milliseconds: 100 + _random.nextInt(200)));

    // Simulate occasional failures
    if (_random.nextDouble() < 0.1) {
      throw Exception('Network error for $url');
    }

    // Simulate content extraction
    return 'Content from $url (${_random.nextInt(1000)} words)';
  }
}

// Exercise 5: Stream Processing
Future<void> streamProcessingExercise() async {
  print('EXERCISE 5: STREAM PROCESSING');
  print('------------------------------');

  // Task: Create a real-time data processor
  DataGenerator generator = DataGenerator();
  DataProcessor processor = DataProcessor();

  print('Starting real-time data processing...');

  // Generate and process data stream
  Stream<SensorData> dataStream = generator.generateSensorData().take(10);

  await for (ProcessedData processed in processor.processStream(dataStream)) {
    print('Processed: ${processed.toString()}');
  }

  print('');
}

class SensorData {
  final DateTime timestamp;
  final double temperature;
  final double humidity;
  final String sensorId;

  SensorData(this.timestamp, this.temperature, this.humidity, this.sensorId);
}

class ProcessedData {
  final SensorData original;
  final double temperatureFahrenheit;
  final String status;

  ProcessedData(this.original, this.temperatureFahrenheit, this.status);

  @override
  String toString() =>
      '${original.sensorId}: ${temperatureFahrenheit.toStringAsFixed(1)}°F, $status';
}

class DataGenerator {
  final Random _random = Random();

  Stream<SensorData> generateSensorData() async* {
    int counter = 0;
    while (true) {
      await Future.delayed(Duration(milliseconds: 100));

      double temperature = 20 + _random.nextDouble() * 15; // 20-35°C
      double humidity = 30 + _random.nextDouble() * 40; // 30-70%
      String sensorId = 'S${(counter % 3) + 1}';

      yield SensorData(DateTime.now(), temperature, humidity, sensorId);
      counter++;
    }
  }
}

class DataProcessor {
  Stream<ProcessedData> processStream(Stream<SensorData> input) async* {
    await for (SensorData data in input) {
      double fahrenheit = data.temperature * 9 / 5 + 32;

      String status;
      if (data.temperature > 30) {
        status = 'HOT';
      } else if (data.temperature < 22) {
        status = 'COLD';
      } else {
        status = 'NORMAL';
      }

      yield ProcessedData(data, fahrenheit, status);
    }
  }
}
