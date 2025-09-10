// Day 8: OOP - Method Overriding
// Practice method overriding to customize inherited behavior

/*
METHOD OVERRIDING NOTES:
- Method overriding allows child class to provide specific implementation of parent method
- Use @override annotation (recommended for clarity and error checking)
- Overridden method must have same name, return type, and parameters as parent
- Child class method replaces parent class method when called on child object
- Can still call parent method using super.methodName() if needed
- Enables polymorphism - same method name, different behavior
*/

// Base class
class Shape {
  String color;

  Shape(this.color);

  // Method to be overridden
  double calculateArea() {
    print('Calculating area of generic shape');
    return 0.0;
  }

  // Method to be overridden
  void draw() {
    print('Drawing a generic shape in $color color');
  }

  // Method that won't be overridden
  void displayColor() {
    print('This shape is $color');
  }
}

// Circle class overriding methods
class Circle extends Shape {
  double radius;

  Circle(String color, this.radius) : super(color);

  // Override calculateArea method
  @override
  double calculateArea() {
    print('Calculating circle area');
    return 3.14159 * radius * radius;
  }

  // Override draw method
  @override
  void draw() {
    print('Drawing a circle with radius $radius in $color color');
  }
}

// Rectangle class overriding methods
class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(String color, this.width, this.height) : super(color);

  // Override calculateArea method
  @override
  double calculateArea() {
    print('Calculating rectangle area');
    return width * height;
  }

  // Override draw method
  @override
  void draw() {
    print('Drawing a rectangle ${width}x$height in $color color');
  }
}

// Triangle class overriding methods
class Triangle extends Shape {
  double base;
  double height;

  Triangle(String color, this.base, this.height) : super(color);

  // Override calculateArea method
  @override
  double calculateArea() {
    print('Calculating triangle area');
    return 0.5 * base * height;
  }

  // Override draw method with super usage
  @override
  void draw() {
    super.draw(); // Call parent method first
    print('Specifically: Drawing triangle with base $base and height $height');
  }
}

// Demonstration of polymorphism through method overriding
void demonstratePolymorphism(Shape shape) {
  print('\n--- Polymorphism Demo ---');
  shape.displayColor(); // Same method for all
  shape.draw(); // Different implementation for each
  double area = shape.calculateArea(); // Different calculation for each
  print('Area: ${area.toStringAsFixed(2)}');
}

void main() {
  print('=== METHOD OVERRIDING EXAMPLES ===\n');

  // Create different shapes
  Circle circle = Circle('Red', 5.0);
  Rectangle rectangle = Rectangle('Blue', 4.0, 6.0);
  Triangle triangle = Triangle('Green', 8.0, 3.0);

  // Direct method calls showing overriding
  print('--- Circle ---');
  circle.draw();
  double circleArea = circle.calculateArea();
  print('Circle area: ${circleArea.toStringAsFixed(2)}\n');

  print('--- Rectangle ---');
  rectangle.draw();
  double rectArea = rectangle.calculateArea();
  print('Rectangle area: ${rectArea.toStringAsFixed(2)}\n');

  print('--- Triangle ---');
  triangle.draw();
  double triangleArea = triangle.calculateArea();
  print('Triangle area: ${triangleArea.toStringAsFixed(2)}\n');

  // Polymorphism demonstration
  print('=== POLYMORPHISM THROUGH METHOD OVERRIDING ===');
  demonstratePolymorphism(circle);
  demonstratePolymorphism(rectangle);
  demonstratePolymorphism(triangle);
}
