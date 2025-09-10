// Basic Getters and Setters Example

class Rectangle {
  // Private fields (convention: prefix with underscore)
  double _width;
  double _height;

  // Constructor
  Rectangle(this._width, this._height);

  // Getter for width
  double get width => _width;

  // Setter for width with validation
  set width(double value) {
    if (value > 0) {
      _width = value;
    } else {
      throw ArgumentError('Width must be positive');
    }
  }

  // Getter for height
  double get height => _height;

  // Setter for height with validation
  set height(double value) {
    if (value > 0) {
      _height = value;
    } else {
      throw ArgumentError('Height must be positive');
    }
  }

  // Computed property - area (getter only)
  double get area => _width * _height;

  // Computed property - perimeter (getter only)
  double get perimeter => 2 * (_width + _height);

  @override
  String toString() {
    return 'Rectangle(width: $_width, height: $_height, area: $area)';
  }
}

void main() {
  // Create a rectangle
  var rect = Rectangle(5.0, 3.0);

  print('Initial rectangle: $rect');

  // Using getters
  print('Width: ${rect.width}');
  print('Height: ${rect.height}');
  print('Area: ${rect.area}');
  print('Perimeter: ${rect.perimeter}');

  // Using setters
  rect.width = 8.0;
  rect.height = 4.0;

  print('\nAfter modification: $rect');

  // Try invalid values (will throw exceptions)
  try {
    rect.width = -2.0;
  } catch (e) {
    print('Error: $e');
  }

  try {
    rect.height = 0;
  } catch (e) {
    print('Error: $e');
  }
}
