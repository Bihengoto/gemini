// Advanced Mixin Examples - Day 10

// Example 1: Multiple Mixins
mixin Flyable {
  String get name;
  int get energy;
  set energy(int value);

  void fly() {
    if (energy >= 10) {
      energy -= 10;
      print('$name is flying! Energy: $energy');
    } else {
      print('$name is too tired to fly');
    }
  }
}

mixin Swimmable {
  String get name;
  int get energy;
  set energy(int value);

  void swim() {
    if (energy >= 8) {
      energy -= 8;
      print('$name is swimming! Energy: $energy');
    } else {
      print('$name is too tired to swim');
    }
  }
}

// Duck can both fly and swim
class Duck extends Animal with Flyable, Swimmable {
  Duck(String name) : super(name, 60);

  void migrate() {
    print('$name is migrating...');
    fly();
    swim();
    fly();
  }
}

// Example 2: Mixin with Constraints
class Vehicle {
  String brand;
  int speed;

  Vehicle(this.brand, this.speed);
}

// This mixin can only be used by Vehicle subclasses
mixin Turbo on Vehicle {
  void activateTurbo() {
    speed *= 2;
    print('$brand activates turbo! Speed: $speed km/h');
  }

  void deactivateTurbo() {
    speed ~/= 2;
    print('$brand deactivates turbo. Speed: $speed km/h');
  }
}

class Car extends Vehicle with Turbo {
  Car(String brand, int speed) : super(brand, speed);
}

// Example 3: Mixin with State Management
mixin Trackable {
  final List<String> _activities = [];

  void logActivity(String activity) {
    _activities.add('${DateTime.now()}: $activity');
  }

  void showActivityLog() {
    print('Activity Log:');
    for (var activity in _activities) {
      print('  $activity');
    }
  }

  int get activityCount => _activities.length;
}

class Robot with Trackable {
  String name;

  Robot(this.name);

  void work() {
    print('$name is working');
    logActivity('Working');
  }

  void rest() {
    print('$name is resting');
    logActivity('Resting');
  }
}

// Example 4: Mixin Composition
mixin Debuggable {
  void debug(String message) {
    print('[DEBUG] ${runtimeType}: $message');
  }
}

mixin Loggable {
  void log(String message) {
    print('[LOG] ${DateTime.now()}: $message');
  }
}

class Service with Debuggable, Loggable {
  String name;

  Service(this.name);

  void start() {
    debug('Starting service $name');
    log('Service $name started');
  }

  void stop() {
    debug('Stopping service $name');
    log('Service $name stopped');
  }
}

// Base Animal class for examples
class Animal {
  String name;
  int energy;

  Animal(this.name, this.energy);

  void eat() {
    energy += 10;
    print('$name is eating. Energy: $energy');
  }
}

void main() {
  print('=== Advanced Mixin Examples ===\n');

  // Example 1: Multiple Mixins
  print('--- Duck with Multiple Mixins ---');
  var duck = Duck('Donald');
  duck.fly();
  duck.swim();
  duck.eat();
  duck.migrate();

  // Example 2: Mixin with Constraints
  print('\n--- Car with Turbo Mixin ---');
  var car = Car('Ferrari', 200);
  print('Initial speed: ${car.speed} km/h');
  car.activateTurbo();
  car.deactivateTurbo();

  // Example 3: Trackable Mixin
  print('\n--- Robot with Trackable Mixin ---');
  var robot = Robot('R2D2');
  robot.work();
  robot.rest();
  robot.work();
  print('Total activities: ${robot.activityCount}');
  robot.showActivityLog();

  // Example 4: Service with Multiple Mixins
  print('\n--- Service with Debug and Log Mixins ---');
  var service = Service('WebServer');
  service.start();
  service.stop();
}
