# How to Run Dart Programs

## Method 1: Using Command Line

### Navigate to your project directory
```bash
cd path/to/your/project
```

### Run a specific Dart file
```bash
dart run lib/day\ 1/03_hello_world.dart
dart run lib/day\ 1/04_print_experiments.dart
dart run lib/day\ 1/05_practice_exercises.dart
```

### Run the main project
```bash
dart run
```

## Method 2: Using VS Code

### Option A: Run Button
1. Open any .dart file
2. Click the "Run" button (play icon) in the top-right corner
3. Or press `Ctrl+F5` (Windows/Linux) or `Cmd+F5` (Mac)

### Option B: Debug Mode
1. Set breakpoints if needed
2. Press `F5` to run in debug mode
3. Use debug console to inspect variables

### Option C: Terminal in VS Code
1. Open integrated terminal (`Ctrl+`` ` or `View > Terminal`)
2. Run dart commands as shown in Method 1

## Method 3: Using Dart Pad (Online)

### For quick testing:
1. Go to https://dartpad.dev
2. Copy and paste your code
3. Click "Run" button
4. See output in the console

## Expected Output

### For hello_world.dart:
```
Hello, World!
```

### For print_experiments.dart:
```
Hello, World!
Welcome to Dart programming!
42
3.14159
15
The result is: 30
Line 1
Line 2
Line 3

Hello
World
Tab	Separated
Quote: "Hello Dart"
Single quote: 'Hello Dart'
Hello, Dart!
Learning Dart is fun!
Am I learning Dart? true
Programming languages: [Dart, Flutter, JavaScript]
Addition: 8
Subtraction: 6
Multiplication: 42
Division: 5.0
🎉 Congratulations on your first Dart program!
Keep coding and have fun! 💻
```

## Troubleshooting

### Common Issues:
1. **"dart: command not found"** - Dart SDK not installed or not in PATH
2. **File not found** - Check file path and spelling
3. **Syntax errors** - Check for missing semicolons, brackets, or quotes

### Solutions:
- Verify Dart installation: `dart --version`
- Check file paths are correct
- Use VS Code's built-in error highlighting
- Read error messages carefully - they usually point to the problem