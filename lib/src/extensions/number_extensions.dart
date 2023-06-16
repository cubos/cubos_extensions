import 'dart:math' as math;

import 'package:intl/intl.dart';

import 'package:rubik_utils/rubik_utils.dart';

/// This class contains extensions for the `num` class
/// {@tool snippet}
/// ```dart
/// final int money = 1000;
/// money.toReal() // returns 10.0
/// money.toRealWithTwoDecimals() // returns 10.00
/// money.formatToCurrency() // returns R$ 10,00
/// ```
/// {@end-tool}
extension RubikNumberExtension on num {
  /// Returns `true` if the `value` is an integer
  /// {@tool snippet}
  /// ```dart
  /// final int number = 10;
  /// number.isInteger // returns true
  /// ```
  /// {@end-tool}
  bool get isInteger => this is int;

  /// Returns `true` if the `value` is a double
  /// {@tool snippet}
  /// ```dart
  /// final double number = 10.0;
  /// number.isDouble // returns true
  /// ```
  /// {@end-tool}
  bool get isDouble => this is double;

  /// Returns the `value` in cents.
  /// {@tool snippet}
  /// ```dart
  /// final double money = 10.0;
  /// money.toCents() // returns 1000
  /// ```
  /// {@end-tool}
  int get toCents => (this * 100).truncate();

  /// Returns the `value` in real.
  /// The current value will be considered as cents
  /// {@tool snippet}
  /// ```dart
  /// final int money = 1000;
  /// money.toReal() // returns 10.0
  /// ```
  /// {@end-tool}
  double get toReal => (this / 100);

  /// Returns the `value` in with two decimals.
  /// {@tool snippet}
  /// ```dart
  /// final int money = 1000;
  /// money.toRealWithTwoDecimals() // returns 10.00
  /// ```
  /// {@end-tool}
  double toTwoDecimals({int? fractionDigits}) {
    return double.parse(toStringAsFixed(fractionDigits ?? 2));
  }

  /// Return the `value` in currency format
  /// {@tool snippet}
  /// ```dart
  /// 10.formatToCurrency() // returns R$ 10,00
  /// money.formatToCurrency(symbol: '€') // returns €1.23
  /// ```
  /// {@end-tool}
  String formatToCurrency({
    int? decimalDigits,
    bool normalizedConvertion = true,
    String locale = RubikStrings.defaultLocale,
    String symbol = RubikStrings.defaultCurrencySymbol,
  }) {
    final formatted = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(this);

    if (!normalizedConvertion) return formatted;

    return formatted.noNBSP.replaceAll(String.fromCharCode(0x2019), ',');
  }

  /// Returns the `value` as a percentage string with `decimalPlaces` number of decimal places.
  /// {@tool snippet}
  /// ```dart
  /// 0.55.toPercentage() // returns "55,0%"
  /// 45.56.toPercentage(decimalPlaces: 2) // returns "45,56%"
  /// 89.toPercentage(decimalPlaces: 0) // returns "89%"
  /// 3.5.toPercentage(separator: PercentageSeparator.dot) // returns "3.5%"
  /// ```
  /// {@end-tool}
  String toPercentage({
    int decimalPlaces = 1,
    RubikNumberSeparator separator = RubikNumberSeparator.comma,
  }) {
    final formatted = NumberFormat.percentPattern()
      ..minimumFractionDigits = decimalPlaces
      ..maximumFractionDigits = decimalPlaces;

    return separator.resolva(formatted.format(this / 100));
  }

  /// Convert the `value` to real and return in currency format
  /// The current value will be considered as cents
  /// {@tool snippet}
  /// ```dart
  /// 1345.toRealWithFormatting() // returns R$ 13,45
  /// ```
  /// {@end-tool}
  String toRealWithFormatting({
    String symbol = RubikStrings.defaultCurrencySymbol,
  }) {
    return toReal.formatToCurrency(symbol: symbol);
  }

  /// Returns `true` if current value no have decimal.
  /// {@tool snippet}
  /// ```dart
  /// 10.hasDecimal // returns false
  /// 10.5.hasDecimal // returns true
  /// ```
  /// {@end-tool}
  bool get hasDecimal => this != toInt();

  /// Returns `true` if current value is less than `other`.
  /// {@tool snippet}
  /// ```dart
  /// 10.lessThan(5) // returns true
  /// 10.lessThan(20) // returns false
  /// 10.lessThan(10, needToBeEqual: true) // returns true
  /// ```
  /// {@end-tool}
  bool lessThan(num other, {bool needToBeEqual = false}) {
    return needToBeEqual ? this <= other : this < other;
  }

  /// Returns `true` if current value is between `min` and `max`.
  /// {@tool snippet}
  /// ```dart
  /// 10.isBetween(5, 20) // returns true
  /// 10.isBetween(5, 10) // returns false
  /// 25.isBetween(50, 5) // returns true
  /// 45.isBetween(15, 2) // returns false
  /// 10.isBetween(5, 10, needToBeEqual: true) // returns true
  /// ```
  /// {@end-tool}
  bool isBetween(num min, num max, {bool needToBeEqual = false}) {
    if (max < min) {
      return needToBeEqual
          ? this >= max && this <= min
          : this > max && this < min;
    }

    return needToBeEqual
        ? this >= min && this <= max
        : this > min && this < max;
  }

  /// Returns `true` if current value is greater than `other`.
  /// {@tool snippet}
  /// ```dart
  /// 10.greaterThan(5) // returns true
  /// 10.greaterThan(10) // returns false
  /// 10.greaterThan(10, needToBeEqual: true) // returns true
  /// ```
  /// {@end-tool}
  bool greaterThan(num other, {bool needToBeEqual = false}) {
    return needToBeEqual ? this >= other : this > other;
  }

  /// Returns the `value` raised to the power of `exponent`.
  /// {@tool snippet}
  /// ```dart
  /// final double base = 2.0;
  /// final double exponent = 3.0;
  /// base.pow(exponent) // returns 8.0
  /// ```
  /// {@end-tool}
  num pow(num exponent) => math.pow(this, exponent);

  /// Returns the `value` in radians.
  /// {@tool snippet}
  /// ```dart
  /// final double radians = 3.141592653589793;
  /// radians.toDegrees // returns 180.0
  /// ```
  /// {@end-tool}
  num get toDegrees => (this * 180) / math.pi;

  /// Returns the `value` in degrees.
  /// {@tool snippet}
  /// ```dart
  /// final double degrees = 180.0;
  /// radians.toRadians // returns  3.141592653589793;
  /// ```
  /// {@end-tool}
  num get toRadians => this * (math.pi / 180);

  /// Rounds the `current value` to the nearest given number.
  /// {@tool snippet}
  /// ```dart
  /// final double number = 10.5;
  /// number.roundToNearest(5) // returns 10
  /// ```
  /// {@end-tool}
  num roundToNearest(num nearest) {
    final remainder = this % nearest;

    return remainder < nearest / 2
        ? this - remainder
        : this + nearest - remainder;
  }

  /// Return new string with padding of zero on the left added
  /// {@tool snippet}
  /// ```dart
  /// final String number = 23;
  /// number.padLeft(4, '0') // returns '0023'
  /// ```
  /// {@end-tool}
  String padLeft({int width = 2, String padding = '0'}) {
    return toString().padLeft(width, padding);
  }

  /// Return new string with padding of zero on the right added
  /// {@tool snippet}
  /// ```dart
  /// final String number = 23;
  /// number.padRight(4, '0') // returns '2300'
  /// ```
  /// {@end-tool}
  String padRight({int width = 2, String padding = '0'}) {
    return toString().padRight(width, padding);
  }

  /// Returns `true` if the number is equal to zero.
  /// {@tool snippet}
  /// ```dart
  /// final double number = 0.0;
  /// number.isZero // returns true
  /// ```
  /// {@end-tool}
  bool get isZero => this == 0;

  /// Converts the `value` to a `Duration` in milliseconds.
  /// Or you can pass a [RubikTimeUnit] to convert to another unit.
  /// {@tool snippet}
  /// ```dart
  /// final int number = 1000;
  /// number.toDuration() // returns Duration(milliseconds: 1000)
  /// ```
  /// {@end-tool}
  Duration toDuration({
    int? microseconds,
    RubikTimeUnit unit = RubikTimeUnit.milliseconds,
  }) {
    final int duration = microseconds ?? toInt();

    final convertion = <RubikTimeUnit, Duration>{
      RubikTimeUnit.days: Duration(days: duration),
      RubikTimeUnit.hours: Duration(hours: duration),
      RubikTimeUnit.minutes: Duration(minutes: duration),
      RubikTimeUnit.seconds: Duration(seconds: duration),
      RubikTimeUnit.milliseconds: Duration(milliseconds: duration),
      RubikTimeUnit.microseconds: Duration(microseconds: duration),
    };

    return convertion[unit]!;
  }

  /// Converts the `value` to a `Duration` in milliseconds.
  /// {@tool snippet}
  /// ```dart
  /// 200.microseconds // equivalent to Duration(microseconds: 200)
  /// 300.us // equivalent to Duration(microseconds: 300)
  /// ```
  /// {@end-tool}
  Duration get microseconds {
    return toDuration(microseconds: round(), unit: RubikTimeUnit.microseconds);
  }

  /// Converts the `value` to a `Duration` in milliseconds.
  /// {@tool snippet}
  /// ```dart
  /// 200.microseconds // equivalent to Duration(microseconds: 200)
  /// 300.us // equivalent to Duration(microseconds: 300)
  /// ```
  /// {@end-tool}
  Duration get us => microseconds;

  /// Converts the `value` to a `Duration` in milliseconds.
  /// {@tool snippet}
  /// ```dart
  /// 200.milliseconds // equivalent to Duration(milliseconds: 200)
  /// 300.ms // equivalent to Duration(milliseconds: 300)
  /// ```
  /// {@end-tool}
  Duration get milliseconds => (this * 1000).microseconds;

  /// Converts the `value` to a `Duration` in milliseconds.
  /// {@tool snippet}
  /// ```dart
  /// 200.ms // equivalent to Duration(milliseconds: 200)
  /// 300.milliseconds // equivalent to Duration(milliseconds: 300)
  /// ```
  /// {@end-tool}
  Duration get ms => milliseconds;

  /// Converts the `value` to a `Duration` in seconds.
  /// {@tool snippet}
  /// ```dart
  /// 3.seconds // equivalent to Duration(milliseconds: 3000)
  /// 3.s // equivalent to Duration(milliseconds: 3000)
  /// ```
  /// {@end-tool}
  Duration get seconds => (this * 1000 * 1000).microseconds;

  /// Converts the `value` to a `Duration` in milliseconds.
  /// {@tool snippet}
  /// ```dart
  /// 3.s // equivalent to Duration(milliseconds: 3000)
  /// 3.seconds // equivalent to Duration(milliseconds: 3000)
  /// ```
  /// {@end-tool}
  Duration get s => seconds;

  /// Converts the `value` to a `Duration` in milliseconds.
  /// {@tool snippet}
  /// ```dart
  /// 7.minutes // equivalent to Duration(milliseconds: 420000)
  /// 3.min // equivalent to Duration(milliseconds: 180000)
  /// ```
  /// {@end-tool}
  Duration get minutes => (this * 1000 * 1000 * 60).microseconds;

  /// Converts the `value` to a `Duration` in minutes.
  /// {@tool snippet}
  /// ```dart
  /// 3.min // equivalent to Duration(milliseconds: 180000)
  /// 7.minutes // equivalent to Duration(milliseconds: 420000)
  /// ```
  /// {@end-tool}
  Duration get min => minutes;

  /// Converts the `value` to a `Duration` in hours.
  /// {@tool snippet}
  /// ```dart
  /// 3.h // equivalent to Duration(milliseconds: 10800000)
  /// 4.9.hours // equivalent to Duration(milliseconds: 17640000)
  /// ```
  /// {@end-tool}
  Duration get hours => (this * 1000 * 1000 * 60 * 60).microseconds;

  /// Converts the `value` to a `Duration` in hours.
  /// {@tool snippet}
  /// ```dart
  /// 3.h // equivalent to Duration(milliseconds: 10800000)
  /// 4.9.hours // equivalent to Duration(milliseconds: 17640000)
  /// ```
  /// {@end-tool}
  Duration get h => hours;

  /// Converts the `value` to a `Duration` in days.
  /// {@tool snippet}
  /// ```dart
  /// 1.5.days // equivalent to Duration(hours: 36)
  /// 2.4.d // equivalent to Duration(hours: 57)
  /// ```
  /// {@end-tool}
  Duration get days => (this * 1000 * 1000 * 60 * 60 * 24).microseconds;

  /// Converts the `value` to a `Duration` in days.
  /// {@tool snippet}
  /// ```dart
  /// 2.4.d // equivalent to Duration(hours: 57)
  /// 1.5.days // equivalent to Duration(hours: 36)
  /// ```
  /// {@end-tool}
  Duration get d => days;

  /// Converts the `value` to a [DateTime] in milliseconds.
  /// {@tool snippet}
  /// ```dart
  /// final int milliSeconds = 1680553191711;
  /// number.toDateTime // returns DateTime(2023, 4, 5, 7, 13, 11, 711)
  /// ```
  /// {@end-tool}
  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(toInt());
}
