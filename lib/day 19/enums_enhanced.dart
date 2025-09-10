// Enhanced Enums Examples (Dart 2.17+)

/// Enhanced enum with properties and methods
enum Planet {
  mercury(3.303e+23, 2.4397e6),
  venus(4.869e+24, 6.0518e6),
  earth(5.976e+24, 6.37814e6),
  mars(6.421e+23, 3.3972e6),
  jupiter(1.9e+27, 7.1492e7),
  saturn(5.688e+26, 6.0268e7),
  uranus(8.686e+25, 2.5559e7),
  neptune(1.024e+26, 2.4746e7);

  const Planet(this.mass, this.radius);

  final double mass; // in kilograms
  final double radius; // in meters

  double get surfaceGravity => 6.67300E-11 * mass / (radius * radius);

  double surfaceWeight(double otherMass) => otherMass * surfaceGravity;

  @override
  String toString() => name;
}

/// Enhanced LightColors with additional properties and methods
enum LightColors {
  red('#FF0000', 'Stop', 30),
  yellow('#FFFF00', 'Caution', 5),
  green('#00FF00', 'Go', 45);

  const LightColors(this.hexCode, this.action, this.durationSeconds);

  final String hexCode;
  final String action;
  final int durationSeconds;

  // Method to get the next light in sequence
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

  // Method to check if it's safe to proceed
  bool get isSafeToProceed => this == LightColors.green;

  // Static method to get light by hex code
  static LightColors? fromHexCode(String hex) {
    for (LightColors color in LightColors.values) {
      if (color.hexCode == hex) {
        return color;
      }
    }
    return null;
  }

  @override
  String toString() => '$name ($action)';
}

/// Enhanced enum for HTTP status codes
enum HttpStatus {
  ok(200, 'OK'),
  created(201, 'Created'),
  badRequest(400, 'Bad Request'),
  unauthorized(401, 'Unauthorized'),
  forbidden(403, 'Forbidden'),
  notFound(404, 'Not Found'),
  internalServerError(500, 'Internal Server Error');

  const HttpStatus(this.code, this.message);

  final int code;
  final String message;

  bool get isSuccess => code >= 200 && code < 300;
  bool get isClientError => code >= 400 && code < 500;
  bool get isServerError => code >= 500 && code < 600;

  static HttpStatus? fromCode(int code) {
    for (HttpStatus status in HttpStatus.values) {
      if (status.code == code) {
        return status;
      }
    }
    return null;
  }

  @override
  String toString() => '$code $message';
}

/// Enhanced enum with complex behavior
enum LogLevel {
  debug(0, 'DEBUG', '\x1B[36m'), // Cyan
  info(1, 'INFO', '\x1B[32m'), // Green
  warning(2, 'WARN', '\x1B[33m'), // Yellow
  error(3, 'ERROR', '\x1B[31m'), // Red
  fatal(4, 'FATAL', '\x1B[35m'); // Magenta

  const LogLevel(this.level, this.name, this.colorCode);

  final int level;
  final String name;
  final String colorCode;

  static const String _resetColor = '\x1B[0m';

  bool shouldLog(LogLevel minimumLevel) => level >= minimumLevel.level;

  String formatMessage(String message) {
    return '$colorCode[$name] $message$_resetColor';
  }

  static LogLevel? fromString(String name) {
    for (LogLevel level in LogLevel.values) {
      if (level.name.toLowerCase() == name.toLowerCase()) {
        return level;
      }
    }
    return null;
  }
}

void main() {
  print('=== Enhanced Enums Examples ===\n');

  // Example 1: Planet calculations
  print('1. Planet Calculations:');
  double earthWeight = 75.0; // kg

  for (Planet planet in [Planet.earth, Planet.mars, Planet.jupiter]) {
    double weight = planet.surfaceWeight(earthWeight);
    print('Weight on ${planet.name}: ${weight.toStringAsFixed(2)} N');
    print('Surface gravity: ${planet.surfaceGravity.toStringAsFixed(2)} m/s²');
    print('');
  }

  // Example 2: Enhanced LightColors
  print('2. Enhanced LightColors:');
  LightColors currentLight = LightColors.red;

  for (int i = 0; i < 4; i++) {
    print('Current: $currentLight');
    print('Hex Code: ${currentLight.hexCode}');
    print('Duration: ${currentLight.durationSeconds} seconds');
    print('Safe to proceed: ${currentLight.isSafeToProceed}');
    print('Next light: ${currentLight.next}');
    print('---');

    currentLight = currentLight.next;
  }

  // Using static method
  LightColors? foundColor = LightColors.fromHexCode('#FFFF00');
  print('Found color by hex: $foundColor');

  // Example 3: HTTP Status codes
  print('\n3. HTTP Status Codes:');
  List<int> statusCodes = [200, 404, 500, 201, 401];

  for (int code in statusCodes) {
    HttpStatus? status = HttpStatus.fromCode(code);
    if (status != null) {
      print(
        '$status - Success: ${status.isSuccess}, '
        'Client Error: ${status.isClientError}, '
        'Server Error: ${status.isServerError}',
      );
    } else {
      print('Unknown status code: $code');
    }
  }

  // Example 4: Log Levels
  print('\n4. Log Levels:');
  LogLevel minimumLevel = LogLevel.info;
  List<String> messages = [
    'Debug information',
    'Application started',
    'Warning: Low memory',
    'Error: File not found',
    'Fatal: System crash',
  ];

  for (int i = 0; i < LogLevel.values.length; i++) {
    LogLevel level = LogLevel.values[i];
    if (level.shouldLog(minimumLevel)) {
      print(level.formatMessage(messages[i]));
    }
  }

  // Finding log level by string
  LogLevel? foundLevel = LogLevel.fromString('ERROR');
  print('\nFound log level: $foundLevel');
}
