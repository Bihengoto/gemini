/*
Day 7: Classes and Objects in Dart

A CLASS is a blueprint or template for creating objects.
An OBJECT is an instance of a class.

Class Definition Syntax:
class ClassName {
  // Instance variables (properties)
  // Methods (functions)
}

Instance Variables: Variables that belong to an object
Methods: Functions that belong to a class and can access instance variables
*/

// Basic class definition
class Person {
  // Instance variables
  String name;
  int age;
  String email;

  // Method to display person information
  void displayInfo() {
    print("Name: $name");
    print("Age: $age");
    print("Email: $email");
  }

  // Method to check if person is adult
  bool isAdult() {
    return age >= 18;
  }

  // Method to celebrate birthday
  void celebrateBirthday() {
    age++;
    print("Happy Birthday $name! You are now $age years old.");
  }
}

// Example of a simple class with different data types
class Student {
  String studentId;
  String name;
  List<String> subjects;
  double gpa;
  bool isEnrolled;

  void addSubject(String subject) {
    subjects.add(subject);
    print("Added $subject to $name's subjects");
  }

  void displayTranscript() {
    print("Student ID: $studentId");
    print("Name: $name");
    print("GPA: $gpa");
    print("Subjects: ${subjects.join(', ')}");
    print("Enrollment Status: ${isEnrolled ? 'Active' : 'Inactive'}");
  }
}

void main() {
  print("Classes and Objects Example");
  print("==========================");

  // Creating objects (instances of classes)
  Person person1 = Person();
  person1.name = "Alice Johnson";
  person1.age = 25;
  person1.email = "alice@email.com";

  Person person2 = Person();
  person2.name = "Bob Smith";
  person2.age = 17;
  person2.email = "bob@email.com";

  // Using object methods
  print("Person 1 Information:");
  person1.displayInfo();
  print("Is adult: ${person1.isAdult()}");

  print("\nPerson 2 Information:");
  person2.displayInfo();
  print("Is adult: ${person2.isAdult()}");

  print("\nCelebrating birthday:");
  person1.celebrateBirthday();

  print("\n" + "=" * 40);

  // Student example
  Student student = Student();
  student.studentId = "STU001";
  student.name = "Emma Wilson";
  student.subjects = ["Math", "Physics"];
  student.gpa = 3.8;
  student.isEnrolled = true;

  student.addSubject("Chemistry");
  print("\nStudent Information:");
  student.displayTranscript();
}
