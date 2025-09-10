/*
RELATIONAL AND EQUALITY OPERATORS EXAMPLES
*/

void main() {
  print("=== RELATIONAL & EQUALITY OPERATORS ===\n");

  int num1 = 25;
  int num2 = 15;
  int num3 = 25;

  print("Numbers: num1 = $num1, num2 = $num2, num3 = $num3\n");

  // Equality operators
  print("=== EQUALITY OPERATORS ===");
  print("num1 == num2: ${num1 == num2}"); // false
  print("num1 == num3: ${num1 == num3}"); // true
  print("num1 != num2: ${num1 != num2}"); // true
  print("num1 != num3: ${num1 != num3}"); // false

  print("\n=== RELATIONAL OPERATORS ===");
  print("num1 > num2: ${num1 > num2}"); // true
  print("num1 < num2: ${num1 < num2}"); // false
  print("num1 >= num3: ${num1 >= num3}"); // true
  print("num2 <= num1: ${num2 <= num1}"); // true

  print("\n=== PRACTICAL EXAMPLES ===");

  // Age verification
  int age = 18;
  print("Age: $age");
  print("Is adult (age >= 18): ${age >= 18}");
  print("Is teenager (age >= 13 && age <= 19): ${age >= 13 && age <= 19}");

  // Grade comparison
  double grade1 = 85.5;
  double grade2 = 92.0;
  print("\nGrades: grade1 = $grade1, grade2 = $grade2");
  print("Same grade: ${grade1 == grade2}");
  print("Grade1 is higher: ${grade1 > grade2}");
  print("Grade2 is better or equal: ${grade2 >= grade1}");

  // String comparison
  String name1 = "Alice";
  String name2 = "Bob";
  String name3 = "Alice";

  print("\nNames: name1 = '$name1', name2 = '$name2', name3 = '$name3'");
  print("name1 == name2: ${name1 == name2}");
  print("name1 == name3: ${name1 == name3}");
  print("name1 != name2: ${name1 != name2}");
}
