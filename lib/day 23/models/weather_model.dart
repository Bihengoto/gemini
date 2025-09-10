/// Weather data model for representing API response data
class Weather {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final String description;
  final String mainCondition;
  final double windSpeed;
  final int visibility;

  Weather({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.description,
    required this.mainCondition,
    required this.windSpeed,
    required this.visibility,
  });

  /// Factory constructor to create Weather object from JSON response
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? 'Unknown',
      country: json['sys']['country'] ?? 'Unknown',
      temperature: (json['main']['temp'] ?? 0).toDouble(),
      feelsLike: (json['main']['feels_like'] ?? 0).toDouble(),
      humidity: json['main']['humidity'] ?? 0,
      pressure: json['main']['pressure'] ?? 0,
      description: json['weather'][0]['description'] ?? 'No description',
      mainCondition: json['weather'][0]['main'] ?? 'Unknown',
      windSpeed: (json['wind']?['speed'] ?? 0).toDouble(),
      visibility: (json['visibility'] ?? 0) ~/ 1000, // Convert to km
    );
  }

  /// Convert Weather object to JSON (useful for caching or debugging)
  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'country': country,
      'main': {
        'temp': temperature,
        'feels_like': feelsLike,
        'humidity': humidity,
        'pressure': pressure,
      },
      'weather': [
        {'main': mainCondition, 'description': description},
      ],
      'wind': {'speed': windSpeed},
      'visibility': visibility * 1000, // Convert back to meters
    };
  }

  /// Get temperature in Fahrenheit
  double get temperatureInFahrenheit => (temperature * 9 / 5) + 32;

  /// Get feels like temperature in Fahrenheit
  double get feelsLikeInFahrenheit => (feelsLike * 9 / 5) + 32;

  /// Get weather emoji based on main condition
  String get weatherEmoji {
    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return '☀️';
      case 'clouds':
        return '☁️';
      case 'rain':
        return '🌧️';
      case 'drizzle':
        return '🌦️';
      case 'thunderstorm':
        return '⛈️';
      case 'snow':
        return '❄️';
      case 'mist':
      case 'fog':
        return '🌫️';
      default:
        return '🌤️';
    }
  }

  /// Get humidity level description
  String get humidityLevel {
    if (humidity < 30) return 'Low';
    if (humidity < 60) return 'Moderate';
    if (humidity < 80) return 'High';
    return 'Very High';
  }

  /// Get wind speed description
  String get windDescription {
    if (windSpeed < 1) return 'Calm';
    if (windSpeed < 6) return 'Light breeze';
    if (windSpeed < 12) return 'Moderate breeze';
    if (windSpeed < 20) return 'Strong breeze';
    return 'High wind';
  }

  @override
  String toString() {
    return 'Weather(city: $cityName, temp: ${temperature.toStringAsFixed(1)}°C, condition: $description)';
  }
}

/// Exception class for weather-related errors
class WeatherException implements Exception {
  final String message;
  final int? statusCode;

  WeatherException(this.message, [this.statusCode]);

  @override
  String toString() {
    if (statusCode != null) {
      return 'WeatherException: $message (Status: $statusCode)';
    }
    return 'WeatherException: $message';
  }
}
