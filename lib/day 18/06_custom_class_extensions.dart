/*
Custom Class Extensions
========================

This file demonstrates how to create extensions for your own custom classes
and third-party library classes. Extensions can add functionality to any type.
*/

// Sample custom classes to extend
class Person {
  final String firstName;
  final String lastName;
  final int age;
  final String email;

  Person({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
  });

  @override
  String toString() => '$firstName $lastName ($age)';
}

class Product {
  final String name;
  final double price;
  final String category;
  final bool inStock;

  Product({
    required this.name,
    required this.price,
    required this.category,
    this.inStock = true,
  });

  @override
  String toString() => '$name - \$${price.toStringAsFixed(2)}';
}

// Extensions for Person class
extension PersonExtensions on Person {
  // Get full name
  String get fullName => '$firstName $lastName';

  // Get initials
  String get initials => '${firstName[0]}${lastName[0]}';

  // Check if person is adult
  bool get isAdult => age >= 18;

  // Check if person is senior
  bool get isSenior => age >= 65;

  // Get age group
  String get ageGroup {
    if (age < 13) return 'Child';
    if (age < 20) return 'Teenager';
    if (age < 65) return 'Adult';
    return 'Senior';
  }

  // Validate email format
  bool get hasValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Get email domain
  String get emailDomain {
    int atIndex = email.indexOf('@');
    return atIndex != -1 ? email.substring(atIndex + 1) : '';
  }

  // Create greeting message
  String greet([String greeting = 'Hello']) {
    return '$greeting, $firstName!';
  }

  // Check if names match (case insensitive)
  bool hasName(String first, String last) {
    return firstName.toLowerCase() == first.toLowerCase() &&
        lastName.toLowerCase() == last.toLowerCase();
  }

  // Create a copy with updated age
  Person withAge(int newAge) {
    return Person(
      firstName: firstName,
      lastName: lastName,
      age: newAge,
      email: email,
    );
  }
}

// Extensions for Product class
extension ProductExtensions on Product {
  // Calculate price with tax
  double priceWithTax([double taxRate = 0.08]) {
    return price * (1 + taxRate);
  }

  // Check if product is expensive
  bool get isExpensive => price > 100;

  // Check if product is on sale (mock logic)
  bool get isOnSale => price % 10 == 0; // Simple mock condition

  // Get price tier
  String get priceTier {
    if (price < 25) return 'Budget';
    if (price < 100) return 'Mid-range';
    if (price < 500) return 'Premium';
    return 'Luxury';
  }

  // Format price as currency
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  // Create discount price
  double discountPrice(double percentage) {
    return price * (1 - percentage / 100);
  }

  // Check availability message
  String get availabilityMessage {
    return inStock ? 'In Stock' : 'Out of Stock';
  }

  // Create product summary
  String get summary {
    return '$name ($category) - $formattedPrice - $availabilityMessage';
  }

  // Create a copy with updated price
  Product withPrice(double newPrice) {
    return Product(
      name: name,
      price: newPrice,
      category: category,
      inStock: inStock,
    );
  }

  // Create a copy with updated stock status
  Product withStock(bool stockStatus) {
    return Product(
      name: name,
      price: price,
      category: category,
      inStock: stockStatus,
    );
  }
}

// Extensions for List of custom objects
extension PersonListExtensions on List<Person> {
  // Get all adults
  List<Person> get adults => where((person) => person.isAdult).toList();

  // Get all seniors
  List<Person> get seniors => where((person) => person.isSenior).toList();

  // Find person by name
  Person? findByName(String firstName, String lastName) {
    return firstWhereOrNull((person) => person.hasName(firstName, lastName));
  }

  // Get average age
  double get averageAge {
    if (isEmpty) return 0;
    return map((person) => person.age).reduce((a, b) => a + b) / length;
  }

  // Group by age group
  Map<String, List<Person>> get groupedByAgeGroup {
    Map<String, List<Person>> groups = {};
    for (Person person in this) {
      String ageGroup = person.ageGroup;
      groups.putIfAbsent(ageGroup, () => []).add(person);
    }
    return groups;
  }

  // Get people with invalid emails
  List<Person> get withInvalidEmails {
    return where((person) => !person.hasValidEmail).toList();
  }
}

extension ProductListExtensions on List<Product> {
  // Get products in stock
  List<Product> get inStock => where((product) => product.inStock).toList();

  // Get products by category
  List<Product> inCategory(String category) {
    return where(
      (product) => product.category.toLowerCase() == category.toLowerCase(),
    ).toList();
  }

  // Get expensive products
  List<Product> get expensive =>
      where((product) => product.isExpensive).toList();

  // Calculate total value
  double get totalValue =>
      map((product) => product.price).fold(0, (a, b) => a + b);

  // Get average price
  double get averagePrice {
    if (isEmpty) return 0;
    return totalValue / length;
  }

  // Find cheapest product
  Product? get cheapest {
    if (isEmpty) return null;
    return reduce((a, b) => a.price < b.price ? a : b);
  }

  // Find most expensive product
  Product? get mostExpensive {
    if (isEmpty) return null;
    return reduce((a, b) => a.price > b.price ? a : b);
  }

  // Apply discount to all products
  List<Product> withDiscount(double percentage) {
    return map(
      (product) => product.withPrice(product.discountPrice(percentage)),
    ).toList();
  }
}

// Helper extension for firstWhereOrNull (if not already defined)
extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (T element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

void demonstrateCustomClassExtensions() {
  print('=== Custom Class Extensions Demo ===\n');

  // Person extensions
  Person person = Person(
    firstName: 'John',
    lastName: 'Doe',
    age: 28,
    email: 'john.doe@example.com',
  );

  print('Person: $person');
  print('Full name: ${person.fullName}');
  print('Initials: ${person.initials}');
  print('Is adult: ${person.isAdult}');
  print('Age group: ${person.ageGroup}');
  print('Valid email: ${person.hasValidEmail}');
  print('Email domain: ${person.emailDomain}');
  print('Greeting: ${person.greet('Hi')}\n');

  // Product extensions
  Product product = Product(
    name: 'Laptop',
    price: 999.99,
    category: 'Electronics',
  );

  print('Product: $product');
  print('Price with tax: \$${product.priceWithTax().toStringAsFixed(2)}');
  print('Is expensive: ${product.isExpensive}');
  print('Price tier: ${product.priceTier}');
  print(
    'Discount price (20%): \$${product.discountPrice(20).toStringAsFixed(2)}',
  );
  print('Summary: ${product.summary}\n');

  // List extensions
  List<Person> people = [
    Person(
      firstName: 'Alice',
      lastName: 'Smith',
      age: 25,
      email: 'alice@test.com',
    ),
    Person(
      firstName: 'Bob',
      lastName: 'Johnson',
      age: 17,
      email: 'bob@invalid',
    ),
    Person(
      firstName: 'Charlie',
      lastName: 'Brown',
      age: 70,
      email: 'charlie@test.com',
    ),
    Person(
      firstName: 'Diana',
      lastName: 'Wilson',
      age: 35,
      email: 'diana@test.com',
    ),
  ];

  print('People: ${people.length} total');
  print('Adults: ${people.adults.length}');
  print('Seniors: ${people.seniors.length}');
  print('Average age: ${people.averageAge.toStringAsFixed(1)}');
  print('Invalid emails: ${people.withInvalidEmails.length}');

  // Find person
  Person? found = people.findByName('Alice', 'Smith');
  print('Found Alice: ${found?.fullName ?? 'Not found'}\n');

  // Product list extensions
  List<Product> products = [
    Product(name: 'Phone', price: 599.99, category: 'Electronics'),
    Product(name: 'Book', price: 15.99, category: 'Books'),
    Product(name: 'Headphones', price: 199.99, category: 'Electronics'),
    Product(name: 'Shirt', price: 29.99, category: 'Clothing', inStock: false),
  ];

  print('Products: ${products.length} total');
  print('In stock: ${products.inStock.length}');
  print('Electronics: ${products.inCategory('Electronics').length}');
  print('Expensive: ${products.expensive.length}');
  print('Total value: \$${products.totalValue.toStringAsFixed(2)}');
  print('Average price: \$${products.averagePrice.toStringAsFixed(2)}');
  print('Cheapest: ${products.cheapest?.name}');
  print('Most expensive: ${products.mostExpensive?.name}');

  // Apply discount
  List<Product> discounted = products.withDiscount(10);
  print(
    'After 10% discount - Total value: \$${discounted.totalValue.toStringAsFixed(2)}',
  );
}

void main() {
  demonstrateCustomClassExtensions();
}
