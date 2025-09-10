// Practice Exercises - Day 10: Mixins

// Exercise 1: Create a Speakable mixin
// TODO: Create a mixin called Speakable with methods speak() and whisper()

// Exercise 2: Create a Colorable mixin
// TODO: Create a mixin that manages color properties and methods

// Exercise 3: Multiple mixins combination
// TODO: Create a class that uses multiple mixins

// ============= SOLUTIONS =============

// Solution 1: Speakable mixin
mixin Speakable {
  String get name;

  void speak(String message) {
    print('$name says: "$message"');
  }

  void whisper(String message) {
    print('$name whispers: "$message"');
  }

  void shout(String message) {
    print('$name shouts: "${message.toUpperCase()}!"');
  }
}

// Solution 2: Colorable mixin
mixin Colorable {
  String _color = 'natural';

  String get color => _color;

  void changeColor(String newColor) {
    _color = newColor;
    print('Color changed to $_color');
  }

  void resetColor() {
    _color = 'natural';
    print('Color reset to natural');
  }

  bool get isColorful => _color != 'natural';
}

// Solution 3: Magical mixin for fantasy creatures
mixin Magical {
  int _mana = 100;

  int get mana => _mana;

  void castSpell(String spell, int manaCost) {
    if (_mana >= manaCost) {
      _mana -= manaCost;
      print('✨ Casting $spell! Mana remaining: $_mana');
    } else {
      print('❌ Not enough mana to cast $spell. Need $manaCost, have $_mana');
    }
  }

  void restoreMana(int amount) {
    _mana += amount;
    if (_mana > 100) _mana = 100;
    print('🔮 Mana restored. Current mana: $_mana');
  }
}

// Base classes
class Animal {
  String name;
  int energy;

  Animal(this.name, this.energy);

  void eat() {
    energy += 10;
    print('$name is eating. Energy: $energy');
  }
}

class Creature {
  String name;
  String type;

  Creature(this.name, this.type);

  void introduce() {
    print('I am $name, a $type');
  }
}

// Example classes using mixins
class Parrot extends Animal with Speakable, Colorable {
  Parrot(String name) : super(name, 40);

  void mimicSound(String sound) {
    print('$name mimics: "$sound"');
  }
}

class Dragon extends Creature with Speakable, Magical, Colorable {
  Dragon(String name) : super(name, 'Dragon');

  void breatheFire() {
    castSpell('Fire Breath', 20);
  }

  void fly() {
    print('$name spreads mighty wings and soars into the sky!');
  }
}

class Chameleon extends Animal with Colorable {
  Chameleon(String name) : super(name, 25);

  void camouflage() {
    changeColor('environment-matching');
    print('$name blends into the surroundings');
  }
}

// Advanced Exercise: Create a mixin with constraints
mixin Rideable on Animal {
  bool _isRidden = false;

  void mount() {
    if (energy >= 20) {
      _isRidden = true;
      print('$name is now being ridden');
    } else {
      print('$name is too tired to be ridden');
    }
  }

  void dismount() {
    _isRidden = false;
    print('Dismounted from $name');
  }

  bool get isBeingRidden => _isRidden;
}

class Horse extends Animal with Rideable {
  Horse(String name) : super(name, 80);

  void gallop() {
    if (isBeingRidden && energy >= 15) {
      energy -= 15;
      print('$name gallops swiftly! Energy: $energy');
    } else if (!isBeingRidden) {
      print('$name needs a rider to gallop');
    } else {
      print('$name is too tired to gallop');
    }
  }
}

void main() {
  print('=== Mixin Practice Exercises ===\n');

  // Test Parrot with Speakable and Colorable
  print('--- Parrot Example ---');
  var parrot = Parrot('Polly');
  parrot.speak('Hello there!');
  parrot.whisper('Secret message');
  parrot.shout('I can fly!');
  parrot.changeColor('bright red');
  parrot.mimicSound('Woof woof!');
  parrot.resetColor();

  // Test Dragon with multiple mixins
  print('\n--- Dragon Example ---');
  var dragon = Dragon('Smaug');
  dragon.introduce();
  dragon.speak('I am the mighty dragon!');
  dragon.changeColor('golden');
  dragon.breatheFire();
  dragon.castSpell('Lightning Bolt', 30);
  dragon.restoreMana(25);
  dragon.fly();

  // Test Chameleon with Colorable
  print('\n--- Chameleon Example ---');
  var chameleon = Chameleon('Charlie');
  chameleon.changeColor('green');
  chameleon.camouflage();
  print('Is colorful: ${chameleon.isColorful}');

  // Test Horse with Rideable mixin (constrained)
  print('\n--- Horse Example ---');
  var horse = Horse('Thunder');
  horse.gallop(); // Should fail - no rider
  horse.mount();
  horse.gallop(); // Should work
  horse.eat(); // Restore energy
  horse.gallop();
  horse.dismount();

  print('\n=== Exercise Complete! ===');
  print('You have successfully implemented and used various mixins:');
  print('✅ Speakable mixin for communication');
  print('✅ Colorable mixin for color management');
  print('✅ Magical mixin for spell casting');
  print('✅ Rideable mixin with constraints');
  print('✅ Multiple mixin combinations');
}

// Additional Practice Ideas:
// 1. Create a Trackable mixin that logs all method calls
// 2. Create a Serializable mixin for JSON conversion
// 3. Create a Comparable mixin for sorting objects
// 4. Create a Cacheable mixin for caching results
// 5. Combine multiple mixins in creative ways
