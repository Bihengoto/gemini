# Day 6: Functions in Dart

Welcome to Day 6 of your Dart learning journey! Today we'll explore functions - one of the most important concepts in programming.

## 📚 What You'll Learn

### 1. Function Basics (`01_function_basics.dart`)
- How to define and call functions
- Functions with and without return values
- Function parameters and return types
- Basic function structure and syntax

### 2. Required Parameters (`02_required_parameters.dart`)
- Understanding required parameters
- Parameter order and types
- Function calls with multiple required parameters
- Error handling for missing parameters

### 3. Optional Positional Parameters (`03_optional_positional_parameters.dart`)
- Using square brackets `[]` for optional parameters
- Default parameter values
- Calling functions with partial parameters
- Parameter order rules

### 4. Named Parameters (`04_named_parameters.dart`)
- Using curly braces `{}` for named parameters
- Required vs optional named parameters
- Calling functions with named parameters in any order
- Mixing positional and named parameters

### 5. Arrow Syntax (`05_arrow_syntax.dart`)
- Single-expression functions using `=>`
- When to use arrow syntax vs regular functions
- Converting regular functions to arrow syntax
- Benefits and limitations

### 6. Practice Exercises (`06_practice_exercises.dart`)
- Hands-on coding exercises
- Real-world function examples
- Testing your implementations
- Advanced function concepts

## 🎯 Key Concepts

### Function Definition Syntax
```dart
// Basic function
returnType functionName(parameters) {
  // function body
  return value; // if returnType is not void
}

// Arrow function (single expression)
returnType functionName(parameters) => expression;
```

### Parameter Types
```dart
// Required parameters
void func(int a, String b) { }

// Optional positional parameters
void func(int a, [String b = 'default']) { }

// Named parameters
void func({required int a, String b = 'default'}) { }

// Mixed parameters
void func(int required, [String optional], {String named = 'default'}) { }
```

## 🚀 Practice Challenge

The main practice challenge is to create a function that takes two numbers and returns their sum. You'll find this implemented in multiple ways throughout the exercises:

```dart
// Basic implementation
int sum(int a, int b) => a + b;

// With named parameters
int sum({required int a, required int b}) => a + b;

// With optional parameters
int sum(int a, [int b = 0]) => a + b;
```

## 📝 Running the Code

To run any of the example files:

```bash
dart run gemini/lib/day\ 6/01_function_basics.dart
dart run gemini/lib/day\ 6/02_required_parameters.dart
dart run gemini/lib/day\ 6/03_optional_positional_parameters.dart
dart run gemini/lib/day\ 6/04_named_parameters.dart
dart run gemini/lib/day\ 6/05_arrow_syntax.dart
dart run gemini/lib/day\ 6/06_practice_exercises.dart
```

## 🎓 Learning Tips

1. **Start Simple**: Begin with basic functions and gradually add complexity
2. **Practice Arrow Syntax**: Great for simple, single-expression functions
3. **Use Named Parameters**: They make your code more readable and maintainable
4. **Test Your Functions**: Always verify your functions work as expected
5. **Read the Comments**: Each file has detailed explanations and examples

## 🔗 What's Next?

After mastering functions, you'll be ready to explore:
- Classes and Objects
- Collections (Lists, Maps, Sets)
- Error Handling
- Asynchronous Programming

## 📋 Checklist

- [ ] Understand basic function syntax
- [ ] Practice with required parameters
- [ ] Learn optional positional parameters
- [ ] Master named parameters
- [ ] Use arrow syntax effectively
- [ ] Complete all practice exercises
- [ ] Create your own sum function
- [ ] Test all your implementations

Happy coding! 🎉