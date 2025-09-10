import 'dart:io';
import 'models/weather_model.dart';
import 'services/weather_service.dart';
import 'utils/display_helper.dart';

/// Main weather application entry point
void main(List<String> arguments) async {
  // Display welcome message
  DisplayHelper.displayWelcome();

  // Check command line arguments
  if (arguments.isEmpty) {
    DisplayHelper.displayUsage();
    exit(1);
  }

  WeatherService? weatherService;

  try {
    // Initialize weather service
    weatherService = WeatherServiceFactory.createFromEnvironment();

    // Get city names from arguments
    final cities = _parseCityArguments(arguments);

    if (cities.length == 1) {
      // Single city weather
      await _getSingleCityWeather(weatherService, cities.first);
    } else {
      // Multiple cities weather
      await _getMultipleCitiesWeather(weatherService, cities);
    }
  } on WeatherException catch (e) {
    DisplayHelper.displayError(e.message);
    _displaySetupInstructions();
    exit(1);
  } catch (e) {
    DisplayHelper.displayError('Unexpected error: ${e.toString()}');
    exit(1);
  } finally {
    // Clean up resources
    weatherService?.dispose();
  }
}

/// Parse city names from command line arguments
List<String> _parseCityArguments(List<String> arguments) {
  final cities = <String>[];

  for (String arg in arguments) {
    // Handle quoted city names with spaces
    if (arg.contains(' ') || arg.isNotEmpty) {
      cities.add(arg.trim());
    }
  }

  return cities.where((city) => city.isNotEmpty).toList();
}

/// Get weather for a single city
Future<void> _getSingleCityWeather(
  WeatherService service,
  String cityName,
) async {
  try {
    final weather = await service.getCurrentWeather(cityName);
    DisplayHelper.displayWeather(weather);
    DisplayHelper.displayWeatherAlerts(weather);
  } on WeatherException catch (e) {
    DisplayHelper.displayError(e.message);
    _suggestAlternatives(cityName);
  }
}

/// Get weather for multiple cities
Future<void> _getMultipleCitiesWeather(
  WeatherService service,
  List<String> cities,
) async {
  print('🌍 Fetching weather for ${cities.length} cities...\n');

  final weatherList = await service.getWeatherForCities(cities);

  if (weatherList.isEmpty) {
    DisplayHelper.displayError(
      'No weather data could be retrieved for any city.',
    );
    return;
  }

  // Display individual weather reports
  for (Weather weather in weatherList) {
    DisplayHelper.displayWeather(weather);
    print(''); // Add spacing between cities
  }

  // Display summary and comparison
  DisplayHelper.displayMultipleWeather(weatherList);
  DisplayHelper.displayWeatherComparison(weatherList);
}

/// Display setup instructions for API key
void _displaySetupInstructions() {
  print('\n🔧 Setup Instructions:');
  print('1. Visit https://openweathermap.org/api');
  print('2. Sign up for a free account');
  print('3. Get your API key');
  print('4. Set environment variable:');

  if (Platform.isWindows) {
    print('   set OPENWEATHER_API_KEY=your_api_key_here');
  } else {
    print('   export OPENWEATHER_API_KEY=your_api_key_here');
  }

  print('5. Run the app again');
}

/// Suggest alternative city names
void _suggestAlternatives(String cityName) {
  print('\n💡 Suggestions:');
  print('• Try the full city name: "$cityName, Country"');
  print('• Check spelling: common cities like "London", "Paris", "Tokyo"');
  print('• Use English names for international cities');
  print('• For US cities, try: "$cityName, US" or "$cityName, USA"');
}

/// Interactive mode for continuous weather queries
Future<void> _runInteractiveMode(WeatherService service) async {
  print('\n🔄 Interactive Mode - Type city names or "quit" to exit');

  while (true) {
    stdout.write('\nEnter city name: ');
    final input = stdin.readLineSync()?.trim();

    if (input == null ||
        input.toLowerCase() == 'quit' ||
        input.toLowerCase() == 'exit') {
      print('👋 Goodbye!');
      break;
    }

    if (input.isEmpty) {
      print('Please enter a city name.');
      continue;
    }

    try {
      final weather = await service.getCurrentWeather(input);
      DisplayHelper.displayWeather(weather);
    } on WeatherException catch (e) {
      DisplayHelper.displayError(e.message);
    }
  }
}

/// Check if running in interactive mode
bool _shouldRunInteractiveMode(List<String> arguments) {
  return arguments.contains('--interactive') || arguments.contains('-i');
}
