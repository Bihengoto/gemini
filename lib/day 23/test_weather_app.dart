import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/weather_model.dart';
import 'services/weather_service.dart';

/// Simple test file for the weather app
/// Run with: dart run lib/day\ 23/test_weather_app.dart
void main() async {
  print('🧪 Running Weather App Tests...\n');

  // Run all tests
  testWeatherModel();
  testWeatherService();
  await testApiKeyValidation();
  testErrorHandling();

  print('\n✅ All tests completed!');
}

/// Test Weather model creation and methods
void testWeatherModel() {
  print('🔹 Testing Weather Model...');

  // Test data
  final testJson = {
    'name': 'London',
    'sys': {'country': 'GB'},
    'main': {
      'temp': 20.5,
      'feels_like': 19.8,
      'humidity': 65,
      'pressure': 1015,
    },
    'weather': [
      {'main': 'Clear', 'description': 'clear sky'},
    ],
    'wind': {'speed': 2.5},
    'visibility': 10000,
  };

  try {
    // Test JSON parsing
    final weather = Weather.fromJson(testJson);

    // Test basic properties
    assert(weather.cityName == 'London');
    assert(weather.country == 'GB');
    assert(weather.temperature == 20.5);
    assert(weather.mainCondition == 'Clear');

    // Test calculated properties
    assert(
      weather.temperatureInFahrenheit > 68 &&
          weather.temperatureInFahrenheit < 70,
    );
    assert(weather.weatherEmoji == '☀️');
    assert(weather.humidityLevel == 'High');

    // Test JSON conversion
    final jsonOutput = weather.toJson();
    assert(jsonOutput['name'] == 'London');

    print('   ✅ Weather model tests passed');
  } catch (e) {
    print('   ❌ Weather model test failed: $e');
  }
}

/// Test WeatherService functionality
void testWeatherService() {
  print('🔹 Testing Weather Service...');

  try {
    // Test API key validation
    assert(
      WeatherService.isValidApiKey('abcdef1234567890abcdef1234567890') == true,
    );
    assert(WeatherService.isValidApiKey('short') == false);
    assert(WeatherService.isValidApiKey('') == false);

    // Test service creation
    final service = WeatherService('test_api_key_1234567890123456789012');
    assert(service != null);

    print('   ✅ Weather service tests passed');
  } catch (e) {
    print('   ❌ Weather service test failed: $e');
  }
}

/// Test API key validation
Future<void> testApiKeyValidation() async {
  print('🔹 Testing API Key Validation...');

  try {
    // Test invalid API key creation
    bool exceptionThrown = false;
    try {
      WeatherServiceFactory.createWithApiKey('invalid');
    } on WeatherException {
      exceptionThrown = true;
    }
    assert(exceptionThrown == true);

    // Test environment variable (will likely fail in test environment)
    try {
      WeatherServiceFactory.createFromEnvironment();
      print('   ⚠️  Environment API key found (unexpected in test)');
    } on WeatherException {
      print('   ✅ Environment API key validation working');
    }
  } catch (e) {
    print('   ❌ API key validation test failed: $e');
  }
}

/// Test error handling
void testErrorHandling() {
  print('🔹 Testing Error Handling...');

  try {
    // Test WeatherException creation
    final exception1 = WeatherException('Test message');
    assert(exception1.message == 'Test message');
    assert(exception1.statusCode == null);

    final exception2 = WeatherException('Test with code', 404);
    assert(exception2.statusCode == 404);

    // Test toString methods
    final weather = Weather(
      cityName: 'Test City',
      country: 'TC',
      temperature: 25.0,
      feelsLike: 24.0,
      humidity: 50,
      pressure: 1000,
      description: 'test weather',
      mainCondition: 'Test',
      windSpeed: 1.0,
      visibility: 10,
    );

    final weatherString = weather.toString();
    assert(weatherString.contains('Test City'));
    assert(weatherString.contains('25.0'));

    print('   ✅ Error handling tests passed');
  } catch (e) {
    print('   ❌ Error handling test failed: $e');
  }
}

/// Mock HTTP client for testing (advanced)
class MockHttpClient extends http.BaseClient {
  final Map<String, http.Response> responses;

  MockHttpClient(this.responses);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final url = request.url.toString();

    if (responses.containsKey(url)) {
      final response = responses[url]!;
      return http.StreamedResponse(
        Stream.fromIterable([response.bodyBytes]),
        response.statusCode,
        headers: response.headers,
      );
    }

    // Default 404 response
    return http.StreamedResponse(
      Stream.fromIterable([utf8.encode('Not Found')]),
      404,
    );
  }
}

/// Example of testing with mock HTTP client
Future<void> testWithMockClient() async {
  print('🔹 Testing with Mock HTTP Client...');

  // Mock successful response
  final mockResponse = {
    'name': 'London',
    'sys': {'country': 'GB'},
    'main': {
      'temp': 15.0,
      'feels_like': 14.0,
      'humidity': 80,
      'pressure': 1010,
    },
    'weather': [
      {'main': 'Rain', 'description': 'light rain'},
    ],
    'wind': {'speed': 3.0},
    'visibility': 8000,
  };

  final mockClient = MockHttpClient({
    'https://api.openweathermap.org/data/2.5/weather?q=London&appid=test_key&units=metric':
        http.Response(json.encode(mockResponse), 200),
  });

  try {
    final service = WeatherService('test_key', httpClient: mockClient);
    final weather = await service.getCurrentWeather('London');

    assert(weather.cityName == 'London');
    assert(weather.temperature == 15.0);

    print('   ✅ Mock client test passed');
  } catch (e) {
    print('   ❌ Mock client test failed: $e');
  }
}
