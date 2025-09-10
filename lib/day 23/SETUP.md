# Weather App Setup Guide

## Prerequisites
- Dart SDK installed
- Flutter project with `http` package dependency
- Internet connection for API calls

## Getting Started

### 1. Get OpenWeatherMap API Key
1. Visit [OpenWeatherMap API](https://openweathermap.org/api)
2. Sign up for a free account
3. Navigate to API Keys section
4. Copy your API key (32-character string)

### 2. Set Environment Variable

#### Windows (Command Prompt)
```cmd
set OPENWEATHER_API_KEY=your_api_key_here
```

#### Windows (PowerShell)
```powershell
$env:OPENWEATHER_API_KEY="your_api_key_here"
```

#### macOS/Linux
```bash
export OPENWEATHER_API_KEY=your_api_key_here
```

### 3. Verify Dependencies
Check that `pubspec.yaml` includes:
```yaml
dependencies:
  http: ^1.1.0
```

If not, add it and run:
```bash
flutter pub get
```

### 4. Run the Application

#### Single City
```bash
dart run "lib/day 23/weather_app.dart" London
```

#### Multiple Cities
```bash
dart run "lib/day 23/weather_app.dart" London Paris Tokyo
```

#### City with Spaces
```bash
dart run "lib/day 23/weather_app.dart" "New York"
```

## Testing

### Run Tests
```bash
dart run "lib/day 23/test_weather_app.dart"
```

### Run Examples
```bash
dart run "lib/day 23/example_usage.dart"
```

## Troubleshooting

### Common Issues

#### "API key not found"
- Ensure environment variable is set correctly
- Restart your terminal/IDE after setting the variable
- Check variable name: `OPENWEATHER_API_KEY`

#### "City not found"
- Check city name spelling
- Try with country code: "London, GB"
- Use English city names

#### "No internet connection"
- Check your network connection
- Verify firewall settings
- Try with a different network

#### "Invalid API key"
- Verify API key is 32 characters long
- Check for extra spaces or characters
- Ensure API key is active (may take a few minutes after creation)

### API Rate Limits
- Free tier: 60 calls/minute, 1,000 calls/day
- If exceeded, wait or upgrade your plan

## Project Structure
```
day 23/
├── README.md                 # Project overview
├── SETUP.md                  # This setup guide
├── notes.md                  # Learning notes
├── weather_app.dart          # Main application
├── example_usage.dart        # Usage examples
├── test_weather_app.dart     # Simple tests
├── models/
│   └── weather_model.dart    # Data models
├── services/
│   └── weather_service.dart  # API service
└── utils/
    └── display_helper.dart   # Display utilities
```

## Next Steps
1. Try different cities and countries
2. Experiment with the code
3. Add new features like:
   - 5-day forecast
   - Weather history
   - Different units (Imperial/Metric)
   - Save favorite cities
   - Weather alerts

## API Documentation
- [OpenWeatherMap Current Weather API](https://openweathermap.org/current)
- [API Response Examples](https://openweathermap.org/current#example_JSON)
- [Error Codes](https://openweathermap.org/faq#error401)