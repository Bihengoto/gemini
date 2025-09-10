// Day 16: Package Management Best Practices
// =========================================

/*
FLUTTER PUB COMMANDS

Essential commands for managing packages in Flutter:

1. flutter pub get
   - Downloads and installs all dependencies
   - Run after adding/removing packages from pubspec.yaml

2. flutter pub upgrade
   - Updates packages to latest compatible versions
   - Respects version constraints in pubspec.yaml

3. flutter pub deps
   - Shows dependency tree
   - Helps identify version conflicts

4. flutter pub outdated
   - Shows which packages have newer versions available
   - Indicates if updates are breaking or non-breaking

5. flutter pub add <package_name>
   - Adds package to pubspec.yaml and runs pub get
   - Example: flutter pub add http

6. flutter pub remove <package_name>
   - Removes package from pubspec.yaml
   - Example: flutter pub remove http

7. flutter pub cache repair
   - Repairs corrupted package cache
   - Use when facing package-related issues

8. flutter pub publish
   - Publishes your package to pub.dev
   - For package authors only
*/

import 'dart:io';

class PackageManager {
  // Simulate checking package versions
  static void checkPackageStatus() {
    print('=== Package Management Commands ===\n');

    print('Common pub commands:');
    print('flutter pub get      - Install dependencies');
    print('flutter pub upgrade  - Update packages');
    print('flutter pub deps     - Show dependency tree');
    print('flutter pub outdated - Check for updates');
    print('flutter pub add http - Add new package');
    print('flutter pub remove http - Remove package\n');
  }

  // Version constraint examples
  static void versionConstraintExamples() {
    print('=== Version Constraint Examples ===\n');

    Map<String, String> constraints = {
      '^1.0.0': 'Compatible with 1.x.x (recommended)',
      '>=1.0.0 <2.0.0': 'Explicit range',
      '1.0.0': 'Exact version (not recommended)',
      'any': 'Any version (dangerous, avoid)',
      '>=1.0.0': 'At least version 1.0.0',
      '<2.0.0': 'Less than version 2.0.0',
    };

    constraints.forEach((constraint, description) {
      print('$constraint - $description');
    });
    print();
  }

  // Dependency conflict resolution
  static void dependencyConflictResolution() {
    print('=== Resolving Dependency Conflicts ===\n');

    print('When you encounter version conflicts:');
    print('1. Run "flutter pub deps" to see the dependency tree');
    print('2. Identify conflicting packages');
    print('3. Update version constraints in pubspec.yaml');
    print('4. Use "dependency_overrides" as last resort');
    print('5. Consider alternative packages if conflicts persist\n');

    print('Example dependency_overrides in pubspec.yaml:');
    print('dependency_overrides:');
    print('  http: ^1.1.0  # Force specific version');
    print();
  }
}

// Best practices for package management
class PackageBestPractices {
  static void generalBestPractices() {
    print('=== Package Management Best Practices ===\n');

    List<String> practices = [
      '1. Use semantic versioning constraints (^1.0.0)',
      '2. Regularly update packages for security fixes',
      '3. Test thoroughly after package updates',
      '4. Keep pubspec.yaml organized and commented',
      '5. Use dev_dependencies for development-only packages',
      '6. Avoid using "any" version constraint',
      '7. Pin exact versions for critical packages if needed',
      '8. Review package licenses for commercial projects',
      '9. Monitor package maintenance and community support',
      '10. Use dependency_overrides sparingly',
    ];

    for (String practice in practices) {
      print(practice);
    }
    print();
  }

  static void pubspecOrganization() {
    print('=== Organizing pubspec.yaml ===\n');

    print('''
# Good pubspec.yaml organization:

dependencies:
  flutter:
    sdk: flutter
  
  # UI Components
  flutter_staggered_grid_view: ^0.7.0
  carousel_slider: ^4.2.1
  
  # Networking
  http: ^1.1.0
  dio: ^5.3.2
  
  # State Management
  provider: ^6.1.1
  
  # Local Storage
  shared_preferences: ^2.2.2
  
  # Utilities
  intl: ^0.19.0
  path_provider: ^2.1.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  mockito: ^5.4.2
''');
  }
}

void main() {
  PackageManager.checkPackageStatus();
  PackageManager.versionConstraintExamples();
  PackageManager.dependencyConflictResolution();
  PackageBestPractices.generalBestPractices();
  PackageBestPractices.pubspecOrganization();
}
