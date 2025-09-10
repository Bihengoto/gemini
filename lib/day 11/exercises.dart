// Day 11 Exercises: Getters & Setters

// Exercise 1: Student Grade Manager
// Create a Student class with:
// - Private fields: name, grades (List<double>)
// - Getters and setters for name with validation
// - A grades getter that returns unmodifiable list
// - An addGrade setter that adds a grade (0-100 validation)
// - Computed properties: average, letterGrade, isPassing

class Student {
  String _name;
  final List<double> _grades = [];

  Student(this._name);

  // TODO: Implement name getter and setter with validation
  // Name should not be empty and should be trimmed

  // TODO: Implement grades getter (return unmodifiable list)

  // TODO: Implement addGrade setter with validation (0-100)

  // TODO: Implement computed property: average
  // Return 0.0 if no grades

  // TODO: Implement computed property: letterGrade
  // A: 90-100, B: 80-89, C: 70-79, D: 60-69, F: below 60

  // TODO: Implement computed property: isPassing
  // Passing grade is 60 or above

  @override
  String toString() {
    return 'Student(name: $_name, average: ${0.0}, letterGrade: ${'F'})';
  }
}

// Exercise 2: Product Inventory
// Create a Product class with:
// - Private fields: name, price, quantity
// - Proper getters and setters with validation
// - Computed properties: totalValue, isInStock, stockStatus

class Product {
  String _name;
  double _price;
  int _quantity;

  Product(this._name, this._price, this._quantity);

  // TODO: Implement name getter and setter
  // Name should not be empty

  // TODO: Implement price getter and setter
  // Price should be positive

  // TODO: Implement quantity getter and setter
  // Quantity should be non-negative

  // TODO: Implement computed property: totalValue (price * quantity)

  // TODO: Implement computed property: isInStock (quantity > 0)

  // TODO: Implement computed property: stockStatus
  // "Out of Stock" if quantity = 0
  // "Low Stock" if quantity 1-5
  // "In Stock" if quantity > 5

  @override
  String toString() {
    return 'Product(name: $_name, price: \$${_price.toStringAsFixed(2)}, '
        'quantity: $_quantity, totalValue: \$${0.0})';
  }
}

// Exercise 3: Time Period Calculator
// Create a TimePeriod class with:
// - Private field: duration in minutes
// - Getters and setters for hours, minutes, seconds
// - Validation to ensure non-negative values

class TimePeriod {
  int _totalMinutes;

  TimePeriod.minutes(this._totalMinutes);

  // TODO: Implement hours getter and setter
  // Getter: return total hours (can be decimal)
  // Setter: convert hours to minutes and store

  // TODO: Implement minutes getter and setter
  // Getter: return total minutes
  // Setter: store minutes directly (with validation)

  // TODO: Implement seconds getter and setter
  // Getter: return total seconds
  // Setter: convert seconds to minutes and store

  // TODO: Implement computed property: formatted
  // Return string like "2h 30m" or "45m" or "1h 15m"

  @override
  String toString() {
    return 'TimePeriod(${0}h ${0}m)';
  }
}

// Exercise 4: Shopping Cart
// Create a ShoppingCart class with:
// - Private field: items (Map<String, int> - item name to quantity)
// - Methods to add/remove items using setters
// - Computed properties for cart analysis

class ShoppingCart {
  final Map<String, int> _items = {};

  // TODO: Implement items getter (return unmodifiable map)

  // TODO: Implement addItem setter
  // Takes a string in format "itemName:quantity"
  // Example: cart.addItem = "apple:3"

  // TODO: Implement removeItem setter
  // Takes item name and removes it completely

  // TODO: Implement computed property: totalItems
  // Sum of all quantities

  // TODO: Implement computed property: uniqueItems
  // Number of different items

  // TODO: Implement computed property: isEmpty

  // TODO: Implement computed property: itemsList
  // Return list of strings like ["apple (3)", "banana (2)"]

  @override
  String toString() {
    return 'ShoppingCart(items: ${0}, totalItems: ${0})';
  }
}

// Test functions (uncomment to test your implementations)

void testStudent() {
  print('=== Testing Student ===');
  var student = Student('John Doe');

  // Test your implementation here
  // student.addGrade = 85.0;
  // student.addGrade = 92.0;
  // student.addGrade = 78.0;
  // print(student);
  // print('Average: ${student.average}');
  // print('Letter Grade: ${student.letterGrade}');
  // print('Is Passing: ${student.isPassing}');
}

void testProduct() {
  print('\n=== Testing Product ===');
  var product = Product('Laptop', 999.99, 3);

  // Test your implementation here
  // print(product);
  // print('Total Value: \$${product.totalValue}');
  // print('In Stock: ${product.isInStock}');
  // print('Stock Status: ${product.stockStatus}');
}

void testTimePeriod() {
  print('\n=== Testing TimePeriod ===');
  var period = TimePeriod.minutes(150);

  // Test your implementation here
  // print('Hours: ${period.hours}');
  // print('Minutes: ${period.minutes}');
  // print('Seconds: ${period.seconds}');
  // print('Formatted: ${period.formatted}');
}

void testShoppingCart() {
  print('\n=== Testing ShoppingCart ===');
  var cart = ShoppingCart();

  // Test your implementation here
  // cart.addItem = 'apple:3';
  // cart.addItem = 'banana:2';
  // print(cart);
  // print('Items: ${cart.itemsList}');
}

void main() {
  print('Day 11 Exercises: Getters & Setters');
  print(
    'Implement the TODO items in each class, then uncomment the test functions.',
  );

  // Uncomment these when you've implemented the classes:
  // testStudent();
  // testProduct();
  // testTimePeriod();
  // testShoppingCart();
}
