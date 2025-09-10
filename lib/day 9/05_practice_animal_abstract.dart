// Practice: Animal Abstract Class with Dog Implementation

// Abstract Animal class
abstract class Animal {
  String name;
  int age;

  // Constructor
  Animal(this.name, this.age);

  // Abstract method that must be implemented
  void makeSound();

  // Concrete methods that can be inherited
  void eat() {
    print('$name is eating...');
  }

  void sleep() {
    print('$name is sleeping peacefully...');
  }

  void displayInfo() {
    print('Animal: $name, Age: $age years');
  }
}

// Dog class implementing the abstract Animal class
class Dog extends Animal {
  String breed;
  String color;

  // Constructor calling super constructor
  Dog(String name, int age, this.breed, this.color) : super(name, age);

  // Implementation of abstract method
  @override
  void makeSound() {
    print('$name barks: Woof! Woof! Bow-wow!');
  }

  // Dog-specific methods
  void wagTail() {
    print('$name is wagging tail excitedly!');
  }

  void fetch() {
    print('$name is fetching the ball!');
  }

  void guard() {
    print('$name is guarding the house!');
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print('Breed: $breed, Color: $color');
  }
}

// Additional implementations for demonstration
class Cat extends Animal {
  bool isIndoor;

  Cat(String name, int age, this.isIndoor) : super(name, age);

  @override
  void makeSound() {
    print('$name meows: Meow! Purr...');
  }

  void climb() {
    print('$name is climbing the tree!');
  }

  void hunt() {
    print('$name is hunting mice!');
  }
}

class Bird extends Animal {
  double wingspan;

  Bird(String name, int age, this.wingspan) : super(name, age);

  @override
  void makeSound() {
    print('$name chirps: Tweet! Tweet!');
  }

  void fly() {
    print('$name is flying with ${wingspan}cm wingspan!');
  }
}

void main() {
  print('=== Practice: Animal Abstract Class ===\n');

  // Create Dog instance
  Dog myDog = Dog('Max', 4, 'German Shepherd', 'Brown and Black');

  print('--- Dog Actions ---');
  myDog.displayInfo();
  myDog.makeSound();
  myDog.eat();
  myDog.wagTail();
  myDog.fetch();
  myDog.guard();
  myDog.sleep();

  print('\n--- Other Animals ---');

  // Create other animals to show polymorphism
  Cat myCat = Cat('Luna', 2, true);
  Bird myBird = Bird('Charlie', 1, 25.5);

  // List of animals demonstrating polymorphism
  List<Animal> animals = [myDog, myCat, myBird];

  print('\nAll animals making sounds:');
  for (Animal animal in animals) {
    animal.makeSound();
  }

  print('\nAll animals eating:');
  for (Animal animal in animals) {
    animal.eat();
  }

  // Demonstrate that we cannot instantiate abstract class
  print('\n--- Abstract Class Rules ---');
  print('✓ Can create Dog, Cat, Bird instances');
  print('✗ Cannot create Animal instance directly');
  // Animal animal = Animal('Generic', 5); // This would cause compilation error
}
