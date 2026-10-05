class Vehicle {
    final String brand ;
    Vehicle ( this . brand );
    void start () => print ('$brand starting ...');
}

class ElectricCar extends Vehicle {
  final int batteryCapacity;
 
  // ": super(brand)" calls the parent constructor.
  ElectricCar(String brand, this.batteryCapacity) : super(brand);
 
  @override
  void start() {
    super.start(); // run the parent version first
    print('Battery level: $batteryCapacity kWh');
  }
}

class Animal {
  final String name;
  Animal(this.name);
 
  void makeSound() => print('$name makes a sound');
}
 
class Dog extends Animal {
  Dog(super.name);
 
  @override
  void makeSound() => print('$name says: Woof!');
}
 
class Cat extends Animal {
  Cat(super.name);
 
  @override
  void makeSound() => print('$name says: Meow!');
}

void problem2() {
  print('--- Problem 2 ---');
  Animal(  'Generic').makeSound(); 
  Dog('Rex').makeSound(); 
 
  final List<Animal> animals = [Dog('Rex'), Cat('Tom'), Animal('Bird')];
  for (final a in animals) {
    a.makeSound();
  }
}

// task 3
class ElectricCarShort extends Vehicle {
  final int batteryCapacity;
 
  // "super.brand" forwards the value straight to Vehicle(brand).
  ElectricCarShort(super.brand, this.batteryCapacity);
}
 
class Truck extends Vehicle {
  final int loadTons;
 
  // Positional super parameter + our own named parameter with a default.
  Truck(super.brand, {this.loadTons = 10});
}

void problem3() {
  print('--- Problem 3 ---');
  final car = ElectricCarShort('Nissan', 40);
  print('${car.brand}, ${car.batteryCapacity} kWh'); 
 
  final truck = Truck('Volvo', loadTons: 25);
  print('${truck.brand}, ${truck.loadTons} tons'); 
  print(Truck('MAN').loadTons); 
}


// task 4
class Shape {
  final String name;
  Shape(this.name);
 
  double area() => 0;
  String describe() => '$name with area ${area()}';
}
 
class Polygon extends Shape {
  final int sides;
  Polygon(super.name, this.sides);
 
  @override
  String describe() => '${super.describe()} and $sides sides';
}
 
class Triangle extends Polygon {
  final double base;
  final double height;
 
  Triangle(this.base, this.height) : super('Triangle', 3);
 
  @override
  double area() => 0.5 * base * height;
}

void problem4() {
  print('--- Problem 4 ---');
  final t = Triangle(4, 3);
  print(t.describe()); 
  print(t is Polygon); 
  print(t is Shape); 
  Shape s = t; 
  print(s.area()); 
}