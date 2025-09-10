import 'models/weather_model.dart';
import 'services/weather_service.dart';
import 'utils/display_helper.dart';

/// Example usage of the Weather API client
/// This file demonstrates how to use the weather service programmatically
void main() async {
  // Example 1: Basic usage with error handling
  await basicWeatherExample();

  // Example 2: Multiple cities
  await multipleCitiesExample();

  // Example 3: Working with Weather model
  weatherModelExample();
}

/// Basic weather fetching example
Future<void> basicWeatherExample() async {
  print('\n🔹 Example 1: Basic Weather Fetching');
  print('-' * 40);

  try {
    // Replace with your actual API key for testing
    const apiKey = 'your_api_key_here';
    final weatherService = WeatherService(apiKey);

    // Fetch weather for London
    final weather = await weatherService.getCurrentWeather('London');

    // Display the weather
    DisplayHelper.displayWeather(weather);

    // Clean up
    weatherService.dispose();
  } on WeatherException catch (e) {
    print('Weather error: ${e.message}');
  } catch (e) {
    print('Unexpected error: $e');
  }
}

/// Multiple cities example
Future<void> multipleCitiesExample() async {
  print('\n🔹 Example 2: Multiple Cities Weather');
  print('-' * 40);

  try {
    // Use environment variable for API key
    final weatherService = WeatherServiceFactory.createFromEnvironment();

    final cities = ['London', 'Paris', 'Tokyo', 'New York'];
    final weatherList = await weatherService.getWeatherForCities(cities);

    // Display comparison
    DisplayHelper.displayMultipleWeather(weatherList);
    DisplayHelper.displayWeatherComparison(weatherList);

    weatherService.dispose();
  } on WeatherException catch (e) {
    print('Weather error: ${e.message}');
  }
}

/// Weather model manipulation example
void weatherModelExample() {
  print('\n🔹 Example 3: Working with Weather Model');
  print('-' * 40);

  // Example JSON response (simplified)
  final jsonData = {
    'name': 'London',
    'sys': {'country': 'GB'},
    'main': {
      'temp': 15.5,
      'feels_like': 14.2,
      'humidity': 78,
      'pressure': 1013,
    },
    'weather': [
      {'main': 'Clouds', 'description': 'overcast clouds'},
    ],
    'wind': {'speed': 3.2},
    'visibility': 10000,
  };

  // Create Weather object from JSON
  final weather = Weather.fromJson(jsonData);

  // Demonstrate model properties
  print('City: ${weather.cityName}');
  print('Temperature: ${weather.temperature}°C');
  print('Feels like: ${weather.feelsLike}°C');
  print(
    'In Fahrenheit: ${weather.temperatureInFahrenheit.toStringAsFixed(1)}°F',
  );
  print('Weather emoji: ${weather.weatherEmoji}');
  print('Humidity level: ${weather.humidityLevel}');
  print('Wind description: ${weather.windDescription}');

  // Convert back to JSON
  final jsonOutput = weather.toJson();
  print('\nJSON output: $jsonOutput');

  // String representation
  print('\nString representation: $weather');
}

/// Example of custom error handling
Future<void> errorHandlingExample() async {
  print('\n🔹 Example 4: Error Handling');
  print('-' * 40);

  final weatherService = WeatherService('invalid_api_key');

  try {
    await weatherService.getCurrentWeather('London');
  } on WeatherException catch (e) {
    switch (e.statusCode) {
      case 401:
        print('Authentication failed: ${e.message}');
        break;
      case 404:
        print('City not found: ${e.message}');
        break;
      case 429:
        print('Rate limit exceeded: ${e.message}');
        break;
      default:
        print('Other weather error: ${e.message}');
    }
  } finally {
    weatherService.dispose();
  }
}

/// Example of API key validation
void apiKeyValidationExample() {
  print('\n🔹 Example 5: API Key Validation');
  print('-' * 40);

  final validKey = 'abcdef1234567890abcdef1234567890';
  final invalidKey = 'short';

  print('Valid key check: ${WeatherService.isValidApiKey(validKey)}');
  print('Invalid key check: ${WeatherService.isValidApiKey(invalidKey)}');

  // Try to create service with invalid key
  try {
    WeatherServiceFactory.createWithApiKey(invalidKey);
  } on WeatherException catch (e) {
    print('Expected error: ${e.message}');
  }
}
