// Interface Example using implements keyword

// Define interfaces (any class can serve as an interface)
class Flyable {
  void fly() {
    print('Flying in the sky');
  }
}

class Swimmable {
  void swim() {
    print('Swimming in water');
  }
}

class Walkable {
  void walk() {
    print('Walking on land');
  }
}

// Class implementing multiple interfaces
class Duck implements Flyable, Swimmable, Walkable {
  String name;

  Duck(this.name);

  // Must implement all methods from interfaces
  @override
  void fly() {
    print('$name is flying with flapping wings');
  }

  @override
  void swim() {
    print('$name is swimming and paddling in the pond');
  }

  @override
  void walk() {
    print('$name is waddling on the ground');
  }

  void quack() {
    print('$name says: Quack! Quack!');
  }
}

class Fish implements Swimmable {
  String name;
  String type;

  Fish(this.name, this.type);

  @override
  void swim() {
    print('$name the $type is swimming gracefully underwater');
  }

  void breatheUnderwater() {
    print('$name is breathing through gills');
  }
}

class Bird implements Flyable, Walkable {
  String name;
  String species;

  Bird(this.name, this.species);

  @override
  void fly() {
    print('$name the $species is soaring high in the sky');
  }

  @override
  void walk() {
    print('$name is hopping on the branch');
  }

  void chirp() {
    print('$name is chirping melodiously');
  }
}

void main() {
  print('=== Duck (Multiple Interfaces) ===');
  Duck duck = Duck('Donald');
  duck.fly();
  duck.swim();
  duck.walk();
  duck.quack();

  print('\n=== Fish (Single Interface) ===');
  Fish fish = Fish('Nemo', 'Clownfish');
  fish.swim();
  fish.breatheUnderwater();

  print('\n=== Bird (Multiple Interfaces) ===');
  Bird bird = Bird('Tweety', 'Canary');
  bird.fly();
  bird.walk();
  bird.chirp();

  print('\n=== Polymorphism with Interfaces ===');
  List<Flyable> flyingAnimals = [duck, bird];
  for (Flyable animal in flyingAnimals) {
    animal.fly();
  }

  List<Swimmable> swimmingAnimals = [duck, fish];
  for (Swimmable animal in swimmingAnimals) {
    animal.swim();
  }
}
