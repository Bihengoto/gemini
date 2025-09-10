import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

/// Service class for handling weather API requests
class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _currentWeatherEndpoint = '/weather';

  final String _apiKey;
  final http.Client _httpClient;

  WeatherService(this._apiKey, {http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  /// Fetch current weather data for a given city
  Future<Weather> getCurrentWeather(String cityName) async {
    try {
      final uri = _buildWeatherUri(cityName);
      print('🔄 Fetching weather data for $cityName...');

      final response = await _httpClient
          .get(uri)
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw WeatherException(
                'Request timeout. Please check your internet connection.',
              );
            },
          );

      return _handleResponse(response);
    } on SocketException {
      throw WeatherException(
        'No internet connection. Please check your network.',
      );
    } on HttpException catch (e) {
      throw WeatherException('Network error: ${e.message}');
    } on FormatException {
      throw WeatherException('Invalid response format from weather service.');
    } catch (e) {
      if (e is WeatherException) rethrow;
      throw WeatherException('Unexpected error: ${e.toString()}');
    }
  }

  /// Fetch weather data for multiple cities
  Future<List<Weather>> getWeatherForCities(List<String> cities) async {
    final List<Weather> weatherList = [];

    for (String city in cities) {
      try {
        final weather = await getCurrentWeather(city);
        weatherList.add(weather);
      } catch (e) {
        print('❌ Failed to get weather for $city: $e');
        // Continue with other cities
      }
    }

    return weatherList;
  }

  /// Build the complete URI for weather API request
  Uri _buildWeatherUri(String cityName) {
    return Uri.parse('$_baseUrl$_currentWeatherEndpoint').replace(
      queryParameters: {
        'q': cityName,
        'appid': _apiKey,
        'units': 'metric', // Use Celsius
      },
    );
  }

  /// Handle HTTP response and parse weather data
  Weather _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> data = json.decode(response.body);
        return Weather.fromJson(data);

      case 401:
        throw WeatherException(
          'Invalid API key. Please check your OpenWeatherMap API key.',
          response.statusCode,
        );

      case 404:
        throw WeatherException(
          'City not found. Please check the city name and try again.',
          response.statusCode,
        );

      case 429:
        throw WeatherException(
          'API rate limit exceeded. Please try again later.',
          response.statusCode,
        );

      case 500:
      case 502:
      case 503:
        throw WeatherException(
          'Weather service is temporarily unavailable. Please try again later.',
          response.statusCode,
        );

      default:
        throw WeatherException(
          'Failed to fetch weather data: ${response.reasonPhrase}',
          response.statusCode,
        );
    }
  }

  /// Validate API key format (basic validation)
  static bool isValidApiKey(String apiKey) {
    // OpenWeatherMap API keys are typically 32 characters long
    return apiKey.isNotEmpty && apiKey.length >= 32;
  }

  /// Get API key from environment variables
  static String? getApiKeyFromEnvironment() {
    return Platform.environment['OPENWEATHER_API_KEY'];
  }

  /// Dispose of HTTP client resources
  void dispose() {
    _httpClient.close();
  }
}

/// Factory class for creating WeatherService instances
class WeatherServiceFactory {
  /// Create WeatherService with API key from environment
  static WeatherService createFromEnvironment() {
    final apiKey = WeatherService.getApiKeyFromEnvironment();

    if (apiKey == null || apiKey.isEmpty) {
      throw WeatherException(
        'API key not found. Please set the OPENWEATHER_API_KEY environment variable.',
      );
    }

    if (!WeatherService.isValidApiKey(apiKey)) {
      throw WeatherException(
        'Invalid API key format. Please check your OpenWeatherMap API key.',
      );
    }

    return WeatherService(apiKey);
  }

  /// Create WeatherService with provided API key
  static WeatherService createWithApiKey(String apiKey) {
    if (!WeatherService.isValidApiKey(apiKey)) {
      throw WeatherException(
        'Invalid API key format. Please check your OpenWeatherMap API key.',
      );
    }

    return WeatherService(apiKey);
  }
}
