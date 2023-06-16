import 'package:rubik_utils/rubik_utils.dart';

/// This enum is used to define the format of the time.
/// The default value is `RubikTimeFormat.hhmm`.
/// {@tool snippet}
/// ```dart
/// RubikTimeFormat.hhmm // returns 'hh:mm'
/// RubikTimeFormat.hhmmss // returns 'hh:mm:ss'
/// ```
/// {@end-tool}
enum RubikTimeFormat {
  /// Returns the time in `hh:mm` format.
  hhmm,

  /// Returns the time in `hh:mm` format  in 24h.
  hhmm24H,

  /// Returns the time in `hh:mm:ss` format.
  hhmmss,

  /// Returns the time in `hh:mm:ss` format in 24h.
  hhmmss24H;

  /// Returns `true` if the format is `hh:mm:ss` in 24h format.
  bool get isHHMM24H => this == RubikTimeFormat.hhmm24H;

  /// Returns  `true` if the format is `hh:mm:ss` in 24h format.
  bool get isHHMMSS24H => this == RubikTimeFormat.hhmmss24H;

  /// Returns `true` if the format is `hh:mm`.
  bool get isHHMM => this == RubikTimeFormat.hhmm;

  /// Returns `true` if the format is `hh:mm:ss`.
  bool get isHHMMSS => this == RubikTimeFormat.hhmmss;

  /// Returns `true` if the format is 24h format.
  bool is24H() => isHHMM24H || isHHMMSS24H;

  /// Returns new value with the format defined in [RubikTimeFormat].
  /// {@tool snippet}
  /// ```dart
  /// RubikTimeFormat.hhmm.resolve('15', '30') // returns '03:30'
  /// RubikTimeFormat.hhmm24h.resolve('15', '30') // returns '15:30'
  /// RubikTimeFormat.hhmmss.resolve('15', '30', '45') // returns '03:30:45'
  /// ```
  /// {@end-tool}
  String resolve(
    String hour,
    String minute, {
    String? second,
    String? hourSuffix,
  }) {
    final handleFormat = {
      RubikTimeFormat.hhmm: '$hour${hourSuffix ?? ''}:$minute',
      RubikTimeFormat.hhmm24H: '$hour${hourSuffix ?? ''}:$minute',
      RubikTimeFormat.hhmmss: '$hour${hourSuffix ?? ''}:$minute:$second',
      RubikTimeFormat.hhmmss24H: '$hour${hourSuffix ?? ''}:$minute:$second',
    };

    return handleFormat[this]!;
  }
}

/// This enum is used to define the format of the date.
/// {@tool snippet}
/// ```dart
/// RubikDateFormat.ddmm // returns 'dd/mm'
/// RubikDateFormat.ddMM // returns 'dd-MM'
/// ```
/// {@end-tool}
enum RubikDayMonthFormat {
  /// Returns the `dd/MM` format. For example, "28/03".
  ddmm('dd/MM'),

  /// Returns the `dd-MM` format. For example, "28-03".
  ddMM('dd-MM'),

  /// Returns `dd/mmm` format. For example, "28/Jan".
  ddmmm('dd/mmm'),

  /// Returns `dd de MMM` format. For example, "28 de Janeiro".
  ddMMM('dd de MMM'),

  /// Returns `mm dd, yyyy` format. For example, "Jan 28, 2023".
  ddmmyyyy('MM dd, yyyy'),

  /// Returns `mmm dd, yyyy` format. For example, "Janeiro 28, 2023".
  ddMMyyyy('MMM dd, yyyy'),

  /// Returns `dd/mmm/yyyy` format. For example, "28/Jan/2023".
  ddmmmyyyy('dd/mmm/yyyy'),

  /// Returns `dd de mmm de yyyy` format. For example, "28 de Janeiro de 2023".
  ddMMMyyyy('dd de MMM de yyyy');

  final String format;
  const RubikDayMonthFormat(this.format);

  /// Returns `true` if the need to use the month name.
  /// {@tool snippet}
  /// ```dart
  /// RubikDayMonthFormat.ddmm.shouldItMonthName // returns false
  /// RubikDayMonthFormat.ddmmm.shouldItMonthName // returns true
  /// ```
  /// {@end-tool}
  bool get shouldItMonthName => ![ddmm, ddMM].contains(this);

  /// Returns `true` if month name is short.
  bool get isShortName => [ddmmm, ddmmyyyy, ddmmmyyyy].contains(this);

  /// Returns new value with the format defined in [RubikDayMonthFormat].
  /// {@tool snippet}
  /// ```dart
  /// RubikDayMonthFormat.ddmm.resolve('28', '03') // returns '28/03'
  /// RubikDayMonthFormat.ddmmm.resolve('28', 'Jan') // returns '28/Jan'
  /// RubikDayMonthFormat.ddmmmyyyy.resolve('28', 'Jan', '2023') // returns '28/Jan/2023'
  /// ```
  /// {@end-tool}
  String resolve(String day, String month, {String? year}) {
    final firstReplace = format.replaceAllMapped(
      RubikRegExps.dayAndMonthRegex,
      (match) {
        switch (match.group(0)) {
          case 'dd':
            return day;
          case 'mmm':
            return month;
          case 'MMM':
            return month;
          default:
            return year ?? '';
        }
      },
    );

    return firstReplace.replaceAll('mm', month).replaceAll('MM', month);
  }
}
