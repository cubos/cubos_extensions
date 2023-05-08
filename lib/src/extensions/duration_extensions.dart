import 'package:rubik_utils/rubik_utils.dart';

/// This extension adds some useful methods to the `Duration` class.
/// {@tool snippet}
/// ```dart
/// final duration = Duration(seconds: 10);
/// duration.toTimeStr // returns '00:00:10'
/// ```
/// {@end-tool}
extension RubikDurationExtensions on Duration {
  /// Returns `days` in string.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(days: 10);
  /// duration.dayStr() // returns '10'
  /// duration.dayStr(separator: ' days') // returns '10 days'
  /// ```
  /// {@end-tool}
  String dayStr({String? separator}) =>
      '${abs().inDays.padLeft()}${separator ?? ''}';

  /// Returns `hours` in string.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(hours: 10);
  /// duration.hourStr() // returns '10'
  /// duration.hourStr(separator: ' hours') // returns '10 hours'
  /// ```
  /// {@end-tool}
  String hourStr({String? separator, bool remainder = false}) {
    final inHoursStr =
        remainder ? inHours.remainder(Duration.hoursPerDay) : inHours;

    return '${inHoursStr.padLeft()}${separator ?? ''}';
  }

  /// Returns `minutes` in string.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(minutes: 10);
  /// duration.minuteStr() // returns '10'
  /// duration.minuteStr(separator: ' minutes') // returns '10 minutes'
  /// ```
  /// {@end-tool}
  String minuteStr({String? separator, bool remainder = false}) {
    final inMinutesStr =
        remainder ? inMinutes.remainder(Duration.secondsPerMinute) : inMinutes;

    return '${inMinutesStr.padLeft()}${separator ?? ''}';
  }

  /// Returns `seconds` in string.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(seconds: 10);
  /// duration.secondStr() // returns '10'
  /// duration.secondStr(separator: ' seconds') // returns '10 seconds'
  /// ```
  /// {@end-tool}
  String secondStr({String? separator, bool remainder = false}) {
    final inSecondsStr =
        remainder ? inSeconds.remainder(Duration.secondsPerMinute) : inSeconds;

    return '${inSecondsStr.padLeft()}${separator ?? ''}';
  }

  /// Returns new `Duration` with `hours` added.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(hours: 10);
  /// duration.addHours(2) // returns Duration(hours: 12)
  /// ```
  /// {@end-tool}
  Duration addHours(int hours) => this + Duration(hours: hours);

  /// Returns new `Duration` with `minutes` added.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(minutes: 10);
  /// duration.addMinutes(2) // returns Duration(minutes: 12)
  /// ```
  /// {@end-tool}
  Duration addMinutes(int minutes) => this + Duration(minutes: minutes);

  /// Returns new `Duration` with `seconds` added.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(seconds: 10);
  /// duration.addSeconds(2) // returns Duration(seconds: 12)
  /// ```
  /// {@end-tool}
  Duration addSeconds(int seconds) => this + Duration(seconds: seconds);

  /// Returns new `Duration` with `days`, `hours`, `minutes` and `seconds` added.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(seconds: 10);
  /// duration.add(hours: 2, seconds: 4) // returns Duration(hours: 2, seconds: 14)
  /// ```
  /// {@end-tool}
  Duration add({
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
  }) {
    return this +
        Duration(days: days, hours: hours, minutes: minutes, seconds: seconds);
  }

  /// Returns new `Duration` with `hours` subtracted.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(hours: 10);
  /// duration.subtractHours(2) // returns Duration(hours: 8)
  /// ```
  /// {@end-tool}
  Duration subtractHours(int hours) => this - Duration(hours: hours);

  /// Returns new `Duration` with `minutes` subtracted.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(minutes: 10);
  /// duration.subtractMinutes(2) // returns Duration(minutes: 8)
  /// ```
  /// {@end-tool}
  Duration subtractMinutes(int minutes) => this - Duration(minutes: minutes);

  /// Returns new `Duration` with `seconds` subtracted.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(seconds: 10);
  /// duration.subtractSeconds(2) // returns Duration(seconds: 8)
  /// ```
  /// {@end-tool}
  Duration subtractSeconds(int seconds) => this - Duration(seconds: seconds);

  /// Returns new `Duration` with `days`, `hours`, `minutes` and `seconds` subtracted.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(seconds: 10);
  /// duration.subtract(hours: 2, seconds: 4) // returns Duration(hours: 1, seconds: 6)
  /// ```
  /// {@end-tool}
  Duration subtract({
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
  }) {
    return this -
        Duration(days: days, hours: hours, minutes: minutes, seconds: seconds);
  }

  /// Returns the `number of weeks` in a given number of days.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(days: 90);
  /// duration.toNumberOfWeeks() // returns 12
  /// ```
  /// {@end-tool}
  int get toNumberOfWeeks => (inDays / DateTime.daysPerWeek).floor();

  /// Returns the approximate `number of months`, the function returns the nearest integer.
  /// The approximation is made considering that a month has an average of `30.44` days,
  /// which is the arithmetic mean of the days in the months of the `Gregorian calendar`.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(days: 90);
  /// duration.toNumberOfMonths() // returns 3
  /// ```
  /// {@end-tool}
  int get toNumberOfMonths => (inDays / 30.44).round();

  /// Returns the approximate `number of years`, the function returns the nearest integer.
  /// The approximation is made considering that a year has an average of `365.24` days,
  /// which is the arithmetic mean of the days in the months of the `Gregorian calendar`.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(days: 3650);
  /// duration.toNumberOfYears() // returns 10
  /// ```
  /// {@end-tool}
  int get toNumberOfYears => (inDays / 365.24).round();

  /// Returns the `days` with the `suffix` in the given `locale`.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(days: 10);
  /// duration.daysWithSuffix() // returns '10 d'
  /// duration.daysWithSuffix(useShortSuffix: false) // returns '10 dias'
  /// ```
  /// {@end-tool}
  String daysWithSuffix({
    bool shortSuffix = true,
    bool separeteWithSpace = false,
    String locale = RubikStrings.defaultLocale,
  }) {
    final days = abs().inDays;
    final abbreviated = days == 1 && !shortSuffix;
    final suffixes = RubikStrings.timeSuffixes(locale: locale).first;

    final daySuffix = abbreviated
        ? suffixes.toAbbreviation()
        : suffixes.getValue(short: shortSuffix);

    return dayStr(separator: separeteWithSpace ? ' $daySuffix' : daySuffix);
  }

  /// Returns the `hours` with the `suffix` in the given `locale`.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(hours: 10);
  /// duration.hoursWithSuffix() // returns '10 h'
  /// duration.hoursWithSuffix(useShortSuffix: false) // returns '10 horas'
  /// ```
  /// {@end-tool}
  String hoursWithSuffix({
    bool shortSuffix = true,
    bool separeteWithSpace = false,
    String locale = RubikStrings.defaultLocale,
  }) {
    final hours = inHours.remainder(Duration.hoursPerDay);

    final abbreviated = hours == 1 && !shortSuffix;
    final suffixes = RubikStrings.timeSuffixes(locale: locale)[1];

    final hoursSuffix = abbreviated
        ? suffixes.toAbbreviation()
        : suffixes.getValue(short: shortSuffix);

    return hourStr(
      remainder: true,
      separator: separeteWithSpace ? ' $hoursSuffix' : hoursSuffix,
    );
  }

  /// Returns the `minutes` with the `suffix` in the given `locale`.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(minutes: 10);
  /// duration.minutesWithSuffix() // returns '10min'
  /// duration.minutesWithSuffix(useShortSuffix: false) // returns '10minutos'
  /// ```
  /// {@end-tool}
  String minutesWithSuffix({
    bool shortSuffix = true,
    bool separeteWithSpace = false,
    String locale = RubikStrings.defaultLocale,
  }) {
    final minutes = inMinutes.remainder(Duration.secondsPerMinute);

    final abbreviated = minutes == 1 && !shortSuffix;
    final suffixes = RubikStrings.timeSuffixes(locale: locale)[2];

    final minutesSuffix = abbreviated
        ? suffixes.toAbbreviation()
        : suffixes.getValue(short: shortSuffix);

    return minuteStr(
      remainder: true,
      separator: separeteWithSpace ? ' $minutesSuffix' : minutesSuffix,
    );
  }

  /// Returns the `seconds` with the `suffix` in the given `locale`.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(seconds: 10);
  /// duration.secondsWithSuffix() // returns '10 s'
  /// duration.secondsWithSuffix(useShortSuffix: false) // returns '10 segundos'
  /// ```
  /// {@end-tool}
  String secondsWithSuffix({
    bool shortSuffix = true,
    bool separeteWithSpace = false,
    String locale = RubikStrings.defaultLocale,
  }) {
    final seconds = inSeconds.remainder(Duration.secondsPerMinute);

    final abbreviated = seconds == 1 && !shortSuffix;
    final suffixes = RubikStrings.timeSuffixes(locale: locale)[3];

    final secondsSuffix = abbreviated
        ? suffixes.toAbbreviation()
        : suffixes.getValue(short: shortSuffix);

    return secondStr(
      remainder: true,
      separator: separeteWithSpace ? ' $secondsSuffix' : secondsSuffix,
    );
  }

  /// Returns the `duration` formatted as a `string` in the given `locale`.
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(days: 10, hours: 10, minutes: 10, seconds: 10);
  /// duration.toTimeStr() // returns '10d 10h 10min 10s'
  /// duration.toTimeStr(useShortSuffix: false) // returns '10dias 10horas 10minutos 10segundos'
  /// ```
  /// {@end-tool}
  String toTimeStr({
    String separator = ':',
    bool shortSuffix = true,
    bool separateSuffixWithSpace = false,
    String locale = RubikStrings.defaultLocale,
  }) {
    final List<String> parts = [];

    if (isNegative) parts.add('-');

    if (abs().inDays >= 1) {
      parts.add(daysWithSuffix(
        locale: locale,
        shortSuffix: shortSuffix,
        separeteWithSpace: separateSuffixWithSpace,
      ));
    }

    if (inHours.remainder(Duration.hoursPerDay) > 0) {
      parts.add(hoursWithSuffix(
        locale: locale,
        shortSuffix: shortSuffix,
        separeteWithSpace: separateSuffixWithSpace,
      ));
    }

    if (inMinutes.remainder(Duration.secondsPerMinute) > 0) {
      parts.add(minutesWithSuffix(
        locale: locale,
        shortSuffix: shortSuffix,
        separeteWithSpace: separateSuffixWithSpace,
      ));
    }

    if (inSeconds.remainder(Duration.secondsPerMinute) > 0) {
      parts.add(secondsWithSuffix(
        locale: locale,
        shortSuffix: shortSuffix,
        separeteWithSpace: separateSuffixWithSpace,
      ));
    }

    return parts.isEmpty ? '00:00:00' : parts.join(separator);
  }

  /// Returns `DateTime` converted from `Duration`.
  /// This conversion based on the current date, but you can pass the `year`,
  /// `month` and `day` to convert the `Duration` to a specific date.
  ///
  /// If you pass the `year`, `month` and `day` the `Duration` will be added to
  /// the `DateTime` with the given `year`, `month` and `day`.
  ///
  /// If you don't pass the `year`, `month` and `day` the `Duration` will be
  /// added to the current `DateTime`.
  ///
  /// {@tool snippet}
  /// ```dart
  /// final duration = Duration(days: 1, hours: 15, minutes: 30);
  /// final now = DateTime.now(); // 2023, 03, 29
  ///
  /// duration.toDateTime() // returns DateTime(2023, 03, 30, 15, 30)
  /// ```
  DateTime toDateTime([int? year, int? month, int? day]) {
    final now = DateTime.now();

    return DateTime(
      year ?? now.year,
      month ?? now.month,
      day ?? now.day,
    ).add(this);
  }
}
