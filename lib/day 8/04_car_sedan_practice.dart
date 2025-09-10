// Day 8: OOP - Practice Exercise
// Create a Sedan class that extends Car class and adds trunkSize property

/*
PRACTICE EXERCISE:
Create a complete inheritance hierarchy:
1. Vehicle (base class)
2. Car (extends Vehicle)
3. Sedan (extends Car) - adds trunkSize property

This demonstrates:
- Multi-level inheritance
- Adding new properties in subclasses
- Method overriding
- Using super keyword
- Polymorphism
*/

// Base class - Vehicle
class Vehicle {
  String brand;
  String model;
  int year;
  String color;

  Vehicle(this.brand, this.model, this.year, this.color);

  void start() {
    print('$brand $model is starting...');
  }

  void stop() {
    print('$brand $model has stopped.');
  }

  void displayInfo() {
    print('Vehicle: $year $brand $model ($color)');
  }

  double calculateValue() {
    // Basic depreciation calculation
    int currentYear = DateTime.now().year;
    int age = currentYear - year;
    return 20000 - (age * 2000); // Simple depreciation
  }
}

// Car class extending Vehicle
class Car extends Vehicle {
  int numberOfDoors;
  String fuelType;
  double engineSize;

  Car(
    String brand,
    String model,
    int year,
    String color,
    this.numberOfDoors,
    this.fuelType,
    this.engineSize,
  ) : super(brand, model, year, color);

  void honk() {
    print('$brand $model: Beep! Beep!');
  }

  @override
  void displayInfo() {
    super.displayInfo(); // Call parent method
    print(
      'Car Details: $numberOfDoors doors, $fuelType, ${engineSize}L engine',
    );
  }

  @override
  double calculateValue() {
    double baseValue = super.calculateValue();
    // Cars depreciate faster
    return baseValue * 0.8;
  }

  void refuel() {
    print('$brand $model is refueling with $fuelType');
  }
}

// Sedan class extending Car (the main practice exercise)
class Sedan extends Car {
  double trunkSize; // New property specific to Sedan
  bool hasLeatherSeats;
  bool hasSunroof;

  // Constructor using super to call parent constructors
  Sedan(
    String brand,
    String model,
    int year,
    String color,
    int numberOfDoors,
    String fuelType,
    double engineSize,
    this.trunkSize,
    this.hasLeatherSeats,
    this.hasSunroof,
  ) : super(brand, model, year, color, numberOfDoors, fuelType, engineSize);

  // Override displayInfo to include sedan-specific details
  @override
  void displayInfo() {
    super.displayInfo(); // Call Car's displayInfo (which calls Vehicle's)
    print(
      'Sedan Features: ${trunkSize}L trunk, '
      'Leather seats: ${hasLeatherSeats ? 'Yes' : 'No'}, '
      'Sunroof: ${hasSunroof ? 'Yes' : 'No'}',
    );
  }

  // Override calculateValue for sedan-specific calculation
  @override
  double calculateValue() {
    double baseValue = super.calculateValue();
    // Add value for luxury features
    if (hasLeatherSeats) baseValue += 2000;
    if (hasSunroof) baseValue += 1500;
    if (trunkSize > 400) baseValue += 1000; // Large trunk adds value
    return baseValue;
  }

  // Sedan-specific methods
  void openTrunk() {
    print('$brand $model trunk is opening... (${trunkSize}L capacity)');
  }

  void closeTrunk() {
    print('$brand $model trunk is closing securely.');
  }

  void loadTrunk(double cargoVolume) {
    if (cargoVolume <= trunkSize) {
      print('Loading ${cargoVolume}L of cargo into the trunk.');
      print('Remaining trunk space: ${trunkSize - cargoVolume}L');
    } else {
      print(
        'Cannot load ${cargoVolume}L - trunk capacity is only ${trunkSize}L',
      );
    }
  }

  // Override start method to add sedan-specific behavior
  @override
  void start() {
    super.start(); // Call parent start method
    print('Sedan comfort systems activated.');
    if (hasLeatherSeats) print('Leather seat heating available.');
    if (hasSunroof) print('Sunroof controls ready.');
  }
}

// Additional class to show more inheritance
class LuxurySedan extends Sedan {
  bool hasAutoPilot;
  String interiorMaterial;

  LuxurySedan(
    String brand,
    String model,
    int year,
    String color,
    int numberOfDoors,
    String fuelType,
    double engineSize,
    double trunkSize,
    this.hasAutoPilot,
    this.interiorMaterial,
  ) : super(
        brand,
        model,
        year,
        color,
        numberOfDoors,
        fuelType,
        engineSize,
        trunkSize,
        true,
        true,
      ); // Always has leather & sunroof

  @override
  void displayInfo() {
    super.displayInfo();
    print(
      'Luxury Features: AutoPilot: ${hasAutoPilot ? 'Yes' : 'No'}, '
      'Interior: $interiorMaterial',
    );
  }

  @override
  void start() {
    super.start();
    print('Luxury systems initializing...');
    if (hasAutoPilot) print('AutoPilot system ready.');
  }

  void activateAutoPilot() {
    if (hasAutoPilot) {
      print('$brand $model AutoPilot activated!');
    } else {
      print('AutoPilot not available on this model.');
    }
  }
}

void main() {
  print('=== CAR SEDAN PRACTICE EXERCISE ===\n');

  // Create a basic Vehicle
  print('--- Basic Vehicle ---');
  Vehicle vehicle = Vehicle('Generic', 'Transport', 2020, 'White');
  vehicle.displayInfo();
  print('Estimated value: \$${vehicle.calculateValue().toStringAsFixed(2)}');
  vehicle.start();
  vehicle.stop();

  print('\n--- Car (extends Vehicle) ---');
  Car car = Car('Honda', 'Civic', 2022, 'Blue', 4, 'Gasoline', 1.5);
  car.displayInfo();
  print('Estimated value: \$${car.calculateValue().toStringAsFixed(2)}');
  car.start();
  car.honk();
  car.refuel();
  car.stop();

  print('\n--- Sedan (extends Car) - MAIN PRACTICE ---');
  Sedan sedan = Sedan(
    'Toyota',
    'Camry',
    2023,
    'Silver',
    4,
    'Gasoline',
    2.5,
    450.0,
    true,
    true,
  );
  sedan.displayInfo();
  print('Estimated value: \$${sedan.calculateValue().toStringAsFixed(2)}');
  sedan.start();
  sedan.honk();
  sedan.openTrunk();
  sedan.loadTrunk(300.0);
  sedan.loadTrunk(200.0); // This should exceed capacity
  sedan.closeTrunk();
  sedan.refuel();
  sedan.stop();

  print('\n--- Luxury Sedan (extends Sedan) ---');
  LuxurySedan luxurySedan = LuxurySedan(
    'BMW',
    '7 Series',
    2024,
    'Black',
    4,
    'Gasoline',
    3.0,
    500.0,
    true,
    'Carbon Fiber',
  );
  luxurySedan.displayInfo();
  print(
    'Estimated value: \$${luxurySedan.calculateValue().toStringAsFixed(2)}',
  );
  luxurySedan.start();
  luxurySedan.activateAutoPilot();
  luxurySedan.openTrunk();
  luxurySedan.loadTrunk(400.0);
  luxurySedan.closeTrunk();
  luxurySedan.stop();

  print('\n=== POLYMORPHISM DEMONSTRATION ===');
  List<Vehicle> vehicles = [vehicle, car, sedan, luxurySedan];

  for (int i = 0; i < vehicles.length; i++) {
    print('\n--- Vehicle ${i + 1} ---');
    vehicles[i].displayInfo(); // Each calls its own overridden version
    print('Value: \$${vehicles[i].calculateValue().toStringAsFixed(2)}');
  }
}
