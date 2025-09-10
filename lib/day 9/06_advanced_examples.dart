// Advanced Examples: Combining Abstract Classes and Interfaces

// Abstract class for vehicles
abstract class Vehicle {
  String brand;
  String model;
  int year;

  Vehicle(this.brand, this.model, this.year);

  // Abstract methods
  void start();
  void stop();
  double calculateFuelEfficiency();

  // Concrete method
  void displayInfo() {
    print('$year $brand $model');
  }
}

// Interfaces for different capabilities
class Electric {
  void charge() {
    print('Charging battery...');
  }

  double getBatteryLevel() {
    return 85.5; // Mock battery level
  }
}

class GPS {
  void navigate(String destination) {
    print('Navigating to $destination...');
  }

  String getCurrentLocation() {
    return 'Current Location: 123 Main St';
  }
}

class Bluetooth {
  void connectDevice(String device) {
    print('Connecting to $device via Bluetooth...');
  }

  void playMusic() {
    print('Playing music via Bluetooth...');
  }
}

// Concrete class extending abstract class and implementing interfaces
class Tesla extends Vehicle implements Electric, GPS, Bluetooth {
  String autopilotVersion;

  Tesla(String model, int year, this.autopilotVersion)
    : super('Tesla', model, year);

  @override
  void start() {
    print('$brand $model starting silently... Ready to drive!');
  }

  @override
  void stop() {
    print('$brand $model stopped. Regenerative braking activated.');
  }

  @override
  double calculateFuelEfficiency() {
    return 120.0; // MPGe (Miles Per Gallon equivalent)
  }

  // Electric interface implementation
  @override
  void charge() {
    print('$brand $model charging at Supercharger station...');
  }

  @override
  double getBatteryLevel() {
    return 92.3;
  }

  // GPS interface implementation
  @override
  void navigate(String destination) {
    print('Tesla Navigation: Calculating optimal route to $destination');
  }

  @override
  String getCurrentLocation() {
    return 'Tesla GPS: Current location updated';
  }

  // Bluetooth interface implementation
  @override
  void connectDevice(String device) {
    print('Tesla Bluetooth: Connected to $device');
  }

  @override
  void playMusic() {
    print('Playing music through Tesla premium audio system');
  }

  // Tesla-specific methods
  void enableAutopilot() {
    print('Autopilot $autopilotVersion enabled. Hands-free driving activated!');
  }

  void summon() {
    print('Tesla is coming to you via Summon feature...');
  }
}

class Motorcycle extends Vehicle implements GPS, Bluetooth {
  String engineType;

  Motorcycle(String brand, String model, int year, this.engineType)
    : super(brand, model, year);

  @override
  void start() {
    print('$brand $model engine roaring to life! Vroom!');
  }

  @override
  void stop() {
    print('$brand $model engine stopped.');
  }

  @override
  double calculateFuelEfficiency() {
    return 45.0; // MPG
  }

  @override
  void navigate(String destination) {
    print('Motorcycle GPS: Route to $destination calculated');
  }

  @override
  String getCurrentLocation() {
    return 'Motorcycle GPS: Location tracked';
  }

  @override
  void connectDevice(String device) {
    print('Motorcycle Bluetooth: $device connected to helmet system');
  }

  @override
  void playMusic() {
    print('Playing music through helmet speakers');
  }

  void wheelie() {
    print('$brand $model performing a wheelie!');
  }
}

void main() {
  print('=== Advanced OOP: Abstract Classes + Interfaces ===\n');

  // Create Tesla instance
  Tesla myTesla = Tesla('Model S', 2023, 'FSD Beta 11.4');

  print('--- Tesla Operations ---');
  myTesla.displayInfo();
  myTesla.start();
  print('Fuel Efficiency: ${myTesla.calculateFuelEfficiency()} MPGe');
  myTesla.charge();
  print('Battery Level: ${myTesla.getBatteryLevel()}%');
  myTesla.navigate('San Francisco');
  myTesla.connectDevice('iPhone 14');
  myTesla.playMusic();
  myTesla.enableAutopilot();
  myTesla.summon();
  myTesla.stop();

  print('\n--- Motorcycle Operations ---');
  Motorcycle myBike = Motorcycle(
    'Harley-Davidson',
    'Street 750',
    2022,
    'V-Twin',
  );
  myBike.displayInfo();
  myBike.start();
  print('Fuel Efficiency: ${myBike.calculateFuelEfficiency()} MPG');
  myBike.navigate('Route 66');
  myBike.connectDevice('Bluetooth Helmet');
  myBike.playMusic();
  myBike.wheelie();
  myBike.stop();

  print('\n--- Polymorphism Demo ---');
  List<Vehicle> vehicles = [myTesla, myBike];

  print('\nAll vehicles starting:');
  for (Vehicle vehicle in vehicles) {
    vehicle.start();
  }

  print('\nAll vehicles with GPS navigating:');
  for (Vehicle vehicle in vehicles) {
    if (vehicle is GPS) {
      (vehicle as GPS).navigate('Home');
    }
  }

  print('\nAll electric vehicles charging:');
  for (Vehicle vehicle in vehicles) {
    if (vehicle is Electric) {
      (vehicle as Electric).charge();
    }
  }
}
