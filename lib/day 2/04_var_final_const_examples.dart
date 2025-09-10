// Variable Declaration Keywords Examples

void main() {
  // var examples
  var userName = 'Alice'; // String inferred
  var userAge = 28; // int inferred
  var isActive = true; // bool inferred
  
  print('Initial: $userName, $userAge, $isActive');
  
  // var allows reassignment
  userName = 'Bob';
  userAge = 30;
  isActive = false;
  
  print('After change: $userName, $userAge, $isActive');
  
  // final examples
  final String appVersion = '1.0.0';
  final currentDateTime = DateTime.now(); // Runtime value
  final List<int> scores = [85, 92, 78];
  
  print('App version: $appVersion');
  print('Current time: $currentDateTime');
  print('Initial scores: $scores');
  
  // final reference cannot be reassigned, but object can be modified
  scores.add(95); // ✅ Allowed
  scores.sort(); // ✅ Allowed
  print('Modified scores: $scores');
  
  // appVersion = '2.0.0'; // ❌ Error - cannot reassign final
  
  // const examples
  const String companyName = 'TechCorp';
  const int maxRetries = 3;
  const double pi = 3.14159;
  const List<String> weekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'
  ];
  
  print('Company: $companyName');
  print('Max retries: $maxRetries');
  print('Pi: $pi');
  print('Weekdays: $weekdays');
  
  // const objects are completely immutable
  // weekdays.add('Saturday'); // ❌ Error - cannot modify const list
  // companyName = 'NewCorp'; // ❌ Error - cannot reassign const
  
  // Demonstrating compile-time vs runtime
  const compileTimeValue = 42; // Known at compile time
  final runtimeValue = DateTime.now().millisecondsSinceEpoch; // Known at runtime
  
  print('Compile-time value: $compileTimeValue');
  print('Runtime value: $runtimeValue');
  
  // Type annotations with keywords
  const int explicitInt = 100;
  final double explicitDouble = 25.5;
  var String explicitString = 'Hello'; // Less common but valid
  
  print('Explicit types: $explicitInt, $explicitDouble, $explicitString');
}