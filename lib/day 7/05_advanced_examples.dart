/*
Day 7: Advanced OOP Examples

This file contains more complex examples demonstrating
advanced OOP concepts and real-world applications.
*/

// Example 1: Bank Account Class with Encapsulation
class BankAccount {
  String _accountNumber; // Private variable (encapsulation)
  String _accountHolder;
  double _balance;
  List<String> _transactionHistory;

  // Constructor
  BankAccount(
    this._accountNumber,
    this._accountHolder, [
    double initialBalance = 0.0,
  ]) {
    _balance = initialBalance;
    _transactionHistory = [];
    _addTransaction(
      "Account opened with balance: \$${_balance.toStringAsFixed(2)}",
    );
  }

  // Getter methods (controlled access to private variables)
  String get accountNumber => _accountNumber;
  String get accountHolder => _accountHolder;
  double get balance => _balance;
  List<String> get transactionHistory => List.unmodifiable(_transactionHistory);

  // Private method
  void _addTransaction(String transaction) {
    String timestamp = DateTime.now().toString().substring(0, 19);
    _transactionHistory.add("[$timestamp] $transaction");
  }

  // Public methods
  bool deposit(double amount) {
    if (amount <= 0) {
      print("❌ Invalid deposit amount!");
      return false;
    }

    _balance += amount;
    _addTransaction("Deposited: \$${amount.toStringAsFixed(2)}");
    print(
      "✅ Deposited \$${amount.toStringAsFixed(2)}. New balance: \$${_balance.toStringAsFixed(2)}",
    );
    return true;
  }

  bool withdraw(double amount) {
    if (amount <= 0) {
      print("❌ Invalid withdrawal amount!");
      return false;
    }

    if (amount > _balance) {
      print(
        "❌ Insufficient funds! Current balance: \$${_balance.toStringAsFixed(2)}",
      );
      return false;
    }

    _balance -= amount;
    _addTransaction("Withdrew: \$${amount.toStringAsFixed(2)}");
    print(
      "✅ Withdrew \$${amount.toStringAsFixed(2)}. New balance: \$${_balance.toStringAsFixed(2)}",
    );
    return true;
  }

  void displayAccountInfo() {
    print("🏦 Account Information:");
    print("   Account Number: $_accountNumber");
    print("   Account Holder: $_accountHolder");
    print("   Current Balance: \$${_balance.toStringAsFixed(2)}");
    print("-" * 40);
  }

  void displayTransactionHistory() {
    print("📋 Transaction History for $_accountNumber:");
    for (String transaction in _transactionHistory) {
      print("   $transaction");
    }
    print("-" * 40);
  }
}

// Example 2: Employee Management System
class Employee {
  int employeeId;
  String name;
  String department;
  double salary;
  DateTime hireDate;
  List<String> skills;

  Employee(this.employeeId, this.name, this.department, this.salary) {
    hireDate = DateTime.now();
    skills = [];
  }

  // Named constructor for experienced employee
  Employee.experienced(
    this.employeeId,
    this.name,
    this.department,
    this.salary,
    this.hireDate,
  ) {
    skills = [];
  }

  void addSkill(String skill) {
    if (!skills.contains(skill)) {
      skills.add(skill);
      print("✅ Added skill '$skill' to ${name}'s profile");
    } else {
      print("⚠️ $name already has the skill '$skill'");
    }
  }

  void removeSkill(String skill) {
    if (skills.remove(skill)) {
      print("✅ Removed skill '$skill' from ${name}'s profile");
    } else {
      print("⚠️ $name doesn't have the skill '$skill'");
    }
  }

  double calculateYearsOfService() {
    Duration service = DateTime.now().difference(hireDate);
    return service.inDays / 365.25; // Account for leap years
  }

  double calculateAnnualBonus() {
    double yearsOfService = calculateYearsOfService();
    double baseBonus = salary * 0.05; // 5% base bonus
    double experienceBonus = yearsOfService * 0.01 * salary; // 1% per year
    return baseBonus + experienceBonus;
  }

  void displayEmployeeInfo() {
    print("👤 Employee Information:");
    print("   ID: $employeeId");
    print("   Name: $name");
    print("   Department: $department");
    print("   Salary: \$${salary.toStringAsFixed(2)}");
    print("   Hire Date: ${hireDate.toString().substring(0, 10)}");
    print(
      "   Years of Service: ${calculateYearsOfService().toStringAsFixed(1)}",
    );
    print("   Skills: ${skills.isEmpty ? 'None' : skills.join(', ')}");
    print("   Annual Bonus: \$${calculateAnnualBonus().toStringAsFixed(2)}");
    print("-" * 50);
  }
}

// Example 3: Library Management System
class LibraryBook {
  String isbn;
  String title;
  String author;
  String genre;
  bool isAvailable;
  DateTime? borrowedDate;
  String? borrowerName;

  LibraryBook(this.isbn, this.title, this.author, this.genre) {
    isAvailable = true;
    borrowedDate = null;
    borrowerName = null;
  }

  bool borrowBook(String borrower) {
    if (!isAvailable) {
      print("❌ Book '$title' is already borrowed by $borrowerName");
      return false;
    }

    isAvailable = false;
    borrowedDate = DateTime.now();
    borrowerName = borrower;
    print("✅ Book '$title' borrowed by $borrower");
    return true;
  }

  bool returnBook() {
    if (isAvailable) {
      print("❌ Book '$title' is not currently borrowed");
      return false;
    }

    print("✅ Book '$title' returned by $borrowerName");

    // Calculate late fee if applicable (assuming 14-day loan period)
    if (borrowedDate != null) {
      int daysBorrowed = DateTime.now().difference(borrowedDate!).inDays;
      if (daysBorrowed > 14) {
        double lateFee = (daysBorrowed - 14) * 0.50; // $0.50 per day late
        print(
          "⚠️ Late return! Fee: \$${lateFee.toStringAsFixed(2)} (${daysBorrowed - 14} days late)",
        );
      }
    }

    isAvailable = true;
    borrowedDate = null;
    borrowerName = null;
    return true;
  }

  void displayBookInfo() {
    print("📚 Book Information:");
    print("   ISBN: $isbn");
    print("   Title: $title");
    print("   Author: $author");
    print("   Genre: $genre");
    print("   Status: ${isAvailable ? 'Available' : 'Borrowed'}");
    if (!isAvailable) {
      print("   Borrowed by: $borrowerName");
      print("   Borrowed on: ${borrowedDate.toString().substring(0, 10)}");
      int daysBorrowed = DateTime.now().difference(borrowedDate!).inDays;
      print("   Days borrowed: $daysBorrowed");
    }
    print("-" * 40);
  }
}

void main() {
  print("Advanced OOP Examples");
  print("====================");

  // Bank Account Example
  print("🏦 Bank Account Example:");
  BankAccount account = BankAccount("ACC001", "John Doe", 1000.0);
  account.displayAccountInfo();

  account.deposit(500);
  account.withdraw(200);
  account.withdraw(2000); // Should fail
  account.displayTransactionHistory();

  print("\n" + "=" * 50 + "\n");

  // Employee Example
  print("👤 Employee Management Example:");
  Employee emp1 = Employee(101, "Alice Smith", "Engineering", 75000);
  emp1.addSkill("Dart");
  emp1.addSkill("Flutter");
  emp1.addSkill("Firebase");
  emp1.displayEmployeeInfo();

  // Experienced employee
  Employee emp2 = Employee.experienced(
    102,
    "Bob Johnson",
    "Marketing",
    65000,
    DateTime(2020, 3, 15),
  );
  emp2.addSkill("Digital Marketing");
  emp2.addSkill("SEO");
  emp2.displayEmployeeInfo();

  print("\n" + "=" * 50 + "\n");

  // Library Book Example
  print("📚 Library Management Example:");
  LibraryBook book1 = LibraryBook(
    "978-0-123456-78-9",
    "Flutter Development Guide",
    "Jane Developer",
    "Technology",
  );
  book1.displayBookInfo();

  book1.borrowBook("Mike Reader");
  book1.displayBookInfo();

  // Simulate returning after some time
  book1.returnBook();
  book1.displayBookInfo();

  // Try to return again (should fail)
  book1.returnBook();
}
