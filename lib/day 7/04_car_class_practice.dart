/*
Day 7: Practice - Car Class Implementation

This file contains the practical implementation of a Car class
with properties like color and make, and methods like drive().
*/

class Car {
  // Instance variables (properties)
  String make;
  String model;
  String color;
  int year;
  double mileage;
  bool isEngineOn;
  double fuelLevel; // Percentage (0-100)

  // Default constructor
  Car() {
    make = "Unknown";
    model = "Unknown";
    color = "White";
    year = 2020;
    mileage = 0.0;
    isEngineOn = false;
    fuelLevel = 100.0;
  }

  // Parameterized constructor
  Car.withDetails(this.make, this.model, this.color, this.year) {
    mileage = 0.0;
    isEngineOn = false;
    fuelLevel = 100.0;
  }

  // Named constructor for used cars
  Car.used(this.make, this.model, this.color, this.year, this.mileage) {
    isEngineOn = false;
    fuelLevel = 50.0; // Used cars start with half tank
  }

  // Named constructor for luxury cars
  Car.luxury(String make, String model, int year) {
    this.make = make;
    this.model = model;
    this.color = "Black"; // Luxury cars default to black
    this.year = year;
    this.mileage = 0.0;
    this.isEngineOn = false;
    this.fuelLevel = 100.0;
  }

  // Methods
  void startEngine() {
    if (!isEngineOn) {
      isEngineOn = true;
      print("🚗 $make $model engine started! Vroom vroom!");
    } else {
      print("⚠️ Engine is already running!");
    }
  }

  void stopEngine() {
    if (isEngineOn) {
      isEngineOn = false;
      print("🛑 $make $model engine stopped.");
    } else {
      print("⚠️ Engine is already off!");
    }
  }

  void drive(double distance) {
    if (!isEngineOn) {
      print("❌ Cannot drive! Please start the engine first.");
      return;
    }

    if (fuelLevel <= 0) {
      print("⛽ Cannot drive! No fuel remaining.");
      return;
    }

    if (distance <= 0) {
      print("❌ Invalid distance! Please enter a positive number.");
      return;
    }

    // Calculate fuel consumption (assuming 10 miles per 1% fuel)
    double fuelNeeded = distance / 10;

    if (fuelNeeded > fuelLevel) {
      double maxDistance = fuelLevel * 10;
      print(
        "⛽ Not enough fuel! You can only drive ${maxDistance.toStringAsFixed(1)} miles.",
      );
      print("🚗 Driving ${maxDistance.toStringAsFixed(1)} miles...");
      mileage += maxDistance;
      fuelLevel = 0;
    } else {
      print(
        "🚗 Driving ${distance.toStringAsFixed(1)} miles in the $color $make $model...",
      );
      mileage += distance;
      fuelLevel -= fuelNeeded;
    }

    print("📊 Current mileage: ${mileage.toStringAsFixed(1)} miles");
    print("⛽ Fuel level: ${fuelLevel.toStringAsFixed(1)}%");
  }

  void refuel(double amount) {
    if (amount <= 0) {
      print("❌ Invalid fuel amount!");
      return;
    }

    fuelLevel += amount;
    if (fuelLevel > 100) {
      fuelLevel = 100;
    }

    print("⛽ Refueled! Current fuel level: ${fuelLevel.toStringAsFixed(1)}%");
  }

  void honk() {
    print("🔊 BEEP BEEP! ($make $model)");
  }

  void displayInfo() {
    print("🚗 Car Information:");
    print("   Make: $make");
    print("   Model: $model");
    print("   Color: $color");
    print("   Year: $year");
    print("   Mileage: ${mileage.toStringAsFixed(1)} miles");
    print("   Engine: ${isEngineOn ? 'ON' : 'OFF'}");
    print("   Fuel Level: ${fuelLevel.toStringAsFixed(1)}%");
    print("-" * 40);
  }

  // Method to check if car needs maintenance
  bool needsMaintenance() {
    return mileage > 5000; // Needs maintenance every 5000 miles
  }

  // Method to get car age
  int getAge() {
    return DateTime.now().year - year;
  }

  // Method to calculate estimated value (simple depreciation)
  double getEstimatedValue(double originalPrice) {
    int age = getAge();
    double depreciationRate = 0.15; // 15% per year
    double value = originalPrice * (1 - (depreciationRate * age));
    return value > 0 ? value : 1000; // Minimum value of $1000
  }
}

void main() {
  print("Car Class Practice");
  print("==================");

  // Creating different cars using different constructors
  Car car1 = Car();
  car1.displayInfo();

  Car car2 = Car.withDetails("Toyota", "Camry", "Blue", 2022);
  car2.displayInfo();

  Car car3 = Car.used("Honda", "Civic", "Red", 2018, 25000);
  car3.displayInfo();

  Car car4 = Car.luxury("BMW", "X5", 2023);
  car4.displayInfo();

  print("🎯 Testing Car Operations:");
  print("=========================");

  // Test driving without starting engine
  car2.drive(50);

  // Start engine and drive
  car2.startEngine();
  car2.drive(100);
  car2.honk();

  // Drive more to test fuel consumption
  car2.drive(200);
  car2.drive(300);
  car2.drive(500); // This should run out of fuel

  // Refuel and continue
  car2.refuel(50);
  car2.drive(100);

  // Check maintenance
  if (car2.needsMaintenance()) {
    print("🔧 ${car2.make} ${car2.model} needs maintenance!");
  }

  // Display final info
  car2.displayInfo();

  // Calculate estimated value
  double originalPrice = 25000;
  double currentValue = car2.getEstimatedValue(originalPrice);
  print("💰 Estimated current value: \$${currentValue.toStringAsFixed(2)}");

  car2.stopEngine();
}
