# Day 23-24: API Client Development Notes

## HTTP Package in Dart

### Installation
Add to `pubspec.yaml`:
```yaml
dependencies:
  http: ^1.1.0
```

### Basic HTTP Request
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

// GET request
final response = await http.get(Uri.parse('https://api.example.com/data'));

// Check status code
if (response.statusCode == 200) {
  // Success - parse JSON
  final data = json.decode(response.body);
} else {
  // Handle error
  throw Exception('Failed to load data: ${response.statusCode}');
}
```

## JSON Handling in Dart

### Parsing JSON
```dart
import 'dart:convert';

// From JSON string to Map
String jsonString = '{"name": "John", "age": 30}';
Map<String, dynamic> data = json.decode(jsonString);

// From Map to JSON string
String jsonOutput = json.encode(data);
```

### Model Classes
Create classes to represent your data structure:
```dart
class Weather {
  final String cityName;
  final double temperature;
  final String description;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  // Factory constructor for JSON parsing
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'temp': temperature,
      'description': description,
    };
  }
}
```

## Error Handling Best Practices

### Network Errors
```dart
try {
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw HttpException('HTTP ${response.statusCode}: ${response.reasonPhrase}');
  }
} on SocketException {
  throw Exception('No internet connection');
} on HttpException catch (e) {
  throw Exception('HTTP error: $e');
} on FormatException {
  throw Exception('Invalid JSON format');
} catch (e) {
  throw Exception('Unexpected error: $e');
}
```

## API Key Management

### Environment Variables (Recommended)
```dart
// Get API key from environment
String? apiKey = Platform.environment['OPENWEATHER_API_KEY'];
if (apiKey == null) {
  throw Exception('API key not found. Set OPENWEATHER_API_KEY environment variable.');
}
```

### Command Line Arguments
```dart
void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Usage: dart weather_app.dart <city_name>');
    return;
  }
  
  String cityName = arguments.join(' ');
  // Use cityName in API call
}
```

## OpenWeatherMap API Details

### Current Weather Endpoint
```
GET https://api.openweathermap.org/data/2.5/weather?q={city}&appid={API_key}&units=metric
```

### Response Structure
```json
{
  "coord": {"lon": -122.08, "lat": 37.39},
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "main": {
    "temp": 282.55,
    "feels_like": 281.86,
    "temp_min": 280.37,
    "temp_max": 284.26,
    "pressure": 1023,
    "humidity": 100
  },
  "name": "Mountain View",
  "cod": 200
}
```

## Command Line Interface Tips

### User-Friendly Output
```dart
void displayWeather(Weather weather) {
  print('🌤️  Weather in ${weather.cityName}');
  print('🌡️  Temperature: ${weather.temperature.toStringAsFixed(1)}°C');
  print('☁️  Condition: ${weather.description}');
  print('💨  Feels like: ${weather.feelsLike.toStringAsFixed(1)}°C');
}
```

### Loading Indicators
```dart
void showLoading(String city) {
  stdout.write('Fetching weather data for $city');
  Timer.periodic(Duration(milliseconds: 500), (timer) {
    stdout.write('.');
  });
}
```

## Testing Your API Client

### Manual Testing
1. Test with valid city names
2. Test with invalid city names
3. Test with no internet connection
4. Test with invalid API key

### Unit Testing Example
```dart
import 'package:test/test.dart';

void main() {
  group('Weather Model Tests', () {
    test('should create Weather from JSON', () {
      final json = {
        'name': 'London',
        'main': {'temp': 15.5},
        'weather': [{'description': 'cloudy'}]
      };
      
      final weather = Weather.fromJson(json);
      
      expect(weather.cityName, equals('London'));
      expect(weather.temperature, equals(15.5));
    });
  });
}
```