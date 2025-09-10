// Day 8: OOP - Inheritance Summary and Best Practices
// Complete overview of inheritance concepts with examples

/*
INHERITANCE SUMMARY:

1. BASIC INHERITANCE:
   - Use 'extends' keyword to create subclass
   - Child inherits all public members from parent
   - Child can add new properties and methods

2. SUPER KEYWORD:
   - Refers to immediate parent class
   - super() calls parent constructor
   - super.method() calls parent method
   - Must be first statement in constructor

3. METHOD OVERRIDING:
   - Child provides specific implementation of parent method
   - Use @override annotation
   - Same signature as parent method
   - Enables polymorphism

4. BEST PRACTICES:
   - Use inheritance for "is-a" relationships
   - Keep inheritance hierarchies shallow
   - Favor composition over inheritance when appropriate
   - Use @override annotation for clarity
   - Document inheritance relationships
*/

// Example demonstrating all concepts together
abstract class Employee {
  String name;
  int id;
  double baseSalary;

  Employee(this.name, this.id, this.baseSalary);

  // Abstract method - must be implemented by subclasses
  double calculateSalary();

  // Concrete method that can be overridden
  void displayInfo() {
    print('Employee: $name (ID: $id)');
    print('Base Salary: \$${baseSalary.toStringAsFixed(2)}');
  }

  void work() {
    print('$name is working...');
  }
}

class FullTimeEmployee extends Employee {
  double benefits;
  int vacationDays;

  FullTimeEmployee(
    String name,
    int id,
    double baseSalary,
    this.benefits,
    this.vacationDays,
  ) : super(name, id, baseSalary);

  @override
  double calculateSalary() {
    return baseSalary + benefits;
  }

  @override
  void displayInfo() {
    super.displayInfo(); // Call parent method
    print('Type: Full-time');
    print('Benefits: \$${benefits.toStringAsFixed(2)}');
    print('Vacation Days: $vacationDays');
    print('Total Salary: \$${calculateSalary().toStringAsFixed(2)}');
  }

  void takeVacation(int days) {
    if (days <= vacationDays) {
      vacationDays -= days;
      print('$name took $days vacation days. Remaining: $vacationDays');
    } else {
      print('Not enough vacation days available.');
    }
  }
}

class PartTimeEmployee extends Employee {
  int hoursPerWeek;
  double hourlyRate;

  PartTimeEmployee(String name, int id, this.hoursPerWeek, this.hourlyRate)
    : super(name, id, 0); // Part-time has no base salary

  @override
  double calculateSalary() {
    return hoursPerWeek * hourlyRate * 52; // Annual salary
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print('Type: Part-time');
    print('Hours per week: $hoursPerWeek');
    print('Hourly rate: \$${hourlyRate.toStringAsFixed(2)}');
    print('Annual Salary: \$${calculateSalary().toStringAsFixed(2)}');
  }

  @override
  void work() {
    super.work();
    print('$name is working part-time ($hoursPerWeek hours/week)');
  }
}

class Manager extends FullTimeEmployee {
  List<Employee> team;
  double bonus;

  Manager(
    String name,
    int id,
    double baseSalary,
    double benefits,
    int vacationDays,
    this.bonus,
  ) : team = [],
      super(name, id, baseSalary, benefits, vacationDays);

  @override
  double calculateSalary() {
    return super.calculateSalary() + bonus; // Add bonus to full-time salary
  }

  @override
  void displayInfo() {
    super.displayInfo();
    print('Role: Manager');
    print('Team size: ${team.length}');
    print('Bonus: \$${bonus.toStringAsFixed(2)}');
    print('Total with bonus: \$${calculateSalary().toStringAsFixed(2)}');
  }

  void addTeamMember(Employee employee) {
    team.add(employee);
    print('${employee.name} added to ${name}\'s team');
  }

  void conductMeeting() {
    print('$name is conducting a team meeting with ${team.length} members');
  }

  @override
  void work() {
    super.work();
    print('$name is managing team and conducting meetings');
  }
}

// Utility function to demonstrate polymorphism
void processEmployee(Employee employee) {
  print('\n--- Processing Employee ---');
  employee.displayInfo();
  employee.work();
  print(
    'Calculated salary: \$${employee.calculateSalary().toStringAsFixed(2)}',
  );
}

void main() {
  print('=== INHERITANCE COMPLETE EXAMPLE ===\n');

  // Create different types of employees
  FullTimeEmployee fullTime = FullTimeEmployee(
    'Alice Johnson',
    101,
    50000,
    5000,
    20,
  );
  PartTimeEmployee partTime = PartTimeEmployee('Bob Smith', 102, 20, 25.0);
  Manager manager = Manager('Carol Davis', 103, 70000, 8000, 25, 10000);

  // Add team members to manager
  manager.addTeamMember(fullTime);
  manager.addTeamMember(partTime);

  print('--- Full-time Employee ---');
  fullTime.displayInfo();
  fullTime.takeVacation(5);

  print('\n--- Part-time Employee ---');
  partTime.displayInfo();

  print('\n--- Manager ---');
  manager.displayInfo();
  manager.conductMeeting();

  print('\n=== POLYMORPHISM DEMONSTRATION ===');
  List<Employee> employees = [fullTime, partTime, manager];

  for (Employee emp in employees) {
    processEmployee(emp); // Same method, different behavior
  }

  print('\n=== INHERITANCE HIERARCHY SUMMARY ===');
  print('Employee (abstract)');
  print('├── FullTimeEmployee');
  print('│   └── Manager');
  print('└── PartTimeEmployee');

  print('\nKey Concepts Demonstrated:');
  print('✓ extends keyword for inheritance');
  print('✓ super keyword for parent access');
  print('✓ Method overriding with @override');
  print('✓ Abstract classes and methods');
  print('✓ Polymorphism through inheritance');
  print('✓ Multi-level inheritance');
  print('✓ Adding new properties and methods in subclasses');
}
