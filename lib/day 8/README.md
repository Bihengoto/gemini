# Day 8: OOP - Inheritance

Welcome to Day 8 of your Dart learning journey! Today we explore one of the fundamental concepts of Object-Oriented Programming: **Inheritance**.

## 📚 Learning Objectives

By the end of this day, you will understand:
- How to use the `extends` keyword to create subclasses
- How to use the `super` keyword to access parent class members
- Method overriding and the `@override` annotation
- Practical inheritance through the Car-Sedan example
- Best practices for inheritance in Dart

## 📁 File Structure

```
day 8/
├── 01_inheritance_basics.dart      # Basic inheritance concepts
├── 02_super_keyword.dart           # Using super keyword
├── 03_method_overriding.dart       # Method overriding examples
├── 04_car_sedan_practice.dart      # Main practice exercise
├── 05_inheritance_summary.dart     # Complete summary with best practices
└── README.md                       # This file
```

## 🎯 Key Concepts

### 1. Inheritance Basics (`01_inheritance_basics.dart`)
- Understanding parent-child class relationships
- Using the `extends` keyword
- Inheriting properties and methods
- Adding new functionality to subclasses

### 2. Super Keyword (`02_super_keyword.dart`)
- Calling parent class constructors with `super()`
- Accessing parent class methods with `super.methodName()`
- Extending parent functionality rather than replacing it
- Proper constructor chaining

### 3. Method Overriding (`03_method_overriding.dart`)
- Providing custom implementations in child classes
- Using the `@override` annotation
- Maintaining method signatures
- Enabling polymorphism

### 4. Practice Exercise (`04_car_sedan_practice.dart`)
**Main Challenge**: Create a `Sedan` class that extends a `Car` class
- Multi-level inheritance: Vehicle → Car → Sedan
- Adding the `trunkSize` property
- Demonstrating all inheritance concepts together
- Real-world example with practical methods

### 5. Complete Summary (`05_inheritance_summary.dart`)
- Employee management system example
- Abstract classes and methods
- Best practices and design patterns
- Comprehensive polymorphism demonstration

## 🚀 How to Run

Each file can be run independently to see specific concepts in action:

```bash
# Run from the gemini directory
dart run lib/day\ 8/01_inheritance_basics.dart
dart run lib/day\ 8/02_super_keyword.dart
dart run lib/day\ 8/03_method_overriding.dart
dart run lib/day\ 8/04_car_sedan_practice.dart
dart run lib/day\ 8/05_inheritance_summary.dart
```

## 💡 Key Takeaways

1. **Inheritance creates "is-a" relationships** - A Sedan "is-a" Car, which "is-a" Vehicle
2. **Use `super` to avoid code duplication** - Extend parent functionality instead of rewriting it
3. **Method overriding enables polymorphism** - Same method name, different behavior
4. **The `@override` annotation is your friend** - It catches errors and improves code clarity
5. **Keep inheritance hierarchies shallow** - Deep inheritance can become hard to maintain

## 🔧 Practice Exercises

1. **Extend the Vehicle hierarchy**: Add a `Motorcycle` class that extends `Vehicle`
2. **Create a `SportsCar` class**: Extend `Car` with properties like `topSpeed` and `acceleration`
3. **Build an Animal hierarchy**: Create `Mammal`, `Bird`, and `Fish` classes extending `Animal`
4. **Design a Shape system**: Implement `Circle`, `Rectangle`, and `Triangle` with area calculations

## 🎨 Real-World Applications

- **UI Component hierarchies**: Button → IconButton → FloatingActionButton
- **Data model inheritance**: User → Customer → PremiumCustomer
- **Game development**: GameObject → Character → Player/Enemy
- **API response models**: BaseResponse → SuccessResponse → ErrorResponse

## 📖 Next Steps

After mastering inheritance, you'll be ready for:
- **Day 9**: Polymorphism and Abstract Classes
- **Day 10**: Interfaces and Mixins
- **Day 11**: Advanced OOP Patterns

Happy coding! 🎉