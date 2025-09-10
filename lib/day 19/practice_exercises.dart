// Practice Exercises: Callable Classes & Enums

/// Exercise 1: Create a callable class for temperature conversion
class TemperatureConverter {
  final String fromUnit;
  final String toUnit;

  TemperatureConverter({required this.fromUnit, required this.toUnit});

  double call(double temperature) {
    // Convert from any unit to Celsius first
    double celsius = switch (fromUnit.toLowerCase()) {
      'fahrenheit' || 'f' => (temperature - 32) * 5 / 9,
      'kelvin' || 'k' => temperature - 273.15,
      'celsius' || 'c' => temperature,
      _ => throw ArgumentError('Unknown unit: $fromUnit'),
    };

    // Convert from Celsius to target unit
    return switch (toUnit.toLowerCase()) {
      'fahrenheit' || 'f' => celsius * 9 / 5 + 32,
      'kelvin' || 'k' => celsius + 273.15,
      'celsius' || 'c' => celsius,
      _ => throw ArgumentError('Unknown unit: $toUnit'),
    };
  }

  @override
  String toString() => '$fromUnit to $toUnit converter';
}

/// Exercise 2: Enhanced LightColors enum with traffic light simulation
enum TrafficLight {
  red('#FF0000', 'STOP', 30, false),
  yellow('#FFFF00', 'CAUTION', 5, false),
  green('#00FF00', 'GO', 25, true);

  const TrafficLight(
    this.color,
    this.instruction,
    this.duration,
    this.canProceed,
  );

  final String color;
  final String instruction;
  final int duration;
  final bool canProceed;

  TrafficLight get next {
    switch (this) {
      case TrafficLight.red:
        return TrafficLight.green;
      case TrafficLight.green:
        return TrafficLight.yellow;
      case TrafficLight.yellow:
        return TrafficLight.red;
    }
  }

  String getDisplayText() {
    return '🚦 ${name.toUpperCase()} - $instruction (${duration}s)';
  }

  static TrafficLight fromColor(String colorName) {
    return TrafficLight.values.firstWhere(
      (light) => light.name.toLowerCase() == colorName.toLowerCase(),
      orElse: () => throw ArgumentError('Invalid color: $colorName'),
    );
  }
}

/// Exercise 3: Callable class for mathematical sequences
class SequenceGenerator {
  final String _type;
  int _current = 0;
  int _previous = 0;

  SequenceGenerator.fibonacci() : _type = 'fibonacci' {
    _current = 1;
    _previous = 0;
  }

  SequenceGenerator.arithmetic(int start, int difference)
    : _type = 'arithmetic' {
    _current = start;
    _previous = difference;
  }

  SequenceGenerator.geometric(int start, int ratio) : _type = 'geometric' {
    _current = start;
    _previous = ratio;
  }

  int call() {
    int result = _current;

    switch (_type) {
      case 'fibonacci':
        int next = _current + _previous;
        _previous = _current;
        _current = next;
        break;
      case 'arithmetic':
        _current += _previous; // _previous stores the difference
        break;
      case 'geometric':
        _current *= _previous; // _previous stores the ratio
        break;
    }

    return result;
  }

  void reset() {
    switch (_type) {
      case 'fibonacci':
        _current = 1;
        _previous = 0;
        break;
      case 'arithmetic':
        // Would need to store original start value for proper reset
        break;
      case 'geometric':
        // Would need to store original start value for proper reset
        break;
    }
  }
}

/// Exercise 4: Game state enum
enum GameState {
  menu('Main Menu', true),
  playing('In Game', false),
  paused('Paused', true),
  gameOver('Game Over', true),
  loading('Loading...', false),
  settings('Settings', true);

  const GameState(this.displayName, this.canInteract);

  final String displayName;
  final bool canInteract;

  bool get isPlayable => this == GameState.playing;
  bool get isMenuState =>
      [GameState.menu, GameState.settings, GameState.gameOver].contains(this);

  GameState? getNextState() {
    switch (this) {
      case GameState.menu:
        return GameState.loading;
      case GameState.loading:
        return GameState.playing;
      case GameState.playing:
        return GameState.paused;
      case GameState.paused:
        return GameState.playing;
      case GameState.gameOver:
        return GameState.menu;
      case GameState.settings:
        return GameState.menu;
    }
  }

  String getStatusMessage() {
    switch (this) {
      case GameState.menu:
        return 'Welcome! Press START to begin.';
      case GameState.playing:
        return 'Game in progress. Good luck!';
      case GameState.paused:
        return 'Game paused. Press RESUME to continue.';
      case GameState.gameOver:
        return 'Game Over! Press RESTART to play again.';
      case GameState.loading:
        return 'Loading game assets...';
      case GameState.settings:
        return 'Adjust your game preferences.';
    }
  }
}

/// Exercise 5: Callable class for data validation pipeline
class ValidationPipeline {
  final List<String Function(dynamic)> _validators = [];

  void addValidator(String Function(dynamic) validator) {
    _validators.add(validator);
  }

  void addLengthValidator(int minLength, int maxLength) {
    _validators.add((value) {
      String str = value.toString();
      if (str.length < minLength) {
        return 'Value must be at least $minLength characters long';
      }
      if (str.length > maxLength) {
        return 'Value must be no more than $maxLength characters long';
      }
      return '';
    });
  }

  void addEmailValidator() {
    _validators.add((value) {
      String str = value.toString();
      if (!str.contains('@') || !str.contains('.')) {
        return 'Invalid email format';
      }
      return '';
    });
  }

  void addNumericValidator() {
    _validators.add((value) {
      if (double.tryParse(value.toString()) == null) {
        return 'Value must be numeric';
      }
      return '';
    });
  }

  // Call method runs all validators
  List<String> call(dynamic value) {
    List<String> errors = [];
    for (var validator in _validators) {
      String error = validator(value);
      if (error.isNotEmpty) {
        errors.add(error);
      }
    }
    return errors;
  }

  bool isValid(dynamic value) => call(value).isEmpty;
}

void main() {
  print('=== Practice Exercises ===\n');

  // Exercise 1: Temperature Converter
  print('1. Temperature Converter:');
  var celsiusToFahrenheit = TemperatureConverter(
    fromUnit: 'celsius',
    toUnit: 'fahrenheit',
  );
  var fahrenheitToCelsius = TemperatureConverter(
    fromUnit: 'fahrenheit',
    toUnit: 'celsius',
  );

  print('0°C = ${celsiusToFahrenheit(0)}°F');
  print('32°F = ${fahrenheitToCelsius(32)}°C');
  print('100°C = ${celsiusToFahrenheit(100)}°F');

  // Exercise 2: Traffic Light Simulation
  print('\n2. Traffic Light Simulation:');
  TrafficLight currentLight = TrafficLight.red;

  for (int cycle = 0; cycle < 6; cycle++) {
    print(currentLight.getDisplayText());
    print('Can proceed: ${currentLight.canProceed}');
    currentLight = currentLight.next;
    print('---');
  }

  // Exercise 3: Sequence Generators
  print('\n3. Sequence Generators:');

  print('Fibonacci sequence:');
  var fibonacci = SequenceGenerator.fibonacci();
  for (int i = 0; i < 8; i++) {
    print('F($i) = ${fibonacci()}');
  }

  print('\nArithmetic sequence (start: 5, diff: 3):');
  var arithmetic = SequenceGenerator.arithmetic(5, 3);
  for (int i = 0; i < 6; i++) {
    print('A($i) = ${arithmetic()}');
  }

  // Exercise 4: Game State Management
  print('\n4. Game State Management:');
  GameState currentState = GameState.menu;

  for (int i = 0; i < 8; i++) {
    print('State: ${currentState.displayName}');
    print('Message: ${currentState.getStatusMessage()}');
    print('Can interact: ${currentState.canInteract}');

    GameState? nextState = currentState.getNextState();
    if (nextState != null) {
      currentState = nextState;
    }
    print('---');
  }

  // Exercise 5: Validation Pipeline
  print('\n5. Validation Pipeline:');

  // Email validator
  var emailValidator = ValidationPipeline();
  emailValidator.addLengthValidator(5, 50);
  emailValidator.addEmailValidator();

  List<String> testEmails = [
    'test@example.com',
    'invalid',
    'a@b.c',
    'toolongemailthatexceedsfiftycharacters@example.com',
  ];

  for (String email in testEmails) {
    List<String> errors = emailValidator(email);
    print('Email: $email');
    if (errors.isEmpty) {
      print('✅ Valid');
    } else {
      print('❌ Errors: ${errors.join(', ')}');
    }
    print('');
  }

  // Numeric validator
  var numericValidator = ValidationPipeline();
  numericValidator.addNumericValidator();

  List<dynamic> testNumbers = [42, '123', 'abc', '45.67', 'not a number'];

  print('Numeric validation:');
  for (var value in testNumbers) {
    bool isValid = numericValidator.isValid(value);
    print('Value: $value - Valid: ${isValid ? '✅' : '❌'}');
  }
}
