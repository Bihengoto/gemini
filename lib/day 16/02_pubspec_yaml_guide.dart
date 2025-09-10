// Day 16: Understanding pubspec.yaml
// ==================================

/*
THE pubspec.yaml FILE

The pubspec.yaml file is the heart of every Dart/Flutter project.
It defines:
- Project metadata (name, description, version)
- Dependencies (external packages your project uses)
- Dev dependencies (packages used only during development)
- Assets (images, fonts, other files)
- Flutter-specific configurations

BASIC STRUCTURE:

name: my_app
description: A new Flutter project
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.0.0"

dependencies:
  flutter:
    sdk: flutter
  # Add your dependencies here
  http: ^1.1.0
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
  fonts:
    - family: Roboto
      fonts:
        - asset: fonts/Roboto-Regular.ttf

KEY SECTIONS EXPLAINED:

1. DEPENDENCIES:
   - Packages your app needs to run
   - Use semantic versioning (^1.0.0 means >=1.0.0 <2.0.0)

2. DEV_DEPENDENCIES:
   - Packages used only during development (testing, linting)
   - Not included in the final app build

3. VERSION CONSTRAINTS:
   - ^1.0.0: Compatible with 1.x.x (recommended)
   - >=1.0.0 <2.0.0: Explicit range
   - 1.0.0: Exact version (not recommended)
   - any: Any version (dangerous, avoid)

4. FLUTTER SECTION:
   - Flutter-specific configurations
   - Assets, fonts, plugins, etc.
*/

// Example of how to check current dependencies
void demonstratePubspecConcepts() {
  print(
    'pubspec.yaml is like package.json in Node.js or requirements.txt in Python',
  );
  print('It tells Dart/Flutter what external code your project depends on');

  // After adding dependencies to pubspec.yaml, run:
  // flutter pub get (to download and install packages)
  // flutter pub upgrade (to update packages to latest compatible versions)
  // flutter pub deps (to see dependency tree)
}
