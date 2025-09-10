# Day 23-24: Project - Basic API Client (Weather App)

## Project Overview
Building a command-line weather application that fetches data from OpenWeatherMap API.

## Learning Goals
- Handle JSON data parsing and serialization
- Make HTTP network requests using the `http` package
- Display parsed data in a clean, user-friendly format
- Error handling for network requests
- Working with API keys and environment variables

## Project Structure
```
day 23/
├── README.md                 # This file - project overview
├── notes.md                  # Detailed learning notes
├── weather_app.dart          # Main application entry point
├── models/
│   └── weather_model.dart    # Weather data model
├── services/
│   └── weather_service.dart  # API service layer
└── utils/
    └── display_helper.dart   # Helper functions for formatting output
```

## Setup Instructions
1. Get a free API key from [OpenWeatherMap](https://openweathermap.org/api)
2. Add the `http` package to your pubspec.yaml dependencies
3. Run the weather app with: `dart run lib/day\ 23/weather_app.dart`

## API Endpoint Used
- Current Weather: `https://api.openweathermap.org/data/2.5/weather`
- Documentation: https://openweathermap.org/current

## Key Concepts Covered
- HTTP GET requests
- JSON parsing with `dart:convert`
- Model classes for data structure
- Error handling and user feedback
- Command-line argument processing