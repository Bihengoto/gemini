/*
Numeric Extensions
==================

Extensions for numeric types (int, double, num) to add useful functionality
for mathematical operations, formatting, and utility methods.
*/

extension IntExtensions on int {
  // Check if number is even
  bool get isEven => this % 2 == 0;

  // Check if number is odd
  bool get isOdd => this % 2 != 0;

  // Check if number is prime
  bool get isPrime {
    if (this < 2) return false;
    if (this == 2) return true;
    if (isEven) return false;

    for (int i = 3; i * i <= this; i += 2) {
      if (this % i == 0) return false;
    }
    return true;
  }

  // Factorial
  int get factorial {
    if (this < 0)
      throw ArgumentError('Factorial is not defined for negative numbers');
    if (this <= 1) return 1;

    int result = 1;
    for (int i = 2; i <= this; i++) {
      result *= i;
    }
    return result;
  }

  // Convert to ordinal string (1st, 2nd, 3rd, etc.)
  String get ordinal {
    if (this >= 11 && this <= 13) return '${this}th';

    switch (this % 10) {
      case 1:
        return '${this}st';
      case 2:
        return '${this}nd';
      case 3:
        return '${this}rd';
      default:
        return '${this}th';
    }
  }

  // Convert to Roman numeral (1-3999)
  String get toRoman {
    if (this < 1 || this > 3999) {
      throw ArgumentError('Roman numerals only support 1-3999');
    }

    const values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
    const symbols = [
      'M',
      'CM',
      'D',
      'CD',
      'C',
      'XC',
      'L',
      'XL',
      'X',
      'IX',
      'V',
      'IV',
      'I',
    ];

    String result = '';
    int num = this;

    for (int i = 0; i < values.length; i++) {
      while (num >= values[i]) {
        result += symbols[i];
        num -= values[i];
      }
    }

    return result;
  }

  // Execute a function n times
  void times(void Function(int index) action) {
    for (int i = 0; i < this; i++) {
      action(i);
    }
  }

  // Create a list with this number as length
  List<T> generate<T>(T Function(int index) generator) {
    return List.generate(this, generator);
  }
}

extension DoubleExtensions on double {
  // Round to specific decimal places
  double roundToPlaces(int places) {
    double factor = 1.0;
    for (int i = 0; i < places; i++) {
      factor *= 10.0;
    }
    return (this * factor).round() / factor;
  }

  // Convert to percentage string
  String toPercentage([int decimals = 1]) {
    return '${(this * 100).roundToPlaces(decimals)}%';
  }

  // Check if number is approximately equal to another
  bool isApproximatelyEqual(double other, [double epsilon = 0.001]) {
    return (this - other).abs() < epsilon;
  }

  // Convert radians to degrees
  double get toDegrees => this * 180 / 3.14159265359;

  // Convert degrees to radians
  double get toRadians => this * 3.14159265359 / 180;

  // Format as currency
  String toCurrency([String symbol = '\$', int decimals = 2]) {
    return '$symbol${toStringAsFixed(decimals)}';
  }
}

extension NumExtensions on num {
  // Clamp between min and max
  num clampBetween(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }

  // Check if number is between two values (inclusive)
  bool isBetween(num min, num max) {
    return this >= min && this <= max;
  }

  // Convert to different units
  double get toKilometers => toDouble() / 1000;
  double get toMiles => toDouble() * 0.621371;
  double get toCelsius => (toDouble() - 32) * 5 / 9;
  double get toFahrenheit => toDouble() * 9 / 5 + 32;

  // Format with thousand separators
  String get withCommas {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match match) => '${match[1]},',
    );
  }
}

void demonstrateNumericExtensions() {
  print('=== Numeric Extensions Demo ===\n');

  // Integer extensions
  int number = 17;
  print('Number: $number');
  print('Is even: ${number.isEven}');
  print('Is odd: ${number.isOdd}');
  print('Is prime: ${number.isPrime}');
  print('Ordinal: ${number.ordinal}');
  print('Roman: ${number.toRoman}');
  print('Factorial of 5: ${5.factorial}\n');

  // Using times method
  print('Counting with times:');
  3.times((index) => print('  Count: $index'));
  print();

  // Generate list
  List<String> items = 4.generate((index) => 'Item ${index + 1}');
  print('Generated items: $items\n');

  // Double extensions
  double price = 0.1567;
  print('Price: $price');
  print('Rounded to 2 places: ${price.roundToPlaces(2)}');
  print('As percentage: ${price.toPercentage()}');
  print('As currency: ${price.toCurrency()}\n');

  // Angle conversions
  double angle = 90.0;
  print('$angle degrees = ${angle.toRadians} radians');
  print('${angle.toRadians} radians = ${angle.toRadians.toDegrees} degrees\n');

  // Num extensions
  num value = 1234567;
  print('Value: $value');
  print('With commas: ${value.withCommas}');
  print('Clamped (0-1000): ${value.clampBetween(0, 1000)}');
  print('Is between 1000-2000000: ${value.isBetween(1000, 2000000)}\n');

  // Unit conversions
  num distance = 5000; // meters
  print('Distance: ${distance}m');
  print('In kilometers: ${distance.toKilometers}km');
  print('In miles: ${distance.toMiles.roundToPlaces(2)} miles');
}

void main() {
  demonstrateNumericExtensions();
}
