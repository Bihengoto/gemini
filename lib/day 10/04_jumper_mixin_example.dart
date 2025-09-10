// Jumper Mixin Example - Day 10 Practice

// Base Animal class
class Animal {
  String name;
  int energy;

  Animal(this.name, this.energy);

  void eat() {
    energy += 10;
    print('$name is eating. Energy: $energy');
  }

  void sleep() {
    energy += 20;
    print('$name is sleeping. Energy: $energy');
  }

  void displayInfo() {
    print('Animal: $name, Energy: $energy');
  }
}

// Jumper mixin
mixin Jumper {
  // Abstract property that must be provided by the using class
  int get energy;
  set energy(int value);
  String get name;

  // Jump height based on energy level
  double get jumpHeight => energy * 0.1;

  // Basic jump method
  void jump() {
    if (energy >= 5) {
      energy -= 5;
      print(
        '$name jumps ${jumpHeight.toStringAsFixed(1)} meters high! Energy: $energy',
      );
    } else {
      print('$name is too tired to jump. Energy: $energy');
    }
  }

  // High jump method
  void highJump() {
    if (energy >= 15) {
      energy -= 15;
      double height = jumpHeight * 2;
      print(
        '$name performs a high jump ${height.toStringAsFixed(1)} meters high! Energy: $energy',
      );
    } else {
      print('$name needs more energy for a high jump. Current energy: $energy');
    }
  }

  // Long jump method
  void longJump() {
    if (energy >= 10) {
      energy -= 10;
      double distance = jumpHeight * 3;
      print(
        '$name performs a long jump ${distance.toStringAsFixed(1)} meters far! Energy: $energy',
      );
    } else {
      print('$name needs more energy for a long jump. Current energy: $energy');
    }
  }

  // Check if animal can jump
  bool canJump() => energy >= 5;
}

// Rabbit class using the Jumper mixin
class Rabbit extends Animal with Jumper {
  Rabbit(String name) : super(name, 50);

  @override
  void displayInfo() {
    super.displayInfo();
    print('Jump height: ${jumpHeight.toStringAsFixed(1)} meters');
    print('Can jump: ${canJump()}');
  }
}

// Kangaroo class using the Jumper mixin
class Kangaroo extends Animal with Jumper {
  Kangaroo(String name) : super(name, 80);

  // Kangaroos are better jumpers
  @override
  double get jumpHeight => energy * 0.15;

  @override
  void displayInfo() {
    super.displayInfo();
    print('Jump height: ${jumpHeight.toStringAsFixed(1)} meters');
    print('Can jump: ${canJump()}');
  }
}

// Frog class using the Jumper mixin
class Frog extends Animal with Jumper {
  Frog(String name) : super(name, 30);

  // Frogs have unique jumping style
  void ribbitJump() {
    if (canJump()) {
      print('$name says "Ribbit!" and jumps!');
      jump();
    } else {
      print('$name croaks tiredly...');
    }
  }
}

void main() {
  print('=== Jumper Mixin Example ===\n');

  // Create animals with jumping ability
  var rabbit = Rabbit('Bunny');
  var kangaroo = Kangaroo('Joey');
  var frog = Frog('Kermit');

  print('--- Initial State ---');
  rabbit.displayInfo();
  kangaroo.displayInfo();
  frog.displayInfo();

  print('\n--- Jumping Actions ---');

  // Rabbit jumping
  print('\nRabbit actions:');
  rabbit.jump();
  rabbit.longJump();
  rabbit.highJump(); // Should fail due to low energy

  // Kangaroo jumping
  print('\nKangaroo actions:');
  kangaroo.jump();
  kangaroo.highJump();
  kangaroo.longJump();

  // Frog jumping
  print('\nFrog actions:');
  frog.ribbitJump();
  frog.jump();
  frog.jump(); // Should fail due to low energy

  print('\n--- After eating and resting ---');
  rabbit.eat();
  rabbit.sleep();
  frog.eat();

  print('\nRabbit after rest:');
  rabbit.displayInfo();
  rabbit.highJump(); // Should work now

  print('\nFrog after eating:');
  frog.displayInfo();
  frog.ribbitJump(); // Should work now
}
