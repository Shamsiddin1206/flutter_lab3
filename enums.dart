enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }
 
void problem2() {
  print('--- Problem 2 ---');
  for (final day in Day.values) {
    print('${day.index}: ${day.name}');
  }
  print(Day.values.length); 
}

// task 3
enum NetworkStatus { loading, success, error }
 
String statusText(NetworkStatus status) => switch (status) {
  NetworkStatus.loading => 'Loading, please wait...',
  NetworkStatus.success => 'Done!',
  NetworkStatus.error => 'Something went wrong',
};
 
void problem3() {
  print('--- Problem 3 ---');
  for (final s in NetworkStatus.values) {
    print('${s.name} -> ${statusText(s)}');
  }
}

// task 4
abstract interface class Discountable {
  // Returns price after the discount.
  double apply(double price);
}
 
enum MemberLevel implements Discountable {
  basic(0),
  silver(0.1),
  gold(0.2);
 
  // Discount rate: 0.1 means 10% off.
  final double rate;
 
  const MemberLevel(this.rate);
 
  @override
  double apply(double price) => price * (1 - rate);
 
  String get label => '${name.toUpperCase()} (${(rate * 100).round()}% off)';
}
 
void problem4() {
  print('--- Problem 4 ---');
  for (final level in MemberLevel.values) {
    print('${level.label}: 100 -> ${level.apply(100)}');
  }

  Discountable d = MemberLevel.gold;
  print(d.apply(50)); // 40.0
}