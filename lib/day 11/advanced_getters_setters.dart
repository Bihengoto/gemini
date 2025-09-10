// Advanced Getters and Setters Examples

import 'dart:math';

// Example 1: Temperature Converter
class Temperature {
  double _celsius;

  Temperature.celsius(this._celsius);
  Temperature.fahrenheit(double fahrenheit)
    : _celsius = (fahrenheit - 32) * 5 / 9;
  Temperature.kelvin(double kelvin) : _celsius = kelvin - 273.15;

  // Celsius getter and setter
  double get celsius => _celsius;
  set celsius(double value) {
    if (value >= -273.15) {
      _celsius = value;
    } else {
      throw ArgumentError('Temperature cannot be below absolute zero');
    }
  }

  // Fahrenheit getter and setter
  double get fahrenheit => (_celsius * 9 / 5) + 32;
  set fahrenheit(double value) {
    celsius = (value - 32) * 5 / 9; // Use celsius setter for validation
  }

  // Kelvin getter and setter
  double get kelvin => _celsius + 273.15;
  set kelvin(double value) {
    celsius = value - 273.15; // Use celsius setter for validation
  }

  @override
  String toString() {
    return 'Temperature: ${_celsius.toStringAsFixed(2)}°C, '
        '${fahrenheit.toStringAsFixed(2)}°F, '
        '${kelvin.toStringAsFixed(2)}K';
  }
}

// Example 2: Circle with Lazy Calculation
class Circle {
  double _radius;
  double? _cachedArea;
  double? _cachedCircumference;

  Circle(this._radius);

  double get radius => _radius;

  set radius(double value) {
    if (value > 0) {
      _radius = value;
      // Clear cached values when radius changes
      _cachedArea = null;
      _cachedCircumference = null;
    } else {
      throw ArgumentError('Radius must be positive');
    }
  }

  // Lazy-calculated area
  double get area {
    _cachedArea ??= pi * _radius * _radius;
    return _cachedArea!;
  }

  // Lazy-calculated circumference
  double get circumference {
    _cachedCircumference ??= 2 * pi * _radius;
    return _cachedCircumference!;
  }

  // Diameter (simple calculation, no caching needed)
  double get diameter => _radius * 2;

  set diameter(double value) {
    radius = value / 2; // Use radius setter for validation
  }

  @override
  String toString() {
    return 'Circle(radius: $_radius, area: ${area.toStringAsFixed(2)}, '
        'circumference: ${circumference.toStringAsFixed(2)})';
  }
}

// Example 3: Bank Account with Transaction History
class BankAccount {
  double _balance;
  final List<String> _transactionHistory = [];

  BankAccount(this._balance);

  double get balance => _balance;

  // Read-only transaction history
  List<String> get transactionHistory => List.unmodifiable(_transactionHistory);

  // Deposit method (acts like a setter)
  set deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      _transactionHistory.add(
        'Deposit: +\$${amount.toStringAsFixed(2)} (Balance: \$${_balance.toStringAsFixed(2)})',
      );
    } else {
      throw ArgumentError('Deposit amount must be positive');
    }
  }

  // Withdraw method (acts like a setter)
  set withdraw(double amount) {
    if (amount > 0) {
      if (_balance >= amount) {
        _balance -= amount;
        _transactionHistory.add(
          'Withdrawal: -\$${amount.toStringAsFixed(2)} (Balance: \$${_balance.toStringAsFixed(2)})',
        );
      } else {
        throw ArgumentError('Insufficient funds');
      }
    } else {
      throw ArgumentError('Withdrawal amount must be positive');
    }
  }

  // Account status
  String get status {
    if (_balance > 1000) return 'Premium';
    if (_balance > 100) return 'Standard';
    if (_balance >= 0) return 'Basic';
    return 'Overdrawn';
  }

  @override
  String toString() {
    return 'BankAccount(balance: \$${_balance.toStringAsFixed(2)}, status: $status)';
  }
}

void main() {
  print('=== Temperature Converter ===');
  var temp = Temperature.celsius(25);
  print(temp);

  temp.fahrenheit = 100;
  print('After setting to 100°F: $temp');

  temp.kelvin = 300;
  print('After setting to 300K: $temp');

  print('\n=== Circle with Lazy Calculation ===');
  var circle = Circle(5);
  print(circle);
  print('Area calculated: ${circle.area}'); // First calculation
  print('Area cached: ${circle.area}'); // Uses cached value

  circle.diameter = 20; // Changes radius to 10
  print('After setting diameter to 20: $circle');

  print('\n=== Bank Account ===');
  var account = BankAccount(500);
  print(account);

  account.deposit = 200;
  print('After deposit: $account');

  account.withdraw = 100;
  print('After withdrawal: $account');

  print('\nTransaction History:');
  for (var transaction in account.transactionHistory) {
    print('  $transaction');
  }

  // Test error handling
  try {
    account.withdraw = 1000;
  } catch (e) {
    print('Error: $e');
  }
}
