typedef Strings = List<String>;

/// This class is used to define full name and abbreviations of the strings.
/// Used in cases where the name may have a shorter abbreviation
/// or a longer name.
/// {@tool snippet}
/// ```dart
/// final name = RubikStringNames('Rubik', shortName: 'package');
/// name.fullName; // returns 'Rubik'
/// name.shortName; // returns 'package'
/// ```
/// {@end-tool}
class RubikStringNames {
  final String fullName;
  final String shortName;
  final List<String> abbreviations;

  const RubikStringNames(
    this.fullName, {
    this.shortName = '',
    this.abbreviations = const [],
  });

  /// Returns the full name if `short` is `false`, otherwise returns the short name.
  /// {@tool snippet}
  /// ```dart
  /// final name = RubikStringNames('Rubik', shortName: 'package');
  /// name.getValue(); // returns 'Rubik'
  /// name.getValue(short: true); // returns 'package'
  /// ```
  /// {@end-tool}
  String getValue({bool short = false}) => short ? shortName : fullName;

  /// Returns the full name if it is not empty, otherwise returns the short name.
  /// {@tool snippet}
  /// ```dart
  /// final name = RubikStringNames('Rubik', shortName: '');
  /// name.fullNameOrShortName; // returns 'Rubik'
  /// ```
  /// {@end-tool}
  String get fullNameOrShortName => fullName.isEmpty ? shortName : fullName;

  /// Returns the short name if it is not empty, otherwise returns the full name.
  /// {@tool snippet}
  /// ```dart
  /// final name = RubikStringNames('', shortName: 'package');
  /// name.shortNameOrFullName; // returns 'package'
  /// ```
  /// {@end-tool}
  String get shortNameOrFullName => shortName.isEmpty ? fullName : shortName;

  /// Retuns full name and short name separated by a space.
  /// {@tool snippet}
  /// ```dart
  /// final name = RubikStringNames('Rubik', shortName: 'package');
  /// name.fullNameWithSpace; // returns 'Rubik package'
  /// ```
  /// {@end-tool}
  String get joinWithSpace => '$fullName $shortName';

  /// Returns true if the `abbreviations` list is not empty.
  /// {@tool snippet}
  /// ```dart
  /// final name = RubikStringNames('Rubik', shortName: 'package');
  /// name.hasAbbreviations; // returns false
  /// ```
  /// {@end-tool}
  bool get hasAbbreviations => abbreviations.isNotEmpty;

  /// Returns the first abbreviation if it exists, otherwise returns the full name.
  /// {@tool snippet}
  /// ```dart
  /// final name = RubikStringNames('Rubik', abbreviations: ['RubikUtils'] );
  /// name.toAbbreviation(); // returns 'RubikUtils'
  /// ```
  /// {@end-tool}
  String toAbbreviation([int? index]) {
    if (!hasAbbreviations) return fullName;
    final validIndex = index != null && index < abbreviations.length;

    return validIndex ? abbreviations[index] : abbreviations.first;
  }

  @override
  String toString() {
    return 'RubikStringNames(fullName: $fullName, shortName: $shortName, abbreviations: $abbreviations)';
  }
}

class RubikRange {
  final int end;
  final int start;
  final String mask;

  const RubikRange.empty() : this();
  const RubikRange({this.start = 0, this.end = 0, this.mask = ''});

  bool get isEmpty => start == 0 && end == 0;

  bool isValid(int max) => start <= max && end <= max;
}
