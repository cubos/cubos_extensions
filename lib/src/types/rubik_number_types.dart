import '../constants/index.dart';

/// This enum is used to define the separator of the percentage.
/// The default value used is `RubikNumberSeparator.dot`.
/// {@tool snippet}
/// ```dart
/// RubikNumberSeparator.dot // returns '.'
/// RubikNumberSeparator.comma // returns ','
/// ```
/// {@end-tool}
enum RubikNumberSeparator {
  dot('.'),
  comma(',');

  /// Returns new value with the separator defined in [RubikNumberSeparator].
  /// {@tool snippet}
  /// ```dart
  /// RubikNumberSeparator.dot.resolva('3.5') // returns '3.5'
  /// RubikNumberSeparator.comma.resolva('3.5') // returns '3,5'
  /// ```
  /// {@end-tool}
  String resolva(String value) {
    return value.replaceAll(RubikRegExps.dotAndCommaRegex, type);
  }

  final String type;
  const RubikNumberSeparator(this.type);
}
