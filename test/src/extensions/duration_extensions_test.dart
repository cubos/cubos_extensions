import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/extensions/duration_extensions.dart';

import '../../utils/tests_utils.dart';

void main() {
  group('RubikDurationExtensions', () {
    group('RubikDurationExtensions.dayStr', () {
      test('should return 25 days', () {
        const duration = Duration(days: 25);
        expect(duration.dayStr(), '25');
        expect(duration.dayStr(separator: ' days'), '25 days');
      });
    });

    group('RubikDurationExtensions.hourStr', () {
      test('should return 15 hours', () {
        const duration = Duration(hours: 15);
        expect(duration.hourStr(), '15');
        expect(duration.hourStr(separator: ' hours'), '15 hours');
        expect(duration.hourStr(remainder: true), '15');
      });
    });

    group('RubikDurationExtensions.minuteStr', () {
      test('should return 10 minutes', () {
        const duration = Duration(minutes: 10);
        expect(duration.minuteStr(), '10');
        expect(duration.minuteStr(separator: ' minutes'), '10 minutes');
        expect(duration.minuteStr(remainder: true), '10');
      });
    });

    group('RubikDurationExtensions.secondStr', () {
      test('should return 10 seconds', () {
        const duration = Duration(seconds: 10);
        expect(duration.secondStr(), '10');
        expect(duration.secondStr(separator: ' seconds'), '10 seconds');
        expect(duration.secondStr(remainder: true), '10');
      });
    });

    group('RubikDurationExtensions.addHours', () {
      test('should add 2 hours', () {
        const duration = Duration(hours: 10);
        expect(duration.addHours(2), const Duration(hours: 12));
      });

      test('should add 2 hours and 30 minutes', () {
        const duration = Duration(hours: 10);
        expect(duration.addHours(-2), const Duration(hours: 8));
      });
    });

    group('RubikDurationExtensions.addMinutes', () {
      test('should add 2 minutes', () {
        const duration = Duration(minutes: 10);
        expect(duration.addMinutes(2), const Duration(minutes: 12));
      });

      test('should add 2 minutes and 30 seconds', () {
        const duration = Duration(minutes: 10);
        expect(duration.addMinutes(-2), const Duration(minutes: 8));
      });
    });

    group('RubikDurationExtensions.addSeconds', () {
      test('should add 2 seconds', () {
        const duration = Duration(seconds: 10);
        expect(duration.addSeconds(2), const Duration(seconds: 12));
      });

      test('should add 2 seconds and 30 milliseconds', () {
        const duration = Duration(seconds: 10);
        expect(duration.addSeconds(-2), const Duration(seconds: 8));
      });
    });

    group('RubikDurationExtensions.add', () {
      test('should return duration addedd 2 hours ', () {
        const duration = Duration(hours: 10, minutes: 5, seconds: 15);
        expect(
          duration.add(hours: 2, minutes: 5, seconds: 30),
          const Duration(hours: 12, minutes: 10, seconds: 45),
        );
      });
    });

    group('RubikDurationExtensions.subtractHours', () {
      test('should subtract 2 hours', () {
        const duration = Duration(hours: 10);
        expect(duration.subtractHours(2), const Duration(hours: 8));
      });

      test('should subtract 2 hours and 30 minutes', () {
        const duration = Duration(hours: 10);
        expect(duration.subtractHours(-2), const Duration(hours: 12));
      });
    });

    group('RubikDurationExtensions.subtractMinutes', () {
      test('should subtract 2 minutes', () {
        const duration = Duration(minutes: 10);
        expect(duration.subtractMinutes(2), const Duration(minutes: 8));
      });

      test('should subtract 2 minutes and 30 seconds', () {
        const duration = Duration(minutes: 10);
        expect(duration.subtractMinutes(-2), const Duration(minutes: 12));
      });
    });

    group('RubikDurationExtensions.subtractSeconds', () {
      test('should subtract 2 seconds', () {
        const duration = Duration(seconds: 10);
        expect(duration.subtractSeconds(2), const Duration(seconds: 8));
      });

      test('should subtract 2 seconds and 30 milliseconds', () {
        const duration = Duration(seconds: 10);
        expect(duration.subtractSeconds(-2), const Duration(seconds: 12));
      });
    });

    group('RubikDurationExtensions.subtract', () {
      test('should return duration subtracted 2 hours ', () {
        const duration = Duration(hours: 10, minutes: 5, seconds: 15);
        expect(
          duration.subtract(hours: 2, minutes: 5, seconds: 30),
          const Duration(hours: 7, minutes: 59, seconds: 45),
        );
      });
    });

    group('RubikDurationExtensions.toNumberOfWeeks', () {
      test('should return number of weeks for a given number of days', () {
        int toNumberOfWeeks([int days = 0]) =>
            Duration(days: days).toNumberOfWeeks;

        expect(toNumberOfWeeks(0), equals(0));
        expect(toNumberOfWeeks(1), equals(0));
        expect(toNumberOfWeeks(7), equals(1));

        expect(toNumberOfWeeks(14), equals(2));
        expect(toNumberOfWeeks(20), equals(2));
        expect(toNumberOfWeeks(21), equals(3));

        expect(toNumberOfWeeks(30), equals(4));
        expect(toNumberOfWeeks(60), equals(8));
        expect(toNumberOfWeeks(90), equals(12));
      });
    });

    group('RubikDurationExtensions.toNumberOfMonths', () {
      test('should return number of months for a given number of days', () {
        int toNumberOfMonths([int days = 0]) =>
            Duration(days: days).toNumberOfMonths;

        expect(toNumberOfMonths(0), equals(0));
        expect(toNumberOfMonths(1), equals(0));
        expect(toNumberOfMonths(30), equals(1));

        expect(toNumberOfMonths(60), equals(2));
        expect(toNumberOfMonths(90), equals(3));
        expect(toNumberOfMonths(120), equals(4));

        expect(toNumberOfMonths(150), equals(5));
        expect(toNumberOfMonths(180), equals(6));
        expect(toNumberOfMonths(210), equals(7));

        expect(toNumberOfMonths(240), equals(8));
        expect(toNumberOfMonths(270), equals(9));
        expect(toNumberOfMonths(300), equals(10));

        expect(toNumberOfMonths(330), equals(11));
        expect(toNumberOfMonths(360), equals(12));
        expect(toNumberOfMonths(390), equals(13));
      });
    });

    group('RubikDurationExtensions.toNumberOfYears', () {
      test('should return number of years for a given number of days', () {
        int toNumberOfYears([int days = 0]) =>
            Duration(days: days).toNumberOfYears;

        expect(toNumberOfYears(0), equals(0));
        expect(toNumberOfYears(365), equals(1));
        expect(toNumberOfYears(730), equals(2));
        expect(toNumberOfYears(1096), equals(3));
        expect(toNumberOfYears(1825), equals(5));
      });
    });

    group('RubikDurationExtensions.daysWithSuffix', () {
      group('pt_BR', () {
        test('should return 1 dia if duration is 1 day', () {
          final duration = TestsUtils.duration(1);
          expect(duration.daysWithSuffix(), equals('01d'));
          expect(duration.daysWithSuffix(shortSuffix: false), '01dia');

          final actual = duration.daysWithSuffix(
            shortSuffix: false,
            separeteWithSpace: true,
          );

          expect(duration.daysWithSuffix(separeteWithSpace: true), '01 d');
          expect(actual, '01 dia');
        });

        test('should return 2 dias if duration is 2 day', () {
          final duration = TestsUtils.duration(2);

          final actual = duration.daysWithSuffix(
            shortSuffix: false,
            separeteWithSpace: true,
          );

          expect(actual, '02 dias');
          expect(duration.daysWithSuffix(shortSuffix: false), '02dias');
        });
      });

      group('en', () {
        const String locale = 'en';

        test('should return 1 day if duration is 1 day in [en] locale', () {
          final duration = TestsUtils.duration(1);

          final actual = duration.daysWithSuffix(
            locale: locale,
            shortSuffix: false,
          );
          expect(actual, '01day');

          final actual2 = duration.daysWithSuffix(
            locale: locale,
            shortSuffix: false,
            separeteWithSpace: true,
          );
          expect(actual2, '01 day');
        });

        test('should return 2 days if duration is 2 day in [en] locale', () {
          final duration = TestsUtils.duration(2);

          final actual = duration.daysWithSuffix(
            locale: locale,
            shortSuffix: false,
            separeteWithSpace: true,
          );
          expect(actual, '02 days');

          final actual2 = duration.daysWithSuffix(
            shortSuffix: false,
            locale: locale,
          );
          expect(actual2, '02days');
        });
      });
    });

    group('RubikDurationExtensions.hoursWithSuffix', () {
      group('pt_BR', () {
        test('should return 1 hora if duration is 1 hour', () {
          final duration = TestsUtils.duration(0, 1);
          expect(duration.hoursWithSuffix(), equals('01h'));
          expect(duration.hoursWithSuffix(shortSuffix: false), '01hora');

          final actual = duration.hoursWithSuffix(
            shortSuffix: false,
            separeteWithSpace: true,
          );

          expect(duration.hoursWithSuffix(separeteWithSpace: true), '01 h');
          expect(actual, '01 hora');
        });

        test('should return 2 horas if duration is 2 hours', () {
          final duration = TestsUtils.duration(0, 2);

          final actual = duration.hoursWithSuffix(
            shortSuffix: false,
            separeteWithSpace: true,
          );

          expect(actual, '02 horas');
          expect(duration.hoursWithSuffix(shortSuffix: false), '02horas');
        });
      });

      group('en', () {
        const String locale = 'en';

        test('should return 1 hour if duration is 1 hour in [en] locale', () {
          final duration = TestsUtils.duration(0, 1);

          final actual = duration.hoursWithSuffix(
            locale: locale,
            shortSuffix: false,
          );
          expect(actual, '01hour');

          final actual2 = duration.hoursWithSuffix(
            locale: locale,
            shortSuffix: false,
            separeteWithSpace: true,
          );
          expect(actual2, '01 hour');
        });

        test('should return 2 hour if duration is 2 hour in [en] locale', () {
          final duration = TestsUtils.duration(0, 2);

          final actual = duration.hoursWithSuffix(
            locale: locale,
            shortSuffix: false,
            separeteWithSpace: true,
          );
          expect(actual, '02 hours');

          final actual2 = duration.hoursWithSuffix(
            locale: locale,
            shortSuffix: false,
          );
          expect(actual2, '02hours');
        });
      });
    });

    group('RubikDurationExtensions.minutesWithSuffix', () {
      group('pt_BR', () {
        test('should return 01 minuto if duration is 1 minute', () {
          final duration = TestsUtils.duration(0, 0, 1);
          expect(duration.minutesWithSuffix(), equals('01m'));
          expect(duration.minutesWithSuffix(shortSuffix: false), '01minuto');

          final actual = duration.minutesWithSuffix(
            shortSuffix: false,
            separeteWithSpace: true,
          );

          expect(duration.minutesWithSuffix(separeteWithSpace: true), '01 m');
          expect(actual, '01 minuto');
        });

        test('should return 2 minutos if duration is 2 minute', () {
          final duration = TestsUtils.duration(0, 0, 2);

          final actual = duration.minutesWithSuffix(
            shortSuffix: false,
            separeteWithSpace: true,
          );

          expect(actual, '02 minutos');
          expect(
            duration.minutesWithSuffix(shortSuffix: false),
            '02minutos',
          );
        });
      });

      group('en', () {
        const String locale = 'en';

        test(
          'should return 1 minute if duration is 1 minute in [en] locale',
          () {
            final duration = TestsUtils.duration(0, 0, 1);

            final actual = duration.minutesWithSuffix(
              locale: locale,
              shortSuffix: false,
            );
            expect(actual, '01minute');

            final actual2 = duration.minutesWithSuffix(
              locale: locale,
              shortSuffix: false,
              separeteWithSpace: true,
            );
            expect(actual2, '01 minute');
          },
        );

        test(
          'should return 2 minute if duration is 2 minute in [en] locale',
          () {
            final duration = TestsUtils.duration(0, 0, 2);

            final actual = duration.minutesWithSuffix(
              locale: locale,
              shortSuffix: false,
              separeteWithSpace: true,
            );
            expect(actual, '02 minutes');

            final actual2 = duration.minutesWithSuffix(
              locale: locale,
              shortSuffix: false,
            );
            expect(actual2, '02minutes');
          },
        );
      });
    });

    group('RubikDurationExtensions.secondsWithSuffix', () {
      group('pt_BR', () {
        test('should return 01 segundo if duration is 1 second', () {
          final duration = TestsUtils.duration(0, 0, 0, 1);
          expect(duration.secondsWithSuffix(), equals('01s'));
          expect(
            duration.secondsWithSuffix(shortSuffix: false),
            '01segundo',
          );

          final actual = duration.secondsWithSuffix(
            shortSuffix: false,
            separeteWithSpace: true,
          );

          expect(duration.secondsWithSuffix(separeteWithSpace: true), '01 s');
          expect(actual, '01 segundo');
        });

        test('should return 2 segundos if duration is 2 second', () {
          final duration = TestsUtils.duration(0, 0, 0, 2);

          final actual = duration.secondsWithSuffix(
            shortSuffix: false,
            separeteWithSpace: true,
          );

          expect(actual, '02 segundos');
          expect(
            duration.secondsWithSuffix(shortSuffix: false),
            '02segundos',
          );
        });
      });

      group('en', () {
        const String locale = 'en';

        test(
          'should return 1 second if duration is 1 seconds in [en] locale',
          () {
            final duration = TestsUtils.duration(0, 0, 0, 1);

            final actual = duration.secondsWithSuffix(
              locale: locale,
              shortSuffix: false,
            );
            expect(actual, '01second');

            final actual2 = duration.secondsWithSuffix(
              locale: locale,
              shortSuffix: false,
              separeteWithSpace: true,
            );
            expect(actual2, '01 second');
          },
        );

        test(
          'should return 2 seconds if duration is 2 seconds in [en] locale',
          () {
            final duration = TestsUtils.duration(0, 0, 0, 2);

            final actual = duration.secondsWithSuffix(
              locale: locale,
              shortSuffix: false,
              separeteWithSpace: true,
            );
            expect(actual, '02 seconds');

            final actual2 = duration.secondsWithSuffix(
              locale: locale,
              shortSuffix: false,
            );
            expect(actual2, '02seconds');
          },
        );
      });
    });

    group('RubikDurationExtensions.toTimeStr', () {
      group('pt_BR', () {
        test('should return 00:00:00 if duration is empty', () {
          final duration = TestsUtils.duration();
          expect(duration.toTimeStr(), equals('00:00:00'));
        });

        test(
          'should return 1d:30m:25s if duration is 1 day, 3 hours 30 minutes and 25 seconds',
          () {
            final duration = TestsUtils.duration(1, 3, 30, 25);
            expect(duration.toTimeStr(), equals('01d:03h:30m:25s'));

            final duration2 = TestsUtils.duration(1, 3, 30);
            expect(duration2.toTimeStr(), equals('01d:03h:30m'));

            final duration3 = TestsUtils.duration(1, 0, 30);
            expect(duration3.toTimeStr(), equals('01d:30m'));

            final duration4 = TestsUtils.duration(1, 0, 0, 45);
            expect(duration4.toTimeStr(), equals('01d:45s'));

            var actual = duration.toTimeStr(separator: ' ', shortSuffix: false);
            expect(actual, '01dia 03horas 30minutos 25segundos');

            actual = duration.toTimeStr(
              separator: ' ',
              shortSuffix: false,
              separateSuffixWithSpace: true,
            );
            expect(actual, '01 dia 03 horas 30 minutos 25 segundos');
          },
        );
      });
    });

    group('RubikDatetimeExtensions.toDateTime', () {
      test('should return DateTime.now if duration is empty', () {
        final duration = TestsUtils.duration();
        expect(duration.toDateTime(), TestsUtils.getDateTimeNow());
      });

      test('should convert duration to datetime', () {
        final now = DateTime.now();

        final duration = TestsUtils.duration(1);
        final expected = DateTime(now.year, now.month, now.day + 1);
        expect(duration.toDateTime(), expected);

        final duration2 = TestsUtils.duration(2, 3, 30, 25);
        final expected2 = DateTime(now.year, now.month, now.day + 2, 3, 30, 25);
        expect(duration2.toDateTime(), expected2);
        expect(
          duration2.toDateTime(2021, 1, 1),
          DateTime(2021, 1, 3, 3, 30, 25),
        );
      });
    });
  });
}
