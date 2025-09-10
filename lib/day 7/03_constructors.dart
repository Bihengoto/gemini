/*
Day 7: Constructors in Dart

A CONSTRUCTOR is a special method that is called when an object is created.
It initializes the instance variables of the class.

Types of Constructors:
1. Default Constructor - No parameters
2. Parameterized Constructor - Takes parameters
3. Named Constructor - Has a custom name
4. Constant Constructor - Creates compile-time constants
*/

class Book {
  String title;
  String author;
  int pages;
  double price;
  bool isAvailable;

  // Default constructor
  Book() {
    title = "Unknown";
    author = "Unknown";
    pages = 0;
    price = 0.0;
    isAvailable = true;
    print("Default constructor called");
  }

  // Parameterized constructor
  Book.withDetails(this.title, this.author, this.pages, this.price) {
    isAvailable = true;
    print("Parameterized constructor called for: $title");
  }

  // Named constructor - alternative way to create objects
  Book.paperback(String title, String author) {
    this.title = title;
    this.author = author;
    this.pages = 200; // Default for paperback
    this.price = 9.99; // Default price
    this.isAvailable = true;
    print("Paperback constructor called");
  }

  // Named constructor for hardcover books
  Book.hardcover(String title, String author) {
    this.title = title;
    this.author = author;
    this.pages = 300; // Default for hardcover
    this.price = 19.99; // Default price
    this.isAvailable = true;
    print("Hardcover constructor called");
  }

  // Named constructor to create from another book (copy constructor)
  Book.copy(Book other) {
    title = other.title;
    author = other.author;
    pages = other.pages;
    price = other.price;
    isAvailable = other.isAvailable;
    print("Copy constructor called");
  }

  void displayInfo() {
    print("Title: $title");
    print("Author: $author");
    print("Pages: $pages");
    print("Price: \$${price.toStringAsFixed(2)}");
    print("Available: ${isAvailable ? 'Yes' : 'No'}");
    print("-" * 30);
  }
}

// Example with different constructor styles
class Rectangle {
  double width;
  double height;

  // Constructor with required parameters
  Rectangle(this.width, this.height);

  // Named constructor for square
  Rectangle.square(double side) : width = side, height = side;

  // Named constructor with default values
  Rectangle.defaultSize() : width = 10.0, height = 10.0;

  double get area => width * height;
  double get perimeter => 2 * (width + height);

  void displayDimensions() {
    print("Rectangle: ${width} x ${height}");
    print("Area: ${area}");
    print("Perimeter: ${perimeter}");
  }
}

void main() {
  print("Constructors Example");
  print("===================");

  // Using default constructor
  Book book1 = Book();
  book1.displayInfo();

  // Using parameterized constructor
  Book book2 = Book.withDetails("1984", "George Orwell", 328, 12.99);
  book2.displayInfo();

  // Using named constructors
  Book book3 = Book.paperback("The Hobbit", "J.R.R. Tolkien");
  book3.displayInfo();

  Book book4 = Book.hardcover("Dune", "Frank Herbert");
  book4.displayInfo();

  // Using copy constructor
  Book book5 = Book.copy(book2);
  book5.displayInfo();

  print("Rectangle Examples:");
  print("==================");

  // Different ways to create rectangles
  Rectangle rect1 = Rectangle(5.0, 3.0);
  rect1.displayDimensions();

  Rectangle square = Rectangle.square(4.0);
  square.displayDimensions();

  Rectangle defaultRect = Rectangle.defaultSize();
  defaultRect.displayDimensions();
}
