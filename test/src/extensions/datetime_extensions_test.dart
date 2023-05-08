import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

import '../../utils/tests_utils.dart';

void main() {
  group('DateTimeExtensions', () {
    group('DateTimeExtensions.date', () {
      final date = DateTime(2023, 3, 2, 2, 8, 45);

      test('should return day in string and with leading zero', () {
        expect(date.dayStr, isNotEmpty);
        expect(date.dayStr, isA<String>());
        expect(date.dayStr, '02');
      });

      test('should return month in string and with leading zero', () {
        expect(date.monthStr, isNotEmpty);
        expect(date.monthStr, isA<String>());
        expect(date.monthStr, '03');
      });

      test('should return year in string and with leading zero', () {
        expect(date.yearStr, isNotEmpty);
        expect(date.yearStr, isA<String>());
        expect(date.yearStr, '2023');
        expect(TestsUtils.getDateTime(23, 3, 2).yearStr, '0023');
      });

      test(
        'should return hour, minute and seconds in string and with leading zero',
        () {
          expect(date.hourStr, isNotEmpty);
          expect(date.hourStr, isA<String>());
          expect(date.hourStr, '02');

          expect(date.minuteStr, isNotEmpty);
          expect(date.minuteStr, isA<String>());
          expect(date.minuteStr, '08');

          expect(date.secondStr, isNotEmpty);
          expect(date.secondStr, isA<String>());
          expect(date.secondStr, '45');
        },
      );
    });

    group('DateTimeExtensions.toDateTimeStr', () {
      test('should convert datetime to dd/MM/yyyy', () {
        final date = DateTime(2023, 03, 13);

        expect(date.toDateTimeStr, isNotEmpty);
        expect(date.toDateTimeStr, isA<String>());
        expect(date.toDateTimeStr, '13/03/2023');
      });
    });

    group('DateTime.toIsoStr', () {
      test('should convert format "yyyy-mm-dd hh:mm:ss" into "yyyy-mm-dd"', () {
        final date = DateTime(2023, 03, 13, 0, 0, 0);

        expect(date.toIsoStr, isNotEmpty);
        expect(date.toIsoStr, isA<String>());
        expect(date.toIsoStr, '2023-03-13');
      });
    });

    group('DateTime.subtractYears', () {
      test('should subtract 10 years returning "2023-03-13 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).subtractYears(10);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2013, 03, 13));
        expect(actual.year, 2013);
      });

      test('should subtract 0 years returning "2023-03-13 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).subtractYears(0);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2023, 03, 13));
        expect(actual.year, 2023);
      });

      test('should subtract 43 years returning "2023-03-13 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).subtractYears(45);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(1978, 03, 13));
        expect(actual.year, 1978);

        final future = TestsUtils.getDateTime(2023, 03, 13).subtractYears(-23);

        expect(future, isA<DateTime>());
        expect(future, TestsUtils.getDateTime(2046, 03, 13));
        expect(future.year, 2046);
      });
    });

    group('DateTime.subtractMonths', () {
      test('should subtract 5 months returning "2023-05-16 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 10, 13).subtractMonths(5);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2023, 05, 16));
        expect(actual.month, 5);
      });

      test('should subtract 43 returning "2023-03-13 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).subtractMonths(45);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2019, 07, 02));
        expect(actual.month, 7);

        final future = DateTime(2023, 03, 13).subtractMonths(-23);

        expect(future, isA<DateTime>());
        expect(future, TestsUtils.getDateTime(2025, 01, 31));
        expect(future.month, 01);
      });
    });

    group('DateTime.subtractDays', () {
      test('should subtract 5 day returning "2023-05-08 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 10, 13).subtractDays(5);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2023, 10, 08));
        expect(actual.day, 08);
      });

      test('should subtract 43 day returning "2023-01-27 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).subtractDays(45);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2023, 01, 27));
        expect(actual.day, 27);

        final future = TestsUtils.getDateTime(2023, 03, 13).subtractDays(-23);

        expect(future, isA<DateTime>());
        expect(future, TestsUtils.getDateTime(2023, 04, 05));
        expect(future.day, 05);
      });
    });

    group('DateTime.subtractHours', () {
      final date = TestsUtils.getDateTime(2023, 10, 13, 15, 45, 20);

      test('should subtract 5 hours returning "2023-10-13 10:45:20"', () {
        final actual = date.subtractHours(5);

        expect(actual, TestsUtils.getDateTime(2023, 10, 13, 10, 45, 20));
        expect(actual.hour, 10);
      });

      test('should subtract 5 minutes returning "2023-10-13 15:30:20"', () {
        final actual = date.subtractHours(0, minutes: 15);

        expect(actual, TestsUtils.getDateTime(2023, 10, 13, 15, 30, 20));
        expect(actual.minute, 30);
      });

      test('should subtract 5 seconds returning "2023-10-13 15:45:05"', () {
        final actual = date.subtractHours(0, seconds: 5);

        expect(actual, TestsUtils.getDateTime(2023, 10, 13, 15, 45, 15));
        expect(actual.second, 15);
      });

      test(
        'should subtract 5 hours, 10 minutes and 5 seconds returning "2023-10-13 10:35:15"',
        () {
          final actual = date.subtractHours(5, minutes: 10, seconds: 5);
          expect(actual, TestsUtils.getDateTime(2023, 10, 13, 10, 35, 15));

          final fullHours = [actual.hour, actual.minute, actual.second];
          expect(fullHours, equals([10, 35, 15]));
        },
      );
    });

    group('DateTime.subtractDate', () {
      test('should subtract and return a new DateTime', () {
        final date = TestsUtils.getDateTime(2023, 03, 20, 15, 45, 20);

        final actual = date.subtractDate(
          years: 5,
          months: 10,
          days: 5,
          hours: 5,
          minutes: 10,
          seconds: 5,
        );

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2017, 05, 18, 18, 49, 55));
        expect(actual.toList(), equals([2017, 05, 18, 18, 49, 55]));
      });
    });

    group('DateTime.addYears', () {
      test('should add 10 years returning "2033-03-13 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).addYears(10);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2033, 03, 13));
        expect(actual.year, 2033);
      });

      test('should add 0 years returning "2023-03-13 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).addYears(0);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2023, 03, 13));
        expect(actual.year, 2023);
      });

      test('should add 43 years returning "2068-03-13 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).addYears(45);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2068, 03, 13));
        expect(actual.year, 2068);

        final future = TestsUtils.getDateTime(2023, 03, 13).addYears(-23);

        expect(future, isA<DateTime>());
        expect(future, TestsUtils.getDateTime(2000, 03, 13));
        expect(future.year, 2000);
      });
    });

    group('DateTime.addMonths', () {
      test('should add 5 months returning "2024-03-11 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 10, 13).addMonths(5);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2024, 03, 11));
        expect(actual.month, 03);
      });

      test('should add 43 returning "2026-11-22 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).addMonths(45);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2026, 11, 22));
        expect(actual.month, 11);

        final future = DateTime(2023, 03, 13).addMonths(-23);

        expect(future, isA<DateTime>());
        expect(future, TestsUtils.getDateTime(2021, 04, 22));
        expect(future.month, 04);
      });
    });

    group('DateTime.addDays', () {
      test('should add 5 day returning "2023-03-18 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).addDays(5);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2023, 03, 18));
        expect(actual.day, 18);
      });

      test('should add 43 day returning "2023-04-27 00:00:00"', () {
        final actual = TestsUtils.getDateTime(2023, 03, 13).addDays(45);

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2023, 04, 27));
        expect(actual.day, 27);

        final future = TestsUtils.getDateTime(2023, 03, 13).addDays(-23);

        expect(future, isA<DateTime>());
        expect(future, TestsUtils.getDateTime(2023, 02, 18));
        expect(future.day, 18);
      });
    });

    group('DateTime.addHours', () {
      final date = TestsUtils.getDateTime(2023, 10, 13, 15, 45, 20);

      test('should add 5 hours returning "2023-10-13 20:45:20"', () {
        final actual = date.addHours(5);

        expect(actual, TestsUtils.getDateTime(2023, 10, 13, 20, 45, 20));
        expect(actual.hour, 20);
      });

      test('should add 15 minutes returning "2023-10-13 16:00:20"', () {
        final actual = date.addHours(0, minutes: 15);

        expect(actual, TestsUtils.getDateTime(2023, 10, 13, 16, 00, 20));
        expect(actual.minute, 0);
      });

      test('should add 15 seconds returning "2023-10-13 15:45:35"', () {
        final actual = date.addHours(0, seconds: 15);

        expect(actual, TestsUtils.getDateTime(2023, 10, 13, 15, 45, 35));
        expect(actual.second, 35);
      });

      test(
        'should add 5 hours, 10 minutes and 5 seconds returning "2023-10-13 20:55:25"',
        () {
          final actual = date.addHours(5, minutes: 10, seconds: 5);
          expect(actual, TestsUtils.getDateTime(2023, 10, 13, 20, 55, 25));

          final fullHours = [actual.hour, actual.minute, actual.second];
          expect(fullHours, equals([20, 55, 25]));
        },
      );
    });

    group('DateTime.addDate', () {
      test('should add and return a new DateTime', () {
        final date = TestsUtils.getDateTime(2023, 03, 20, 15, 45, 20);

        final actual = date.addDate(
          years: 5,
          months: 10,
          days: 5,
          hours: 5,
          minutes: 10,
          seconds: 5,
        );

        expect(actual, isA<DateTime>());
        expect(actual, TestsUtils.getDateTime(2029, 01, 19, 05, 10, 05));
        expect(actual.toList(), equals([2029, 01, 19, 05, 10, 05]));
      });
    });

    group('DateTime.toList', () {
      test('should return a list with parts of date', () {
        final date = TestsUtils.getDateTime(2023, 03, 20, 15, 45, 20);
        final actual = date.toList();

        expect(actual, isA<List<int>>());
        expect(actual, equals([2023, 03, 20, 15, 45, 20]));
      });

      test('should return a list with parts of date reversed', () {
        final date = TestsUtils.getDateTime(2023, 03, 20, 15, 45, 20);
        final actual = date.toList(reverse: true);

        expect(actual, isA<List<int>>());
        expect(actual, equals([20, 03, 2023, 15, 45, 20]));
      });
    });

    group('DateTime.toTimeStr', () {
      final date = DateTime(2023, 03, 15, 15, 30, 45);

      test('should return string this [HH:MM24H, HH:MM:SS24H] format', () {
        expect(date.toTimeStr(), '15:30');
        expect(date.toTimeStr(format: RubikTimeFormat.hhmmss24H), '15:30:45');
      });

      test(
        'should return string this [HH:MM24H, HH:MM:SS24H] format with suffix',
        () {
          const type = RubikTimeFormat.hhmmss24H;
          expect(date.toTimeStr(hourSuffix: 'H'), '15H:30');
          expect(date.toTimeStr(format: type, hourSuffix: 'H'), '15H:30:45');
        },
      );

      test('should return string this [hh:mm, hh:mm:ss] format', () {
        expect(date.toTimeStr(format: RubikTimeFormat.hhmm), '03:30');
        expect(date.toTimeStr(format: RubikTimeFormat.hhmmss), '03:30:45');
      });

      test(
        'should return string this [hh:mm, hh:mm:ss] format with suffix',
        () {
          const hhmm = RubikTimeFormat.hhmm;
          expect(date.toTimeStr(format: hhmm, hourSuffix: 'H'), '03H:30');

          const hhmmss = RubikTimeFormat.hhmmss;
          expect(date.toTimeStr(format: hhmmss, hourSuffix: 'H'), '03H:30:45');
        },
      );
    });

    group('DateTime.toDateAndTimeStr', () {
      test('should return string in DD/MM/AAAA - HH:MM format', () {
        final date = DateTime(2023, 03, 15, 15, 30, 45);
        expect(date.toDateAndTimeStr(), '15/03/2023 - 15:30');

        final result = date.toDateAndTimeStr(separator: ' às ');
        expect(result, '15/03/2023 às 15:30');

        const format = RubikTimeFormat.hhmmss24H;
        final result2 = date.toDateAndTimeStr(hourSuffix: 'h', format: format);
        expect(result2, '15/03/2023 - 15h:30:45');

        const format2 = RubikTimeFormat.hhmmss;
        final result3 = date.toDateAndTimeStr(hourSuffix: 'h', format: format2);
        expect(result3, '15/03/2023 - 03h:30:45');
      });
    });

    group('DateTime.toTimeAndDateStr', () {
      test('should return string in HH:MM - DD/MM/AAAA format', () {
        final date = DateTime(2023, 03, 15, 15, 30, 45);
        expect(date.toTimeAndDateStr(), '15:30 - 15/03/2023');

        final result = date.toTimeAndDateStr(separator: ' às ');
        expect(result, '15:30 às 15/03/2023');

        const format = RubikTimeFormat.hhmmss24H;
        final result2 = date.toTimeAndDateStr(hourSuffix: 'h', format: format);
        expect(result2, '15h:30:45 - 15/03/2023');

        const format2 = RubikTimeFormat.hhmmss;
        final result3 = date.toTimeAndDateStr(hourSuffix: 'h', format: format2);
        expect(result3, '03h:30:45 - 15/03/2023');
      });
    });

    group('DateTime.toWeekdayStr', () {
      final DateTime date = DateTime(2023, 03, 20);
      DateTime addDays([int? days]) => date.addDays((days ?? 1) - 1);

      test('should return weekday number if locale not found', () {
        const String locale = 'de_CH';
        final expected = DateTime.monday.padLeft();
        final weekday = date.toWeekdayStr(locale: locale);

        expect(weekday, isNotEmpty);
        expect(weekday, expected);

        final weekday2 = date.toWeekdayStr(
          locale: locale,
          useAbbreviation: true,
        );

        expect(weekday2, expected);
      });

      test('should return weekday to default locale', () {
        expect(date.toWeekdayStr(), 'Segunda-feira');
        expect(date.toWeekdayStr(useShortName: true), 'Seg');
        expect(date.toWeekdayStr(useAbbreviation: true), 'Segunda');

        final tuesday = addDays(DateTime.tuesday);
        expect(tuesday.toWeekdayStr(), 'Terça-feira');
        expect(tuesday.toWeekdayStr(useShortName: true), 'Ter');
        expect(tuesday.toWeekdayStr(useAbbreviation: true), 'Terça');

        final wednesday = addDays(DateTime.wednesday);
        expect(wednesday.toWeekdayStr(), 'Quarta-feira');
        expect(wednesday.toWeekdayStr(useShortName: true), 'Qua');
        expect(wednesday.toWeekdayStr(useAbbreviation: true), 'Quarta');

        final thursday = addDays(DateTime.thursday);
        expect(thursday.toWeekdayStr(), 'Quinta-feira');
        expect(thursday.toWeekdayStr(useShortName: true), 'Qui');

        final friday = addDays(DateTime.friday);
        expect(friday.toWeekdayStr(), 'Sexta-feira');
        expect(friday.toWeekdayStr(useShortName: true), 'Sex');

        final saturday = addDays(DateTime.saturday);
        expect(saturday.toWeekdayStr(), 'Sábado');
        expect(saturday.toWeekdayStr(useShortName: true), 'Sáb');

        final sunday = addDays(DateTime.sunday);
        expect(sunday.toWeekdayStr(), 'Domingo');
        expect(sunday.toWeekdayStr(useShortName: true), 'Dom');
      });

      test('should return weekday to en locale', () {
        String weekdayInEn([int? addDay, bool useShortName = false]) {
          return addDays(addDay)
              .toWeekdayStr(locale: 'en', useShortName: useShortName);
        }

        expect(weekdayInEn(), 'Monday');
        expect(weekdayInEn(null, true), 'Mon');

        expect(weekdayInEn(DateTime.tuesday), 'Tuesday');
        expect(weekdayInEn(DateTime.tuesday, true), 'Tue');

        expect(weekdayInEn(DateTime.wednesday), 'Wednesday');
        expect(weekdayInEn(DateTime.wednesday, true), 'Wed');

        expect(weekdayInEn(DateTime.thursday), 'Thursday');
        expect(weekdayInEn(DateTime.thursday, true), 'Thu');

        expect(weekdayInEn(DateTime.friday), 'Friday');
        expect(weekdayInEn(DateTime.friday, true), 'Fri');

        expect(weekdayInEn(DateTime.saturday), 'Saturday');
        expect(weekdayInEn(DateTime.saturday, true), 'Sat');

        expect(weekdayInEn(DateTime.sunday), 'Sunday');
        expect(weekdayInEn(DateTime.sunday, true), 'Sun');
      });
    });

    group('DateTime.toMonthStr', () {
      final DateTime date = DateTime(2023, 01, 15);
      DateTime addMonths([int? months]) => date.addMonths((months ?? 1) - 1);

      test('should return month number if locale not found', () {
        const String locale = 'de_CH';
        final expected = DateTime.january.padLeft();

        expect(date.toMonthNameStr(locale: locale), expected);

        final weekday2 = date.toMonthNameStr(
          locale: locale,
          useShortName: true,
        );
        expect(weekday2, expected);
      });

      test('should return month to default locale', () {
        expect(date.toMonthNameStr(), 'Janeiro');
        expect(date.toMonthNameStr(useShortName: true), 'Jan');

        final february = addMonths(DateTime.february);
        expect(february.toMonthNameStr(), 'Fevereiro');
        expect(february.toMonthNameStr(useShortName: true), 'Fev');

        final march = addMonths(DateTime.march);
        expect(march.toMonthNameStr(), 'Março');
        expect(march.toMonthNameStr(useShortName: true), 'Mar');

        final april = addMonths(DateTime.april);
        expect(april.toMonthNameStr(), 'Abril');
        expect(april.toMonthNameStr(useShortName: true), 'Abr');

        final may = addMonths(DateTime.may);
        expect(may.toMonthNameStr(), 'Maio');
        expect(may.toMonthNameStr(useShortName: true), 'Mai');

        final june = addMonths(DateTime.june);
        expect(june.toMonthNameStr(), 'Junho');
        expect(june.toMonthNameStr(useShortName: true), 'Jun');

        final july = addMonths(DateTime.july);
        expect(july.toMonthNameStr(), 'Julho');
        expect(july.toMonthNameStr(useShortName: true), 'Jul');

        final august = addMonths(DateTime.august);
        expect(august.toMonthNameStr(), 'Agosto');
        expect(august.toMonthNameStr(useShortName: true), 'Ago');

        final september = addMonths(DateTime.september);
        expect(september.toMonthNameStr(), 'Setembro');
        expect(september.toMonthNameStr(useShortName: true), 'Set');

        final october = addMonths(DateTime.october);
        expect(october.toMonthNameStr(), 'Outubro');
        expect(october.toMonthNameStr(useShortName: true), 'Out');

        final november = addMonths(DateTime.november);
        expect(november.toMonthNameStr(), 'Novembro');
        expect(november.toMonthNameStr(useShortName: true), 'Nov');

        final december = addMonths(DateTime.december);
        expect(december.toMonthNameStr(), 'Dezembro');
        expect(december.toMonthNameStr(useShortName: true), 'Dez');
      });

      test('should return month to en locale', () {
        String monthInEn([int? addMonth, bool useShortName = false]) {
          return addMonths(addMonth)
              .toMonthNameStr(locale: 'en', useShortName: useShortName);
        }

        expect(monthInEn(), 'January');
        expect(monthInEn(null, true), 'Jan');

        expect(monthInEn(DateTime.february), 'February');
        expect(monthInEn(DateTime.february, true), 'Feb');

        expect(monthInEn(DateTime.march), 'March');
        expect(monthInEn(DateTime.march, true), 'Mar');

        expect(monthInEn(DateTime.april), 'April');
        expect(monthInEn(DateTime.april, true), 'Apr');

        expect(monthInEn(DateTime.may), 'May');
        expect(monthInEn(DateTime.may, true), 'May');

        expect(monthInEn(DateTime.june), 'June');
        expect(monthInEn(DateTime.june, true), 'Jun');

        expect(monthInEn(DateTime.july), 'July');
        expect(monthInEn(DateTime.july, true), 'Jul');

        expect(monthInEn(DateTime.august), 'August');
        expect(monthInEn(DateTime.august, true), 'Aug');

        expect(monthInEn(DateTime.september), 'September');
        expect(monthInEn(DateTime.september, true), 'Sep');

        expect(monthInEn(DateTime.october), 'October');
        expect(monthInEn(DateTime.october, true), 'Oct');

        expect(monthInEn(DateTime.november), 'November');
        expect(monthInEn(DateTime.november, true), 'Nov');

        expect(monthInEn(DateTime.december), 'December');
        expect(monthInEn(DateTime.december, true), 'Dec');
      });
    });

    group('RubikDatetimeExtensions.toFullDateTimeStr', () {
      group('pt_BR', () {
        final date = DateTime(2023, 03, 15);
        test('should return formatted date in [15/03]', () {
          final formatted = date.toFullDateTimeStr();
          expect(formatted, equals('15/03'));
        });

        test('should return formatted date in [15-03]', () {
          const format = RubikDayMonthFormat.ddMM;
          final formatted = date.toFullDateTimeStr(format: format);
          expect(formatted, equals('15-03'));
        });

        test('should return formatted date in [15/Mar]', () {
          const format = RubikDayMonthFormat.ddmmm;
          final formatted = date.toFullDateTimeStr(format: format);
          expect(formatted, equals('15/Mar'));
        });

        test('should return formatted date in [15 de Março]', () {
          const format = RubikDayMonthFormat.ddMMM;
          final formatted = date.toFullDateTimeStr(format: format);
          expect(formatted, equals('15 de Março'));
        });

        test('should return formatted date in [Mar 15, 2023]', () {
          const format = RubikDayMonthFormat.ddmmyyyy;
          final formatted = date.toFullDateTimeStr(format: format);
          expect(formatted, equals('Mar 15, 2023'));
        });

        test('should return formatted date in [Março 15, 2023]', () {
          const format = RubikDayMonthFormat.ddMMyyyy;
          final formatted = date.toFullDateTimeStr(format: format);
          expect(formatted, equals('Março 15, 2023'));
        });

        test('should return formatted date in [15/Mar/2023]', () {
          const format = RubikDayMonthFormat.ddmmmyyyy;
          final formatted = date.toFullDateTimeStr(format: format);
          expect(formatted, equals('15/Mar/2023'));
        });

        test('should return formatted date in [15 de Março de 2023]', () {
          const format = RubikDayMonthFormat.ddMMMyyyy;
          final formatted = date.toFullDateTimeStr(format: format);
          expect(formatted, equals('15 de Março de 2023'));
        });
      });

      group('en', () {
        const String locale = 'en';
        final date = DateTime(2023, 04, 15);

        test('should return formatted date in [15/Apr]', () {
          const format = RubikDayMonthFormat.ddmmm;
          final formatted =
              date.toFullDateTimeStr(format: format, locale: locale);
          expect(formatted, equals('15/Apr'));
        });

        test('should return formatted date in [15 de April]', () {
          const format = RubikDayMonthFormat.ddMMM;
          final formatted =
              date.toFullDateTimeStr(format: format, locale: locale);
          expect(formatted, equals('15 April'));
        });

        test('should return formatted date in [Apr 15, 2023]', () {
          const format = RubikDayMonthFormat.ddmmyyyy;
          final formatted =
              date.toFullDateTimeStr(format: format, locale: locale);
          expect(formatted, equals('Apr 15, 2023'));
        });

        test('should return formatted date in [April 15, 2023]', () {
          const format = RubikDayMonthFormat.ddMMyyyy;
          final formatted =
              date.toFullDateTimeStr(format: format, locale: locale);
          expect(formatted, equals('April 15, 2023'));
        });

        test('should return formatted date in [15/Apr/2023]', () {
          const format = RubikDayMonthFormat.ddmmmyyyy;
          final formatted =
              date.toFullDateTimeStr(format: format, locale: locale);
          expect(formatted, equals('15/Apr/2023'));
        });

        test('should return formatted date in [15/Apr/2023]', () {
          const format = RubikDayMonthFormat.ddMMMyyyy;
          final formatted =
              date.toFullDateTimeStr(format: format, locale: locale);
          expect(formatted, equals('15 April 2023'));
        });
      });
    });

    group('RubikDatetimeExtensions.isBeetween', () {
      final start = DateTime(2023, 03, 13);
      final end = DateTime(2023, 03, 24);

      test('should return true if date is between startDate and endDate', () {
        final date = DateTime(2023, 03, 15);
        expect(date.isBetween(start, end), isTrue);
        expect(start.isBetween(start, end), isFalse);
      });

      test('should return true if date is between endDate and startDate', () {
        final date = DateTime(2023, 03, 15);
        expect(date.isBetween(end, start), isFalse);
        expect(date.isBetween(end, start, invertedInterval: true), isTrue);
        expect(date.isBetween(start, end, invertedInterval: true), isFalse);
      });

      test(
        'should return false if date is not between startDate and endDate',
        () {
          final date = DateTime(2023, 01, 12);
          expect(date.isBetween(start, end), isFalse);

          final date2 = DateTime(2023, 04, 28);
          expect(date2.isBetween(start, end), isFalse);
        },
      );
    });

    group('RubikDatetimeExtensions.isSameMomentAs', () {
      test('should return true if date is same moment as other', () {
        final date = DateTime(2023, 03, 15, 12, 30, 30);
        final date2 = DateTime(2023, 03, 15, 12, 30, 30);
        expect(date.isSameMomentAs(date2), isTrue);
      });

      test('should return false if date is not same moment as other', () {
        final date = DateTime.now();
        final other = DateTime.now().addDays(1);

        expect(date.isSameMomentAs(other), isFalse);
      });

      test(
        'should return true if date is same moment as other, with tolerance of 5 days',
        () {
          final date = DateTime.now();
          const tolerance = Duration(days: 5);
          final other = DateTime.now().addDays(4);

          expect(date.isSameMomentAs(other, tolerance: tolerance), isTrue);
        },
      );
    });

    group('RubikDatetimeExtensions.isToday', () {
      test('should return true if date is today', () {
        final now = DateTime.now();
        expect(now.isToday, isTrue);
        expect(now.subtractDays(1).isToday, isFalse);
      });
    });

    group('RubikDatetimeExtensions.isYesterday', () {
      test('should return true if date is yesterday', () {
        final now = DateTime.now();
        expect(now.isYesterday, isFalse);
        expect(now.subtractDays(1).isYesterday, isTrue);
      });
    });

    group('RubikDatetimeExtensions.isTomorrow', () {
      test('should return true if date is isTomorrow', () {
        final now = DateTime.now();
        expect(now.isTomorrow, isFalse);
        expect(now.addDays(1).isTomorrow, isTrue);
      });
    });

    group('RubikDatetimeExtensions.isWeekend', () {
      test('should return true if date is weekend', () {
        expect(DateTime(2023, 03, 18).isWeekend, isTrue);
        expect(DateTime(2023, 03, 15).isWeekend, isFalse);
      });
    });

    group('RubikDatetimeExtensions.isWeekday', () {
      test('should return true if date is weekday', () {
        expect(DateTime(2023, 03, 18).isWeekday, isFalse);
        expect(DateTime(2023, 03, 15).isWeekday, isTrue);
      });
    });

    group('RubikDatetimeExtensions.dateToDuration', () {
      test('should return duration between dates', () {
        final date = DateTime(2023, 03, 15, 12, 30, 30);
        final date2 = DateTime(2023, 03, 15, 12, 30, 30);
        expect(date.dateToDuration(date2), equals(Duration.zero));
      });
    });

    group('RubikDatetimeExtensions.toDuration', () {
      test('should convert date to duration', () {
        final date = DateTime(2023, 03, 27);
        expect(date.toDuration, const Duration(days: 27));

        final date2 = DateTime(2023, 03, 27, 12, 30, 30);
        const actual = Duration(days: 27, hours: 12, minutes: 30, seconds: 30);
        expect(date2.toDuration, actual);
      });
    });
  });
}
