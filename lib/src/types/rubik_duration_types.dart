/// The unit of time used in `RubikDuration`.
/// {@tool snippet}
/// ```dart
/// RubikTimeUnit.days // returns 'days'
/// RubikTimeUnit.hours // returns 'hours'
/// RubikTimeUnit.minutes // returns 'minutes'
/// ```
/// {@end-tool}
enum RubikTimeUnit {
  days,
  hours,
  minutes,
  seconds,
  microseconds,
  milliseconds;

  factory RubikTimeUnit.fromString(String value) {
    final types = {
      'days': RubikTimeUnit.days,
      'hours': RubikTimeUnit.hours,
      'minutes': RubikTimeUnit.minutes,
      'seconds': RubikTimeUnit.seconds,
      'microseconds': RubikTimeUnit.microseconds,
      'milliseconds': RubikTimeUnit.milliseconds,
    };

    return types[value] ?? RubikTimeUnit.milliseconds;
  }

  /// Returns `true` if the current value is `RubikTimeUnit.days`.
  /// {@tool snippet}
  /// ```dart
  /// RubikTimeUnit.days.isDays // returns true
  /// RubikTimeUnit.hours.isDays // returns false
  /// ```
  /// {@end-tool}
  bool get isDays => this == RubikTimeUnit.days;

  /// Returns `true` if the current value is `RubikTimeUnit.hours`.
  bool get isHours => this == RubikTimeUnit.hours;

  /// Returns `true` if the current value is `RubikTimeUnit.minutes`.
  bool get isMinutes => this == RubikTimeUnit.minutes;

  /// Returns `true` if the current value is `RubikTimeUnit.seconds`.
  bool get isSeconds => this == RubikTimeUnit.seconds;

  /// Returns `true` if the current value is `RubikTimeUnit.microseconds`.
  bool get isMicroseconds => this == RubikTimeUnit.microseconds;

  /// Returns `true` if the current value is `RubikTimeUnit.milliseconds`.
  bool get isMilliseconds => this == RubikTimeUnit.milliseconds;
}
