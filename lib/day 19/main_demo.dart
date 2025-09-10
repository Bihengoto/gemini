// Day 19 Main Demo: Callable Classes & Enums
// This file demonstrates all the key concepts covered in Day 19

import 'dart:math';

/// Demo: Simple callable class for mathematical operations
class Calculator {
  String operation;

  Calculator(this.operation);

  double call(double a, double b) {
    switch (operation) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        return b != 0 ? a / b : double.infinity;
      default:
        throw ArgumentError('Unknown operation: $operation');
    }
  }
}

/// Demo: LightColors enum (as requested in the practice)
enum LightColors {
  red,
  green,
  yellow;

  // Enhanced functionality
  String get displayName => name.toUpperCase();

  String get action {
    switch (this) {
      case LightColors.red:
        return 'STOP';
      case LightColors.yellow:
        return 'CAUTION';
      case LightColors.green:
        return 'GO';
    }
  }

  LightColors get next {
    switch (this) {
      case LightColors.red:
        return LightColors.green;
      case LightColors.green:
        return LightColors.yellow;
      case LightColors.yellow:
        return LightColors.red;
    }
  }
}

/// Demo: Enhanced enum with properties and methods
enum WeatherCondition {
  sunny('☀️', 'Clear skies', true),
  cloudy('☁️', 'Overcast', true),
  rainy('🌧️', 'Precipitation', false),
  stormy('⛈️', 'Thunderstorm', false),
  snowy('❄️', 'Snow fall', false);

  const WeatherCondition(this.emoji, this.description, this.goodForOutdoor);

  final String emoji;
  final String description;
  final bool goodForOutdoor;

  String getRecommendation() {
    if (goodForOutdoor) {
      return 'Great day to go outside! $emoji';
    } else {
      return 'Better stay indoors today. $emoji';
    }
  }

  static WeatherCondition getRandomWeather() {
    return WeatherCondition.values[Random().nextInt(
      WeatherCondition.values.length,
    )];
  }
}

/// Demo: Callable class with state management
class StatefulCounter {
  int _value = 0;
  final int _step;

  StatefulCounter({int step = 1}) : _step = step;

  int get value => _value;

  // Call method increments by step and returns new value
  int call() {
    _value += _step;
    return _value;
  }

  void reset() {
    _value = 0;
  }

  @override
  String toString() => 'Counter(value: $_value, step: $_step)';
}

void main() {
  print('🎯 Day 19: Callable Classes & Enums Demo\n');
  print('=' * 50);

  // Demo 1: Basic Callable Class
  print('\n📱 Demo 1: Calculator (Callable Class)');
  print('-' * 30);

  var adder = Calculator('+');
  var multiplier = Calculator('*');

  print('adder(10, 5) = ${adder(10, 5)}');
  print('multiplier(4, 7) = ${multiplier(4, 7)}');

  // Demo 2: LightColors Enum (Practice Exercise)
  print('\n🚦 Demo 2: LightColors Enum (Practice)');
  print('-' * 30);

  print('Available colors:');
  for (LightColors color in LightColors.values) {
    print('${color.displayName}: ${color.action}');
  }

  print('\nTraffic light sequence:');
  LightColors currentLight = LightColors.red;
  for (int i = 0; i < 6; i++) {
    print('${i + 1}. ${currentLight.displayName} - ${currentLight.action}');
    currentLight = currentLight.next;
  }

  // Demo 3: Enhanced Enum with Properties
  print('\n🌤️ Demo 3: Weather Conditions (Enhanced Enum)');
  print('-' * 30);

  for (WeatherCondition weather in WeatherCondition.values) {
    print('${weather.emoji} ${weather.name}: ${weather.description}');
    print('   ${weather.getRecommendation()}');
  }

  print('\nRandom weather forecast:');
  for (int day = 1; day <= 5; day++) {
    WeatherCondition weather = WeatherCondition.getRandomWeather();
    print(
      'Day $day: ${weather.emoji} ${weather.name} - ${weather.description}',
    );
  }

  // Demo 4: Stateful Callable Class
  print('\n🔢 Demo 4: Stateful Counter (Callable with State)');
  print('-' * 30);

  var counter1 = StatefulCounter();
  var counter5 = StatefulCounter(step: 5);

  print('Counter 1 (step: 1):');
  for (int i = 0; i < 5; i++) {
    print('Call ${i + 1}: ${counter1()}');
  }

  print('\nCounter 5 (step: 5):');
  for (int i = 0; i < 3; i++) {
    print('Call ${i + 1}: ${counter5()}');
  }

  print('\nCounter states:');
  print('Counter 1: $counter1');
  print('Counter 5: $counter5');

  // Demo 5: Enum in Switch Expressions (Modern Dart)
  print('\n🎮 Demo 5: Enum with Switch Expressions');
  print('-' * 30);

  List<LightColors> lights = [
    LightColors.red,
    LightColors.yellow,
    LightColors.green,
  ];

  for (LightColors light in lights) {
    String message = switch (light) {
      LightColors.red => '🛑 Stop and wait',
      LightColors.yellow => '⚠️ Prepare to stop',
      LightColors.green => '✅ Go ahead safely',
    };

    int duration = switch (light) {
      LightColors.red => 30,
      LightColors.yellow => 5,
      LightColors.green => 25,
    };

    print('${light.displayName}: $message (${duration}s)');
  }

  // Demo 6: Combining Callable Classes and Enums
  print('\n🔄 Demo 6: Combining Concepts');
  print('-' * 30);

  // Create calculators for different operations
  Map<String, Calculator> calculators = {
    'add': Calculator('+'),
    'subtract': Calculator('-'),
    'multiply': Calculator('*'),
    'divide': Calculator('/'),
  };

  double a = 15.0, b = 3.0;

  calculators.forEach((name, calc) {
    double result = calc(a, b);
    print('$name($a, $b) = $result');
  });

  print('\n🎉 Day 19 Complete!');
  print('Key concepts covered:');
  print('✅ Callable classes with call() method');
  print('✅ Basic enums for constants');
  print('✅ Enhanced enums with properties and methods');
  print('✅ LightColors enum (practice exercise)');
  print('✅ Combining callable classes and enums');
}
