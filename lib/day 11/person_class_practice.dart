// Practice: Person Class with fullName Getter

class Person {
  // Private fields
  String _firstName;
  String _lastName;
  int _age;

  // Constructor
  Person(this._firstName, this._lastName, [this._age = 0]);

  // Getter for firstName
  String get firstName => _firstName;

  // Setter for firstName with validation
  set firstName(String value) {
    if (value.isNotEmpty && value.trim().isNotEmpty) {
      _firstName = value.trim();
    } else {
      throw ArgumentError('First name cannot be empty');
    }
  }

  // Getter for lastName
  String get lastName => _lastName;

  // Setter for lastName with validation
  set lastName(String value) {
    if (value.isNotEmpty && value.trim().isNotEmpty) {
      _lastName = value.trim();
    } else {
      throw ArgumentError('Last name cannot be empty');
    }
  }

  // Getter for age
  int get age => _age;

  // Setter for age with validation
  set age(int value) {
    if (value >= 0 && value <= 150) {
      _age = value;
    } else {
      throw ArgumentError('Age must be between 0 and 150');
    }
  }

  // Custom fullName getter - combines firstName and lastName
  String get fullName => '$_firstName $_lastName';

  // Custom fullName setter - splits and assigns to firstName and lastName
  set fullName(String value) {
    var parts = value.trim().split(' ');
    if (parts.length >= 2) {
      _firstName = parts.first;
      _lastName = parts.sublist(1).join(' '); // Handle multiple last names
    } else {
      throw ArgumentError(
        'Full name must contain at least first and last name',
      );
    }
  }

  // Computed property - initials
  String get initials =>
      '${_firstName[0].toUpperCase()}${_lastName[0].toUpperCase()}';

  // Check if person is adult
  bool get isAdult => _age >= 18;

  // Check if person is senior
  bool get isSenior => _age >= 65;

  @override
  String toString() {
    return 'Person(fullName: $fullName, age: $_age)';
  }
}

void main() {
  // Create a person
  var person = Person('John', 'Doe', 25);

  print('Initial person: $person');
  print('Full name: ${person.fullName}');
  print('Initials: ${person.initials}');
  print('Is adult: ${person.isAdult}');
  print('Is senior: ${person.isSenior}');

  // Modify using individual setters
  person.firstName = 'Jane';
  person.lastName = 'Smith';
  person.age = 30;

  print('\nAfter individual modifications: $person');

  // Modify using fullName setter
  person.fullName = 'Alice Johnson Brown';
  print('After fullName modification: $person');
  print('First name: ${person.firstName}');
  print('Last name: ${person.lastName}');

  // Test age-related computed properties
  person.age = 70;
  print('\nAge updated to 70:');
  print('Is adult: ${person.isAdult}');
  print('Is senior: ${person.isSenior}');

  // Test validation
  print('\nTesting validation:');

  try {
    person.firstName = '';
  } catch (e) {
    print('Error setting empty first name: $e');
  }

  try {
    person.age = -5;
  } catch (e) {
    print('Error setting negative age: $e');
  }

  try {
    person.fullName = 'OneName';
  } catch (e) {
    print('Error setting invalid full name: $e');
  }
}
