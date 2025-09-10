// Day 8: OOP - Inheritance Basics
// Understanding the concept of 'extends' to create a subclass

/*
INHERITANCE NOTES:
- Inheritance allows a class to inherit properties and methods from another class
- The parent class is called the superclass or base class
- The child class is called the subclass or derived class
- Use 'extends' keyword to create inheritance relationship
- Child class inherits all public and protected members from parent
- Child class can add new properties and methods
- Child class can override parent methods
*/

// Base/Parent Class
class Vehicle {
  String brand;
  String model;
  int year;

  // Constructor
  Vehicle(this.brand, this.model, this.year);

  // Methods
  void start() {
    print('$brand $model is starting...');
  }

  void stop() {
    print('$brand $model has stopped.');
  }

  void displayInfo() {
    print('Vehicle: $year $brand $model');
  }
}

// Child/Subclass extending Vehicle
class Car extends Vehicle {
  int numberOfDoors;
  String fuelType;

  // Constructor - calls parent constructor using super
  Car(String brand, String model, int year, this.numberOfDoors, this.fuelType)
    : super(brand, model, year);

  // New method specific to Car
  void honk() {
    print('$brand $model is honking: Beep! Beep!');
  }

  // Accessing inherited methods
  void carInfo() {
    displayInfo(); // Inherited method
    print('Doors: $numberOfDoors, Fuel: $fuelType');
  }
}

// Example usage
void main() {
  print('=== INHERITANCE BASICS EXAMPLE ===\n');

  // Create a Vehicle object
  Vehicle vehicle = Vehicle('Generic', 'Vehicle', 2020);
  vehicle.displayInfo();
  vehicle.start();
  vehicle.stop();

  print('\n--- Car (inherits from Vehicle) ---');

  // Create a Car object
  Car car = Car('Toyota', 'Camry', 2023, 4, 'Gasoline');
  car.displayInfo(); // Inherited method
  car.start(); // Inherited method
  car.honk(); // Car-specific method
  car.carInfo(); // Uses both inherited and new properties
  car.stop(); // Inherited method
}
