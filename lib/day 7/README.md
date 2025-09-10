# Day 7: Object-Oriented Programming (OOP) - Classes & Objects

Welcome to Day 7 of your Dart learning journey! Today we dive deep into Object-Oriented Programming, one of the most important programming paradigms.

## 📚 Learning Objectives

By the end of this day, you will:
- Understand the four core principles of OOP
- Know how to define classes and create objects
- Master instance variables and methods
- Learn about different types of constructors
- Practice with real-world examples

## 📁 File Structure

### 1. `01_oop_principles.dart`
**Core OOP Principles**
- Encapsulation: Data hiding and bundling
- Inheritance: Code reusability through parent-child relationships  
- Polymorphism: Same interface, different implementations
- Abstraction: Hiding complexity, showing essentials

### 2. `02_classes_and_objects.dart`
**Classes and Objects Fundamentals**
- Class definition syntax
- Instance variables (properties)
- Methods (functions that belong to a class)
- Creating and using objects
- Examples with Person and Student classes

### 3. `03_constructors.dart`
**Constructor Types and Usage**
- Default constructors
- Parameterized constructors
- Named constructors
- Copy constructors
- Examples with Book and Rectangle classes

### 4. `04_car_class_practice.dart` ⭐
**Main Practice Exercise**
- Complete Car class implementation
- Properties: make, model, color, year, mileage, etc.
- Methods: drive(), startEngine(), stopEngine(), refuel()
- Real-world functionality with fuel consumption
- Multiple constructor types

### 5. `05_advanced_examples.dart`
**Real-World Applications**
- BankAccount class (demonstrates encapsulation)
- Employee management system
- Library book management
- Complex business logic examples

## 🚗 Main Practice: Car Class

The Car class includes:

**Properties:**
- `make` - Car manufacturer
- `model` - Car model
- `color` - Car color
- `year` - Manufacturing year
- `mileage` - Total miles driven
- `isEngineOn` - Engine status
- `fuelLevel` - Fuel percentage (0-100)

**Methods:**
- `drive(distance)` - Drive the car a certain distance
- `startEngine()` - Start the car engine
- `stopEngine()` - Stop the car engine
- `refuel(amount)` - Add fuel to the car
- `honk()` - Make the car honk
- `displayInfo()` - Show car information

**Constructor Types:**
- Default constructor
- Parameterized constructor
- Named constructor for used cars
- Named constructor for luxury cars

## 🎯 Key Concepts Covered

### Classes vs Objects
- **Class**: Blueprint or template
- **Object**: Instance of a class

### Instance Variables
- Variables that belong to an object
- Each object has its own copy
- Can have different data types

### Methods
- Functions that belong to a class
- Can access and modify instance variables
- Can have parameters and return values

### Constructors
- Special methods called when creating objects
- Initialize instance variables
- Can have multiple constructors with different names

## 💡 Best Practices

1. **Naming Conventions**
   - Classes: PascalCase (e.g., `CarClass`)
   - Variables/Methods: camelCase (e.g., `startEngine`)
   - Private variables: prefix with underscore (e.g., `_balance`)

2. **Encapsulation**
   - Use private variables when appropriate
   - Provide public methods for controlled access
   - Validate input in methods

3. **Constructor Design**
   - Provide meaningful default values
   - Use named constructors for different creation scenarios
   - Initialize all required variables

4. **Method Design**
   - Keep methods focused on single responsibilities
   - Provide clear return values and error handling
   - Use descriptive method names

## 🏃‍♂️ How to Run

Each file can be run independently:

```bash
# Run individual files
dart run lib/day\ 7/01_oop_principles.dart
dart run lib/day\ 7/02_classes_and_objects.dart
dart run lib/day\ 7/03_constructors.dart
dart run lib/day\ 7/04_car_class_practice.dart
dart run lib/day\ 7/05_advanced_examples.dart
```

## 🎮 Try These Exercises

1. **Extend the Car class:**
   - Add a `brand` property
   - Add a `accelerate()` method
   - Add a `brake()` method

2. **Create your own classes:**
   - `Phone` class with properties and methods
   - `BankAccount` class with deposit/withdraw
   - `Student` class with grades management

3. **Practice constructors:**
   - Create multiple ways to initialize your classes
   - Use named constructors for different scenarios

## 🔗 Next Steps

- Day 8: Inheritance and Polymorphism
- Day 9: Abstract classes and Interfaces
- Day 10: Advanced OOP patterns

Happy coding! 🚀