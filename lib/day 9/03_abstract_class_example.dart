// Abstract Class Example

// Abstract class - cannot be instantiated
abstract class Animal {
  String name;
  int age;

  // Constructor for abstract class
  Animal(this.name, this.age);

  // Abstract method - must be implemented by subclasses
  void makeSound();

  // Concrete method - can be used by subclasses
  void sleep() {
    print('$name is sleeping...');
  }

  // Concrete method with implementation
  void displayInfo() {
    print('Name: $name, Age: $age years old');
  }

  // Abstract getter
  String get species;
}

// Concrete class extending abstract class
class Dog extends Animal {
  String breed;

  Dog(String name, int age, this.breed) : super(name, age);

  // Must implement abstract method
  @override
  void makeSound() {
    print('$name says: Woof! Woof!');
  }

  // Must implement abstract getter
  @override
  String get species => 'Canine';

  // Additional method specific to Dog
  void wagTail() {
    print('$name is wagging tail happily!');
  }
}

class Cat extends Animal {
  bool isIndoor;

  Cat(String name, int age, this.isIndoor) : super(name, age);

  @override
  void makeSound() {
    print('$name says: Meow! Meow!');
  }

  @override
  String get species => 'Feline';

  void purr() {
    print('$name is purring contentedly...');
  }
}

void main() {
  // Cannot instantiate abstract class
  // Animal animal = Animal('Generic', 5); // This would cause an error

  // Create instances of concrete classes
  Dog myDog = Dog('Buddy', 3, 'Golden Retriever');
  Cat myCat = Cat('Whiskers', 2, true);

  print('=== Dog Information ===');
  myDog.displayInfo();
  print('Species: ${myDog.species}');
  print('Breed: ${myDog.breed}');
  myDog.makeSound();
  myDog.wagTail();
  myDog.sleep();

  print('\n=== Cat Information ===');
  myCat.displayInfo();
  print('Species: ${myCat.species}');
  print('Indoor cat: ${myCat.isIndoor}');
  myCat.makeSound();
  myCat.purr();
  myCat.sleep();
}
