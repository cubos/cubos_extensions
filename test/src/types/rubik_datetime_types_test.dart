import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

void main() {
  group('RubikTimeFormat', () {
    group('RubikTimeFormat.resolve', () {
      test('should return true if type is hhmm', () {
        expect(RubikTimeFormat.hhmm.isHHMM, true);
        expect(RubikTimeFormat.hhmmss.isHHMM, false);
        expect(RubikTimeFormat.hhmmss.isHHMMSS, true);
      });

      test('should return true if type is 24h', () {
        expect(RubikTimeFormat.hhmm.is24H(), false);
        expect(RubikTimeFormat.hhmm24H.is24H(), true);
        expect(RubikTimeFormat.hhmmss24H.is24H(), true);
      });
    });

    group('RubikTimeFormat.resolve', () {
      final DateTime date = DateTime(2023, 3, 14, 15, 8, 45);

      String resolve(RubikTimeFormat format, {String hourSuffix = ''}) {
        if (format.is24H()) {
          return format.resolve(
            date.hourStr,
            date.minuteStr,
            second: date.secondStr,
            hourSuffix: hourSuffix,
          );
        }

        final hourInPm =
            (date.hour > 12 ? date.hour - 12 : date.hour).padLeft();

        return format.resolve(
          hourInPm,
          date.minuteStr,
          second: date.secondStr,
          hourSuffix: hourSuffix,
        );
      }

      test('should return hours formatted with type hhmm', () {
        expect(resolve(RubikTimeFormat.hhmm), '03:08');
        expect(resolve(RubikTimeFormat.hhmm, hourSuffix: 'h###'), '03h###:08');
      });

      test('should return hours formatted with type hhmmss', () {
        const RubikTimeFormat type = RubikTimeFormat.hhmmss;

        expect(resolve(type), '03:08:45');
        expect(resolve(type, hourSuffix: 'h###'), '03h###:08:45');
      });

      test('should return hours formatted with type hhmm24H', () {
        const RubikTimeFormat type = RubikTimeFormat.hhmm24H;

        expect(resolve(type), '15:08');
        expect(resolve(type, hourSuffix: 'h###'), '15h###:08');
      });

      test('should return hours formatted with type hhmmss24H', () {
        const RubikTimeFormat type = RubikTimeFormat.hhmmss24H;
        expect(resolve(type), '15:08:45');
        expect(resolve(type, hourSuffix: 'h###'), '15h###:08:45');
      });
    });

    group('RubikDayMonthFormat.shouldItMonthName', () {
      test('should return true if type is ddmmm', () {
        expect(RubikDayMonthFormat.ddmmm.shouldItMonthName, true);
        expect(RubikDayMonthFormat.ddmm.shouldItMonthName, false);
      });

      test('should return true if type is ddMMM', () {
        expect(RubikDayMonthFormat.ddMMM.shouldItMonthName, true);
        expect(RubikDayMonthFormat.ddmm.shouldItMonthName, false);
      });

      test('should return true if type is ddmmmyyyy', () {
        expect(RubikDayMonthFormat.ddmmmyyyy.shouldItMonthName, true);
        expect(RubikDayMonthFormat.ddmm.shouldItMonthName, false);
      });

      test('should return true if type is ddMMMyyyy', () {
        expect(RubikDayMonthFormat.ddMMMyyyy.shouldItMonthName, true);
        expect(RubikDayMonthFormat.ddmm.shouldItMonthName, false);
      });
    });

    group('RubikDayMonthFormat.resolve', () {
      test(
        'should correctly format the day and month according to the defined format',
        () {
          const format1 = RubikDayMonthFormat.ddmm;
          expect(format1.resolve('28', '03'), '28/03');

          const format2 = RubikDayMonthFormat.ddMM;
          expect(format2.resolve('28', '03'), '28-03');

          const format3 = RubikDayMonthFormat.ddmmm;
          expect(format3.resolve('28', 'Jan'), '28/Jan');

          const format4 = RubikDayMonthFormat.ddMMM;
          expect(format4.resolve('28', 'Janeiro'), '28 de Janeiro');

          const format5 = RubikDayMonthFormat.ddmmyyyy;
          expect(format5.resolve('28', 'Jan', year: '2023'), 'Jan 28, 2023');

          const format6 = RubikDayMonthFormat.ddMMyyyy;
          expect(
            format6.resolve('28', 'Jan', year: '2023'),
            'Jan 28, 2023',
          );
          expect(
            format6.resolve('28', 'Janeiro', year: '2023'),
            'Janeiro 28, 2023',
          );

          const format7 = RubikDayMonthFormat.ddmmmyyyy;
          expect(format7.resolve('28', 'Jan', year: '2023'), '28/Jan/2023');

          const format8 = RubikDayMonthFormat.ddMMMyyyy;
          expect(
            format8.resolve('28', 'Jan', year: '2023'),
            '28 de Jan de 2023',
          );
        },
      );
    });
  });
}
