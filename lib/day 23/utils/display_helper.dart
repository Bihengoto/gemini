import 'dart:io';
import '../models/weather_model.dart';

/// Helper class for formatting and displaying weather information
class DisplayHelper {
  /// Display weather information in a formatted, user-friendly way
  static void displayWeather(Weather weather) {
    _printHeader();
    _printLocationInfo(weather);
    _printTemperatureInfo(weather);
    _printConditionInfo(weather);
    _printAdditionalInfo(weather);
    _printFooter();
  }

  /// Display weather information for multiple cities
  static void displayMultipleWeather(List<Weather> weatherList) {
    if (weatherList.isEmpty) {
      print('❌ No weather data available.');
      return;
    }

    print('\n📊 Weather Summary for ${weatherList.length} cities:');
    print('=' * 60);

    for (int i = 0; i < weatherList.length; i++) {
      final weather = weatherList[i];
      print('${i + 1}. ${weather.cityName}, ${weather.country}');
      print(
        '   ${weather.weatherEmoji} ${weather.temperature.toStringAsFixed(1)}°C - ${weather.description}',
      );
      if (i < weatherList.length - 1) print('');
    }
    print('=' * 60);
  }

  /// Print formatted header
  static void _printHeader() {
    print('\n🌤️  Weather Report');
    print('=' * 50);
  }

  /// Print location information
  static void _printLocationInfo(Weather weather) {
    print('📍 Location: ${weather.cityName}, ${weather.country}');
  }

  /// Print temperature information
  static void _printTemperatureInfo(Weather weather) {
    print(
      '🌡️  Temperature: ${weather.temperature.toStringAsFixed(1)}°C (${weather.temperatureInFahrenheit.toStringAsFixed(1)}°F)',
    );
    print(
      '🤔 Feels like: ${weather.feelsLike.toStringAsFixed(1)}°C (${weather.feelsLikeInFahrenheit.toStringAsFixed(1)}°F)',
    );
  }

  /// Print weather condition information
  static void _printConditionInfo(Weather weather) {
    print(
      '${weather.weatherEmoji} Condition: ${_capitalize(weather.description)}',
    );
  }

  /// Print additional weather information
  static void _printAdditionalInfo(Weather weather) {
    print('💧 Humidity: ${weather.humidity}% (${weather.humidityLevel})');
    print('📊 Pressure: ${weather.pressure} hPa');
    print(
      '💨 Wind: ${weather.windSpeed.toStringAsFixed(1)} m/s (${weather.windDescription})',
    );
    print('👁️  Visibility: ${weather.visibility} km');
  }

  /// Print formatted footer
  static void _printFooter() {
    print('=' * 50);
    print('Data provided by OpenWeatherMap');
  }

  /// Display error message in a user-friendly format
  static void displayError(String error) {
    print('\n❌ Error: $error');
    print(
      '💡 Tip: Make sure you have a valid internet connection and correct city name.',
    );
  }

  /// Display loading animation
  static void showLoading(String message) {
    stdout.write('$message');
    for (int i = 0; i < 3; i++) {
      sleep(Duration(milliseconds: 500));
      stdout.write('.');
    }
    print('');
  }

  /// Display usage instructions
  static void displayUsage() {
    print('\n🌤️  Weather App Usage:');
    print('=' * 40);
    print('Single city:');
    print('  dart run lib/day\\ 23/weather_app.dart London');
    print('');
    print('Multiple cities:');
    print('  dart run lib/day\\ 23/weather_app.dart London Paris Tokyo');
    print('');
    print('City with spaces:');
    print('  dart run lib/day\\ 23/weather_app.dart "New York"');
    print('');
    print('Setup:');
    print('  1. Get API key from https://openweathermap.org/api');
    print('  2. Set environment variable: OPENWEATHER_API_KEY=your_key_here');
    print('  3. Add http package to pubspec.yaml');
    print('=' * 40);
  }

  /// Display welcome message
  static void displayWelcome() {
    print('\n🌤️  Welcome to Weather App!');
    print('Getting current weather conditions...\n');
  }

  /// Display comparison between multiple cities
  static void displayWeatherComparison(List<Weather> weatherList) {
    if (weatherList.length < 2) return;

    print('\n📊 Temperature Comparison:');
    print('-' * 40);

    // Sort by temperature
    final sortedWeather = List<Weather>.from(weatherList)
      ..sort((a, b) => b.temperature.compareTo(a.temperature));

    print(
      '🔥 Hottest: ${sortedWeather.first.cityName} (${sortedWeather.first.temperature.toStringAsFixed(1)}°C)',
    );
    print(
      '🧊 Coolest: ${sortedWeather.last.cityName} (${sortedWeather.last.temperature.toStringAsFixed(1)}°C)',
    );

    // Calculate average temperature
    final avgTemp =
        weatherList.map((w) => w.temperature).reduce((a, b) => a + b) /
        weatherList.length;
    print('📊 Average: ${avgTemp.toStringAsFixed(1)}°C');
    print('-' * 40);
  }

  /// Capitalize first letter of each word
  static String _capitalize(String text) {
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  /// Get colored text based on temperature
  static String getTemperatureColor(double temperature) {
    if (temperature >= 30) return '🔥'; // Hot
    if (temperature >= 20) return '🌡️'; // Warm
    if (temperature >= 10) return '🌤️'; // Mild
    if (temperature >= 0) return '❄️'; // Cold
    return '🧊'; // Freezing
  }

  /// Display weather alerts or warnings
  static void displayWeatherAlerts(Weather weather) {
    final alerts = <String>[];

    if (weather.temperature >= 35) {
      alerts.add('🔥 Extreme heat warning!');
    } else if (weather.temperature <= -10) {
      alerts.add('🧊 Extreme cold warning!');
    }

    if (weather.windSpeed >= 15) {
      alerts.add('💨 High wind warning!');
    }

    if (weather.humidity >= 90) {
      alerts.add('💧 Very high humidity!');
    }

    if (alerts.isNotEmpty) {
      print('\n⚠️  Weather Alerts:');
      for (String alert in alerts) {
        print('   $alert');
      }
    }
  }
}
