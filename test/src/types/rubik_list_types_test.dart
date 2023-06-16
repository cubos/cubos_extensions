import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/types/rubik_types.dart';

void main() {
  group('RubikListTypes', () {
    group('RubikBaseCast', () {
      test('should create RubikBaseCast instance contains list any type', () {
        const numbers = RubikBaseCast<int, String>([1, 2, 3, 4, 5]);

        expect(numbers.isSameType(), isFalse);
        expect(numbers, isA<RubikBaseCast<int, String>>());

        const numbers2 = RubikBaseCast<int, int>([1, 2, 3, 4, 5]);
        expect(numbers2.isSameType(), isTrue);
      });

      test(
        'should returns a error when cast to a different type',
        () {
          const numbers = RubikBaseCast<int, String>([1, 2, 3, 4, 5]);
          const message = "type 'int' is not a subtype of type 'String'";

          try {
            numbers.castFrom().toList();
            fail('Expected an error to be thrown');
          } catch (e) {
            expect(e, isA<TypeError>());
            expect(e.toString(), contains(message));
          }
        },
      );

      test('should return empty list when cast to a different type', () {
        const numbers = RubikBaseCast<int, String>([1, 2, 3, 4, 5]);
        final cast = numbers.whereType<String>().toList();

        expect(cast, isEmpty);
        expect(cast, isA<List<String>>());
      });
    });

    group('RubikCastStringToDuration', () {
      test(
        'should create RubikCastStringToDuration instance and convert string to duration',
        () {
          const stringToDurationCast = RubikCastStringToDuration([
            '10:00:00.000000',
            '36:01:15.000000',
            '50:12:06.000000',
            '72:12:04.000000',
          ]);

          expect(stringToDurationCast.isSameType(), isFalse);
          final result = stringToDurationCast.castFrom();

          expect(result.length, 4);
          expect(result.first, isA<Duration>());
          expect(result.first, const Duration(hours: 10));
        },
      );
    });

    group('RubikIntegerToDuration', () {
      test(
        'should create RubikIntegerToDuration instance using RubikTimeUnit.days',
        () {
          const integerCast = RubikIntegerToDuration(
            [10, 20, 30],
            RubikTimeUnit.days,
          );

          final casted = integerCast.castFrom();
          final expected = List<Duration>.generate(
            3,
            (index) => Duration(days: (index + 1) * 10),
          );

          expect(casted.length, 3);
          expect(casted, expected);
        },
      );

      test(
        'should create RubikIntegerToDuration instance and convert integer to duration',
        () {
          const integerCast = RubikIntegerToDuration(
            [864000000, 54541000, 329111000, 76642000],
          );

          expect(integerCast.isSameType(), isFalse);
          final result = integerCast.castFrom();

          expect(result.length, 4);
          expect(result.first, isA<Duration>());
          expect(result.first, const Duration(days: 10));
        },
      );
    });

    group('RubikDateTimeToDuration', () {
      test(
        'should create RubikDateTimeToDuration instance and convert DateTime to duration',
        () {
          final dateTimeCast = RubikDateTimeToDuration([
            DateTime(2020, 1, 1),
            DateTime(2020, 1, 2),
            DateTime(2020, 1, 3),
            DateTime(2020, 1, 4),
          ]);

          expect(dateTimeCast.isSameType(), isFalse);
          final result = dateTimeCast.castFrom();

          expect(result.length, 4);
          expect(result.first, isA<Duration>());
          expect(result.first, const Duration(days: 1));
        },
      );
    });

    group('RubikCastStringToDateTime', () {
      test(
        'should create RubikCastStringToDateTime instance and convert string to DateTime',
        () {
          const stringToDateTimeCast = RubikCastStringToDateTime([
            '2020-01-01 00:00:00.000',
            '2020-01-02 00:00:00.000',
            '2020-01-03 00:00:00.000',
            'sadsadsadsadsadas',
          ]);

          expect(stringToDateTimeCast.isSameType(), isFalse);
          final result = stringToDateTimeCast.castFrom();

          expect(result.length, 4);
          expect(result.first, isA<DateTime>());
          expect(result.first, DateTime(2020, 1, 1));
          expect(result.last, DateTime(0, 0, 0));
        },
      );
    });

    test('should convert to list in method RubikCastStringToDateTime.pase', () {
      final dates = [
        '2020-01-01 00:00:00.000',
        '2020-01-02 00:00:00.000',
        '2020-01-03 00:00:00.000',
      ];

      final casted = RubikCastStringToDateTime.parse(dates);

      expect(casted.length, 3);
      expect(casted.first, isA<DateTime>());
      expect(casted.first, DateTime(2020, 1, 1));
    });

    group('RubikDurationToDateTime', () {
      test(
        'should create RubikDurationToDateTime instance and convert Duration to DateTime',
        () {
          const durationToDateTimeCast = RubikDurationToDateTime([
            Duration(days: 1, minutes: 45, seconds: 20),
            Duration(days: 2, minutes: 45, seconds: 20),
            Duration(days: 3, minutes: 45, seconds: 20),
            Duration(days: 4, minutes: 45, seconds: 20),
          ]);

          expect(durationToDateTimeCast.isSameType(), isFalse);
          final result = durationToDateTimeCast.castFrom();

          expect(result.length, 4);
          expect(result.first, isA<DateTime>());

          final now = DateTime.now();
          expect(result, [
            DateTime(now.year, now.month, now.day + 1, 0, 45, 20),
            DateTime(now.year, now.month, now.day + 2, 0, 45, 20),
            DateTime(now.year, now.month, now.day + 3, 0, 45, 20),
            DateTime(now.year, now.month, now.day + 4, 0, 45, 20),
          ]);
        },
      );
    });
  });
}
