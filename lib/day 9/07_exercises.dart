// Day 9 Exercises: Abstract Classes & Interfaces

/*
EXERCISE 1: Shape Abstract Class
Create an abstract class Shape with:
- Abstract method calculateArea()
- Abstract method calculatePerimeter()
- Concrete method displayInfo()

Then create Rectangle and Circle classes that extend Shape.
*/

abstract class Shape {
  String name;

  Shape(this.name);

  // Abstract methods
  double calculateArea();
  double calculatePerimeter();

  // Concrete method
  void displayInfo() {
    print('Shape: $name');
    print('Area: ${calculateArea().toStringAsFixed(2)}');
    print('Perimeter: ${calculatePerimeter().toStringAsFixed(2)}');
  }
}

class Rectangle extends Shape {
  double width;
  double height;

  Rectangle(this.width, this.height) : super('Rectangle');

  @override
  double calculateArea() {
    return width * height;
  }

  @override
  double calculatePerimeter() {
    return 2 * (width + height);
  }
}

class Circle extends Shape {
  double radius;
  static const double pi = 3.14159;

  Circle(this.radius) : super('Circle');

  @override
  double calculateArea() {
    return pi * radius * radius;
  }

  @override
  double calculatePerimeter() {
    return 2 * pi * radius;
  }
}

/*
EXERCISE 2: Media Player Interfaces
Create interfaces for Playable, Pausable, and Stoppable.
Then create AudioPlayer and VideoPlayer classes that implement these interfaces.
*/

class Playable {
  void play() {
    print('Playing media...');
  }
}

class Pausable {
  void pause() {
    print('Pausing media...');
  }
}

class Stoppable {
  void stop() {
    print('Stopping media...');
  }
}

class AudioPlayer implements Playable, Pausable, Stoppable {
  String currentSong;
  bool isPlaying = false;

  AudioPlayer(this.currentSong);

  @override
  void play() {
    isPlaying = true;
    print('🎵 Playing audio: $currentSong');
  }

  @override
  void pause() {
    isPlaying = false;
    print('⏸️ Audio paused: $currentSong');
  }

  @override
  void stop() {
    isPlaying = false;
    print('⏹️ Audio stopped: $currentSong');
  }

  void adjustVolume(int volume) {
    print('🔊 Volume set to $volume%');
  }
}

class VideoPlayer implements Playable, Pausable, Stoppable {
  String currentVideo;
  bool isPlaying = false;
  String quality;

  VideoPlayer(this.currentVideo, this.quality);

  @override
  void play() {
    isPlaying = true;
    print('🎬 Playing video: $currentVideo in $quality quality');
  }

  @override
  void pause() {
    isPlaying = false;
    print('⏸️ Video paused: $currentVideo');
  }

  @override
  void stop() {
    isPlaying = false;
    print('⏹️ Video stopped: $currentVideo');
  }

  void changeQuality(String newQuality) {
    quality = newQuality;
    print('📺 Quality changed to $quality');
  }

  void enableSubtitles() {
    print('📝 Subtitles enabled for $currentVideo');
  }
}

/*
EXERCISE 3: Employee Management System
Create an abstract Employee class and different employee types with various interfaces.
*/

abstract class Employee {
  String name;
  int id;
  double baseSalary;

  Employee(this.name, this.id, this.baseSalary);

  // Abstract method
  double calculateSalary();

  // Concrete methods
  void displayInfo() {
    print('Employee: $name (ID: $id)');
    print('Salary: \$${calculateSalary().toStringAsFixed(2)}');
  }

  void clockIn() {
    print('$name clocked in at ${DateTime.now().toString().substring(11, 16)}');
  }
}

// Interfaces for different capabilities
class Manageable {
  void manageTeam() {
    print('Managing team members...');
  }

  void conductMeeting() {
    print('Conducting team meeting...');
  }
}

class Trainable {
  void attendTraining(String course) {
    print('Attending training: $course');
  }

  void completeAssessment() {
    print('Completing skills assessment...');
  }
}

class Billable {
  void trackHours(double hours) {
    print('Tracked $hours billable hours');
  }

  void generateInvoice() {
    print('Generating client invoice...');
  }
}

class Manager extends Employee implements Manageable, Trainable {
  int teamSize;
  double bonus;

  Manager(String name, int id, double baseSalary, this.teamSize, this.bonus)
    : super(name, id, baseSalary);

  @override
  double calculateSalary() {
    return baseSalary + bonus + (teamSize * 500); // Bonus per team member
  }

  @override
  void manageTeam() {
    print('$name is managing a team of $teamSize people');
  }

  @override
  void conductMeeting() {
    print('$name is conducting weekly team meeting');
  }

  @override
  void attendTraining(String course) {
    print('$name attending leadership training: $course');
  }

  @override
  void completeAssessment() {
    print('$name completing management assessment');
  }
}

class Developer extends Employee implements Trainable, Billable {
  String programmingLanguage;
  int experienceYears;

  Developer(
    String name,
    int id,
    double baseSalary,
    this.programmingLanguage,
    this.experienceYears,
  ) : super(name, id, baseSalary);

  @override
  double calculateSalary() {
    return baseSalary + (experienceYears * 2000); // Experience bonus
  }

  @override
  void attendTraining(String course) {
    print('$name attending technical training: $course');
  }

  @override
  void completeAssessment() {
    print('$name completing coding assessment in $programmingLanguage');
  }

  @override
  void trackHours(double hours) {
    print('$name tracked $hours development hours');
  }

  @override
  void generateInvoice() {
    print('$name generating invoice for development work');
  }

  void writeCode() {
    print('$name is writing code in $programmingLanguage');
  }

  void debugCode() {
    print('$name is debugging $programmingLanguage code');
  }
}

void main() {
  print('=== EXERCISE 1: Shape Abstract Class ===');

  Rectangle rect = Rectangle(5.0, 3.0);
  Circle circle = Circle(4.0);

  rect.displayInfo();
  print('');
  circle.displayInfo();

  print('\n=== EXERCISE 2: Media Player Interfaces ===');

  AudioPlayer audioPlayer = AudioPlayer('Bohemian Rhapsody');
  VideoPlayer videoPlayer = VideoPlayer('Avengers: Endgame', '4K');

  audioPlayer.play();
  audioPlayer.adjustVolume(75);
  audioPlayer.pause();
  audioPlayer.stop();

  print('');

  videoPlayer.play();
  videoPlayer.changeQuality('1080p');
  videoPlayer.enableSubtitles();
  videoPlayer.pause();
  videoPlayer.stop();

  print('\n=== EXERCISE 3: Employee Management System ===');

  Manager manager = Manager('Alice Johnson', 101, 80000, 8, 15000);
  Developer developer = Developer('Bob Smith', 102, 70000, 'Dart', 5);

  print('--- Manager ---');
  manager.displayInfo();
  manager.clockIn();
  manager.manageTeam();
  manager.conductMeeting();
  manager.attendTraining('Leadership Excellence');

  print('\n--- Developer ---');
  developer.displayInfo();
  developer.clockIn();
  developer.writeCode();
  developer.debugCode();
  developer.trackHours(8.5);
  developer.attendTraining('Advanced Dart Programming');

  print('\n--- Polymorphism with Employees ---');
  List<Employee> employees = [manager, developer];

  print('\nAll employees clocking in:');
  for (Employee emp in employees) {
    emp.clockIn();
  }

  print('\nTrainable employees attending training:');
  for (Employee emp in employees) {
    if (emp is Trainable) {
      (emp as Trainable).attendTraining('Company Policies');
    }
  }
}
