import 'dart:math';

/// Returns the average of three numbers [a], [b] and [c].
double average(double a, double b, double c) {
  /*
   * The average formula:
   *
   *   average = (a + b + c) / 3
   *
   * Example: (2 + 4 + 6) / 3 = 12 / 3 = 4
   */

  // Step 1: add all the values together
  final sum = a + b + c;

  // Step 2: divide by how many values there are (3)
  return sum / 3;
}

void problem2() {
  print('--- Problem 2 ---');
  print(average(2, 4, 6)); 
}

// ----------------------------

class Validator {
  /// Private constructor prevents instantiation: this is a utility class.
  Validator._();
 
  /// Checks whether [email] has a valid basic email format.
  ///
  /// The [email] parameter is the string to check. Leading and trailing
  /// whitespace is ignored.
  ///
  /// Returns `true` if [email] looks like `name@domain.tld`, otherwise
  /// `false`. This method never throws.
  static bool isValidEmail(String email) {
    final pattern = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    return pattern.hasMatch(email.trim());
  }
 
  /// Checks whether [value] lies between [min] and [max], inclusive.
  ///
  /// Returns `true` if `min <= value <= max`, otherwise `false`.
  ///
  /// Throws an [ArgumentError] if [min] is greater than [max].
  static bool isInRange(num value, num min, num max) {
    if (min > max) {
      throw ArgumentError('min ($min) must not be greater than max ($max)');
    }
    return value >= min && value <= max;
  }
}
 
void problem3() {
  print('--- Problem 3 ---');
  print(Validator.isValidEmail('a@b.com')); // true
  print(Validator.isValidEmail('nope')); // false
  print(Validator.isInRange(5, 1, 10)); // true
}

//----------------------------------------

/// Calculates the total price of an order including tax.
///
/// **Important:** [taxRate] must be a decimal, not a percent.
///
/// Rules:
/// * Prices are in USD.
/// * A [taxRate] of `0.1` means 10%.
/// * A [taxRate] of `0` means no tax.
///
/// Example:
///
/// ```dart
/// final total = totalWithTax(100, 0.1);
/// print(total); // 110.0
/// ```
double totalWithTax(double price, double taxRate) {
  return price * (1 + taxRate);
}
 
void problem4() {
  print('--- Problem 4 ---');
  print(totalWithTax(100, 0.1)); // ~110.0
}
