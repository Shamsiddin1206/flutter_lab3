class Point {
  final double x, y;
 
  const Point(this.x, this.y);
 
  // Named constructor with an initializer list.
  Point.origin() : x = 0, y = 0;
 
  // Factory constructor: can run logic and return an object.
  factory Point.fromJson(Map<String, double> json) =>
      Point(json['x'] ?? 0, json['y'] ?? 0);
 
  @override
  String toString() => 'Point($x, $y)';
}

// Task 2
class Person {
  String name;
  int age;
 
  // Standard constructor using "this." shorthand (assigns the fields).
  Person(this.name, this.age);
 
  @override
  String toString() => 'Person($name, $age)';
}

// Task 3
class Student {
  final String name;
  final int age;
 
  // The part after ":" is the initializer list. It runs before the
  // constructor body, so we can validate values while assigning them.
  Student(String name, int age)
    : name = _checkName(name),
      age = _checkAge(age);

  static String _checkName(String value) {
    if (value.trim().isEmpty) throw ArgumentError('Name cannot be empty');
    return value;
  }
 
  static int _checkAge(int value) {
    if (value < 0 || value > 150) {
      throw ArgumentError('Age must be between 0 and 150, got $value');
    }
    return value;
  }
}

// task 4
class AppConfig {
  static final AppConfig _instance = AppConfig._internal();
 
  AppConfig._internal();
 
  factory AppConfig() => _instance;
 
  String appName = 'MyApp';
}