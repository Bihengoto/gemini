// Day 8: OOP - Super Keyword
// Learn how to use the super keyword to call parent class constructor and methods

/*
SUPER KEYWORD NOTES:
- 'super' refers to the immediate parent class
- Used to call parent class constructor: super(parameters)
- Used to call parent class methods: super.methodName()
- Must be the first statement in constructor when calling super constructor
- Useful when you want to extend parent functionality rather than replace it
- Helps avoid code duplication
*/

// Parent Class
class Animal {
  String name;
  String species;
  int age;

  Animal(this.name, this.species, this.age);

  void eat() {
    print('$name is eating...');
  }

  void sleep() {
    print('$name is sleeping...');
  }

  void makeSound() {
    print('$name makes a sound');
  }

  void displayInfo() {
    print('Animal: $name, Species: $species, Age: $age years');
  }
}

// Child Class using super keyword
class Dog extends Animal {
  String breed;
  bool isVaccinated;

  // Constructor using super to call parent constructor
  Dog(String name, int age, this.breed, this.isVaccinated)
    : super(name, 'Canine', age);

  // Method that extends parent functionality using super
  @override
  void eat() {
    super.eat(); // Call parent method first
    print('$name is wagging tail while eating!');
  }

  // Method that uses super to call parent method
  @override
  void makeSound() {
    super.makeSound(); // Call parent method
    print('$name barks: Woof! Woof!');
  }

  // Override parent method and extend it
  @override
  void displayInfo() {
    super.displayInfo(); // Call parent display
    print('Breed: $breed, Vaccinated: ${isVaccinated ? 'Yes' : 'No'}');
  }

  // New method specific to Dog
  void fetch() {
    print('$name is fetching the ball!');
  }
}

// Another child class demonstrating super usage
class Cat extends Animal {
  bool isIndoor;
  String furColor;

  Cat(String name, int age, this.isIndoor, this.furColor)
    : super(name, 'Feline', age);

  @override
  void makeSound() {
    super.makeSound();
    print('$name meows: Meow! Meow!');
  }

  @override
  void sleep() {
    print('$name finds a cozy spot...');
    super.sleep(); // Call parent method after custom logic
    print('$name is purring while sleeping');
  }

  void climb() {
    print('$name is climbing up high!');
  }
}

void main() {
  print('=== SUPER KEYWORD EXAMPLES ===\n');

  // Dog example
  Dog dog = Dog('Buddy', 3, 'Golden Retriever', true);
  dog.displayInfo(); // Uses super to extend parent method
  print('');

  dog.eat(); // Uses super to call parent method first
  print('');

  dog.makeSound(); // Uses super then adds dog-specific sound
  dog.fetch(); // Dog-specific method
  print('');

  // Cat example
  Cat cat = Cat('Whiskers', 2, true, 'Orange');
  cat.displayInfo(); // Inherited method
  print('');

  cat.makeSound(); // Uses super then adds cat-specific sound
  print('');

  cat.sleep(); // Uses super with additional cat behavior
  cat.climb(); // Cat-specific method
}
