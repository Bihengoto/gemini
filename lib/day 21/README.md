# Day 21-22: Console To-Do List Manager Project

## Project Overview
This project combines all the Dart skills learned so far to build an interactive console-based to-do list manager. The application demonstrates object-oriented programming, data structures, and user interaction patterns.

## Features
- ✅ Add new tasks
- 📋 List all tasks
- ❌ Remove tasks
- ✔️ Mark tasks as complete/incomplete
- 💾 Persistent storage (optional enhancement)

## Project Structure
```
day 21/
├── README.md              # Project documentation
├── notes.md              # Learning notes and reflections
├── task.dart             # Task model class
├── todo_manager.dart     # Main business logic
├── console_ui.dart       # User interface handling
├── main.dart             # Application entry point
└── examples.dart         # Usage examples and tests
```

## Design Patterns Used
1. **Model-View-Controller (MVC)**: Separation of data (Task), logic (TodoManager), and UI (ConsoleUI)
2. **Single Responsibility Principle**: Each class has one clear purpose
3. **Encapsulation**: Private fields with public methods for controlled access

## How to Run
```bash
dart run gemini/lib/day\ 21/main.dart
```

## Learning Objectives
- Apply object-oriented programming concepts
- Use collections (List) for data management
- Implement user input validation
- Practice code organization and structure
- Understand basic design patterns