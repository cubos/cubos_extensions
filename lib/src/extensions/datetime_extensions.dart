import 'package:rubik_utils/rubik_utils.dart';

/// This extension provides methods to manipulate `dates`.
/// {@tool snippet}
/// ```dart
/// final date = DateTime(2023, 03, 13);
/// date.toDateTimeStr // returns '13/03/2023'
/// ```
/// {@end-tool}
extension RubikDatetimeExtensions on DateTime {
  /// Return the `day` in string format.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.dayStr // returns '13'
  /// ```
  /// {@end-tool}
  String get dayStr => day.padLeft();

  /// Return the `month` in string format.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.monthStr // returns '03'
  /// ```
  /// {@end-tool}
  String get monthStr => month.padLeft();

  /// Return the `year` in string format.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.yearStr // returns '2023'
  /// ```
  /// {@end-tool}
  String get yearStr => year.padLeft(width: 4, padding: '0');

  /// Returns the `hour` in string format.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15, 30);
  /// date.hourStr // returns '15'
  /// ```
  /// {@end-tool}
  String get hourStr => hour.padLeft();

  /// Returns the `minute` in string format.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15, 30);
  /// date.minuteStr // returns '30'
  /// ```
  /// {@end-tool}
  String get minuteStr => minute.padLeft();

  /// Returns the `second` in string format.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15, 30, 45);
  /// date.secondStr // returns '45'
  /// ```
  /// {@end-tool}
  String get secondStr => second.padLeft();

  /// Returns the date in `dd/mm/yyyy` format.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.toDateTimeStr // returns '13/03/2023'
  /// ```
  /// {@end-tool}
  String get toDateTimeStr => '$dayStr/$monthStr/$yearStr';

  /// Returns the date in `yyyy/mm/dd` format.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.toIsoStr // returns '2023-03-13'
  /// ```
  /// {@end-tool}
  String get toIsoStr => '$yearStr-$monthStr-$dayStr';

  /// Returns new date subtracting the `year` from the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.subtractYears(3) // returns DateTime(2020, 03, 12)
  /// ```
  /// {@end-tool}
  DateTime subtractYears(int years) => DateTime(year - years, month, day);

  /// Returns new date subtracting the `month` from the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 08, 13);
  /// date.subtractMonths(3) // returns DateTime(2023, 05, 13)
  /// ```
  /// {@end-tool}
  DateTime subtractMonths(int months) => subtract(Duration(days: months * 30));

  /// Returns new date subtracting the `days` from the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.subtractDays(3) // returns DateTime(2023, 03, 10)
  /// ```
  /// {@end-tool}
  DateTime subtractDays(int days) => subtract(Duration(days: days));

  /// Returns new date subtracting the `hours` from the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15);
  /// date.subtractHours(2) // returns DateTime(2023, 03, 13, 13)
  /// ```
  /// {@end-tool}
  DateTime subtractHours(int hours, {int minutes = 0, int seconds = 0}) {
    return subtract(Duration(hours: hours, minutes: minutes, seconds: seconds));
  }

  /// Returns new date subtracting the `year`, `month` or `day` from the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.subtractDate(years: 3, months: 2, days: 1) // returns DateTime(2020, 01, 12)
  /// ```
  /// {@end-tool}
  DateTime subtractDate({
    int years = 0,
    int months = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
  }) {
    return subtractYears(years)
        .subtractMonths(months)
        .subtractDays(days)
        .subtractHours(hours, minutes: minutes, seconds: seconds);
  }

  /// Returns new date adding the `year` to the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.addYears(3) // returns DateTime(2026, 03, 13)
  /// ```
  /// {@end-tool}
  DateTime addYears(int years) => DateTime(year + years, month, day);

  /// Returns new date adding the `month` to the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.addMonths(3) // returns DateTime(2023, 06, 13)
  /// ```
  /// {@end-tool}
  DateTime addMonths(int months) => add(Duration(days: months * 30));

  /// Returns new date adding the `days` to the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.addDays(3) // returns DateTime(2023, 03, 16)
  /// ```
  /// {@end-tool}
  DateTime addDays(int days) => add(Duration(days: days));

  /// Returns new date adding the `hours` to the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15);
  /// date.addHours(2) // returns DateTime(2023, 03, 13, 17)
  /// date.addHours(2, minutes: 15) // returns DateTime(2023, 03, 13, 17, 15)
  /// ```
  /// {@end-tool}
  DateTime addHours(int hours, {int minutes = 0, int seconds = 0}) {
    return add(Duration(hours: hours, minutes: minutes, seconds: seconds));
  }

  /// Returns new date adding the `year`, `month` or `day` to the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.addDate(years: 3, months: 2, days: 1) // returns DateTime(2026, 05, 14)
  /// ```
  /// {@end-tool}
  DateTime addDate({
    int years = 0,
    int months = 0,
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
  }) {
    return addYears(years)
        .addMonths(months)
        .addDays(days)
        .addHours(hours, minutes: minutes, seconds: seconds);
  }

  /// Return `List<int>` containing the `year`, `month` , `day` and `hour` of the current date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15, 30, 02);
  /// date.toList() // returns [2023, 03, 13, 15, 30, 02]
  ///
  /// date.toList(reverse: true) // returns [13, 03, 2023, 15, 30, 02]
  /// ```
  /// {@end-tool}
  RubikIntegers toList({bool reverse = false}) {
    if (reverse) return [day, month, year, hour, minute, second];

    return [year, month, day, hour, minute, second];
  }

  /// Returns the time in `HH:MM` 24h format.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15, 30, 2);
  /// date.toTimeStr() // returns '15:30'
  /// date.toTimeStr(format: RubikTimeFormat.hhmmss24H) // returns '15:30:02'
  ///
  /// final date2 = DateTime(2023, 03, 13, 14, 45);
  /// date2.toTimeStr(format: RubikTimeFormat.hhmm) // returns '02:45'
  /// ```
  /// {@end-tool}
  String toTimeStr({
    String? hourSuffix,
    RubikTimeFormat format = RubikTimeFormat.hhmm24H,
  }) {
    if (format.is24H()) {
      return format.resolve(
        hourStr,
        minuteStr,
        second: secondStr,
        hourSuffix: hourSuffix,
      );
    }

    final hourInPm = (hour > 12 ? hour - 12 : hour).padLeft();

    return format.resolve(
      hourInPm,
      minuteStr,
      second: secondStr,
      hourSuffix: hourSuffix,
    );
  }

  /// Returns the date and time in `DD/MM/AAAA - HH:MM` format
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15, 30, 2);
  /// date.toDateAndTimeStr(separator: ' às ') // returns '13/03/2023 às 15:30'
  /// date.toDateAndTimeStr(format: RubikTimeFormat.hhmmss24H) // returns '13/03/2023 - 15:30:02'
  /// ```
  /// {@end-tool}
  String toDateAndTimeStr({
    String? hourSuffix,
    String separator = ' - ',
    RubikTimeFormat format = RubikTimeFormat.hhmm24H,
  }) {
    final timeStr = toTimeStr(format: format, hourSuffix: hourSuffix);

    return '$toDateTimeStr$separator$timeStr';
  }

  /// Returns the date and time in `HH:MM - DD/MM/AAAA` format
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15, 30, 2);
  /// date.toTimeAndDateStr(separator: ' às ') // returns '15:30 às 13/03/2023'
  /// date.toTimeAndDateStr(format: RubikTimeFormat.hhmmss24H) // returns '15:30:02 - 13/03/2023'
  /// ```
  /// {@end-tool}
  String toTimeAndDateStr({
    String? hourSuffix,
    String separator = ' - ',
    RubikTimeFormat format = RubikTimeFormat.hhmm24H,
  }) {
    final timeStr = toTimeStr(format: format, hourSuffix: hourSuffix);

    return '$timeStr$separator$toDateTimeStr';
  }

  /// Return the `day` of the week by locale.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.toWeekdayStr() // returns 'Terça'
  /// date.toWeekdayStr(useShortName: true) // returns 'Ter'
  /// date.toWeekdayStr(useAbbreviation: true) // returns 'Terça-feira'
  /// ```
  /// {@end-tool}
  String toWeekdayStr({
    bool useShortName = false,
    bool useAbbreviation = false,
    String locale = RubikStrings.defaultLocale,
  }) {
    final weekdayStr = RubikStrings.weekdaysByLocale(locale: locale)[weekday];
    if (weekdayStr == null) return weekday.padLeft();

    if (useShortName) return weekdayStr.shortName;

    return !useAbbreviation ? weekdayStr.fullName : weekdayStr.toAbbreviation();
  }

  /// Return the `month` of the year by locale.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13);
  /// date.toMonthNameStr() // returns 'Março'
  /// date.toMonthNameStr(useShortName: true) // returns 'Mar'
  /// ```
  /// {@end-tool}
  String toMonthNameStr({
    bool useShortName = false,
    String locale = RubikStrings.defaultLocale,
  }) {
    final monthStr = RubikStrings.monthsByLocale(locale: locale)[month];
    if (monthStr == null) return month.padLeft();

    return useShortName ? monthStr.shortName : monthStr.fullName;
  }

  /// Returns `string` by formatter type.
  /// Locale is used to get the month name
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 13, 15, 30, 2);
  /// date.toFullDateTimeStr() // returns '13/03'
  /// ```
  /// {@end-tool}
  String toFullDateTimeStr({
    String locale = RubikStrings.defaultLocale,
    RubikDayMonthFormat format = RubikDayMonthFormat.ddmm,
  }) {
    if (!format.shouldItMonthName) {
      return format.resolve(dayStr, monthStr, year: yearStr);
    }

    final monthName = toMonthNameStr(
      locale: locale,
      useShortName: format.isShortName,
    );

    final formatted = format.resolve(dayStr, monthName, year: yearStr);
    if (locale == RubikStrings.defaultLocale) return formatted;

    return formatted.replaceAll(' de ', ' ');
  }

  /// Returns `true` if `date` is after `start` and before `end`.
  /// {@tool snippet}
  /// ```dart
  /// final start = DateTime(2023, 03, 13);
  /// final end = DateTime(2023, 03, 24);
  ///
  /// final date = DateTime(2023, 03, 15);
  /// date.isBetween(start, end) // returns true
  /// ```
  /// {@end-tool}
  bool isBetween(
    DateTime start,
    DateTime end, {
    bool invertedInterval = false,
  }) {
    if (invertedInterval) {
      return isBefore(start) && isAfter(end);
    }

    return isAfter(start) && isBefore(end);
  }

  /// Returns true if `this` occurs at the same moment as `other`.
  /// This function, different from the `isAtSameMomentAs` method, does not consider
  /// the `millisecond` and `microsecond`, for cases where the data are exactly the same,
  /// but the `millisecond` or `microsecond` are different
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime.now();
  /// final other = DateTime.now().addDays(1);
  /// date.isSameMomentAs(other) // returns false
  /// ```
  /// {@end-tool}
  bool isSameMomentAs(DateTime other, {Duration tolerance = Duration.zero}) {
    final isSameYear = year == other.year;
    final isSameMonth = month == other.month;
    final isSameDay = day == other.day;
    final isSameHour = hour == other.hour;
    final isSameMinute = minute == other.minute;
    final isSameSecond = second == other.second;
    final isTolerance = difference(other).abs() < tolerance;

    return isTolerance ||
        isSameYear &&
            isSameMonth &&
            isSameDay &&
            isSameHour &&
            isSameMinute &&
            isSameSecond;
  }

  /// Returns `true` if current date is today.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime.now();
  /// date.isToday // returns true
  /// ```
  /// {@end-tool}
  bool get isToday => isSameMomentAs(DateTime.now());

  /// Returns `true` if current date is yesterday.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime.now().subtractDays(1);
  /// date.isYesterday // returns true
  /// ```
  /// {@end-tool}
  bool get isYesterday => isSameMomentAs(DateTime.now().subtractDays(1));

  /// Returns `true` if current date is tomorrow.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime.now().addDays(1);
  /// date.isTomorrow // returns true
  /// ```
  /// {@end-tool}
  bool get isTomorrow => isSameMomentAs(DateTime.now().addDays(1));

  /// Returns `true` if current date is weekend.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 04, 02);
  /// date.isWeekend // returns true
  /// ```
  /// {@end-tool}
  bool get isWeekend => [DateTime.saturday, DateTime.sunday].contains(weekday);

  /// Returns `true` if current date is weekday.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 27);
  /// date.isWeekday // returns true
  /// ```
  /// {@end-tool}
  bool get isWeekday => !isWeekend;

  /// Returns `Duration` of difference of `current Date` and `other` date.
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 27);
  /// final other = DateTime(2023, 03, 28);
  /// date.dateToDuration(other) // returns Duration(days: 1)
  /// ```
  /// {@end-tool}
  Duration dateToDuration(DateTime other, {bool inverted = false}) {
    return inverted ? difference(other) : other.difference(this);
  }

  /// Returns `Duration` converted from `DateTime`.
  /// This conversion is based on the `day`, `hour`, `minute`, `second`, `millisecond`
  /// and `microsecond`, ignoring the `year` and `month`.
  ///
  /// This is useful for cases where you need to convert a `DateTime` to `Duration`
  /// and vice versa.
  ///
  /// {@tool snippet}
  /// ```dart
  /// final date = DateTime(2023, 03, 27);
  /// date.toDuration // returns Duration(days: 27)
  /// ```
  /// {@end-tool}
  Duration get toDuration {
    return Duration(
      days: day,
      hours: hour,
      minutes: minute,
      seconds: second,
      milliseconds: millisecond,
      microseconds: microsecond,
    );
  }
}
