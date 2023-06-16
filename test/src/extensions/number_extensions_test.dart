import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

void main() {
  group('RubikNumberExtension', () {
    group('RubikNumberExtension.isInteger', () {
      test('should return true if value is int type', () {
        expect(10.isInteger, true);
        expect((-10).isInteger, true);
        expect(245.56.isInteger, false);
      });
    });

    group('RubikNumberExtension.isDouble', () {
      test('should return true if value is double type', () {
        expect(10.0.isDouble, true);
        expect(245.isDouble, false);
        expect((-10.0).isDouble, true);
      });
    });

    group('RubikNumberExtension.toCents', () {
      test('should return 245.56 in cents', () {
        const double money = 245.56;

        expect(0.toCents, 0);
        expect(money.toCents, 24556);
        expect(money.toCents, isA<int>());
      });
    });

    group('RubikNumberExtension.toReal', () {
      test('should return 24556 in real', () {
        const int money = 24556;

        expect(0.toReal, 0);
        expect(money.toReal, 245.56);
        expect(money.toReal, isA<double>());

        expect(40.toReal, 0.4);
        expect(400.toReal, 4.0);
        expect(money.toReal, isA<double>());
      });
    });

    group('RubikNumberExtension.toTwoDecimals', () {
      test('should convert 24.5964 to 24.59', () {
        expect(0.toTwoDecimals(), 0);
        expect(24.5564.toTwoDecimals(), 24.56);
        expect(24.5964.toTwoDecimals(), isA<double>());

        expect(23434.775667676.toTwoDecimals(fractionDigits: 3), 23434.776);
        expect(23434.567767676.toTwoDecimals(fractionDigits: 3), isA<double>());
      });
    });

    group('RubikNumberExtension.formatToCurrency', () {
      test('should formatter number to money', () {
        expect(0.formatToCurrency(symbol: ''), '0,00');
        expect(0.32.formatToCurrency(symbol: ''), '0,32');
        expect(14.45.formatToCurrency(symbol: ''), '14,45');
        expect(1000000.32.formatToCurrency(symbol: ''), '1.000.000,32');
      });

      test('should convert the current value to real currency', () {
        expect(0.formatToCurrency(), 'R\$ 0,00');
        expect(4.55.formatToCurrency(), 'R\$ 4,55');
        expect(120.formatToCurrency(), 'R\$ 120,00');
        expect(345.34.formatToCurrency(), 'R\$ 345,34');
        expect(1000000.32.formatToCurrency(), 'R\$ 1.000.000,32');

        expect(1.50.formatToCurrency(decimalDigits: 1), 'R\$ 1,5');
        expect(0.50.formatToCurrency(decimalDigits: 2), 'R\$ 0,50');
        expect(1.503.formatToCurrency(decimalDigits: 3), 'R\$ 1,503');
      });

      test('should convert the current amount to dollar[€] currency', () {
        const amount = 1000000.32;
        final formatted = amount.formatToCurrency(
          symbol: r'US$',
          locale: 'en_US',
        );

        expect(formatted, 'US\$1,000,000.32');
      });

      test('should convert the current amount to euro[€] currency', () {
        const amount = 1000000.32;
        final formatted = amount.formatToCurrency(symbol: '€', locale: 'de_CH');

        expect(formatted, '€1,000,000.32');
      });
    });

    group('RubikNumberExtension.toPercentage', () {
      test('should return formatted percentage string', () {
        expect(40.toPercentage(), equals('40,0%'));
        expect(1.2.toPercentage(), equals('1,2%'));
        expect(23.43.toPercentage(decimalPlaces: 0), equals('23%'));
        expect(89.56.toPercentage(decimalPlaces: 2), equals('89,56%'));

        const separator = RubikNumberSeparator.dot;
        expect(3.5.toPercentage(separator: separator), equals('3.5%'));
        expect(0.43.toPercentage(separator: separator), equals('0.4%'));

        expect(
          45.56.toPercentage(separator: separator, decimalPlaces: 2),
          equals('45.56%'),
        );
      });
    });

    group('RubikNumberExtension.toRealWithFormatting', () {
      test('should convert to real and formatted value', () {
        expect(0.toRealWithFormatting(symbol: ''), '0,00');
        expect(3234.toRealWithFormatting(symbol: ''), '32,34');
        expect(1445.toRealWithFormatting(symbol: ''), '14,45');
        expect(100000032.toRealWithFormatting(symbol: ''), '1.000.000,32');
      });

      test('should convert the current value to real currency R\$', () {
        expect(0.toRealWithFormatting(), 'R\$ 0,00');
        expect(455.toRealWithFormatting(), 'R\$ 4,55');
        expect(120.toRealWithFormatting(), 'R\$ 1,20');
        expect(34534.toRealWithFormatting(), 'R\$ 345,34');
        expect(100000032.toRealWithFormatting(), 'R\$ 1.000.000,32');
      });
    });

    group('RubikNumberExtension.lessThan', () {
      test(
        'should return true if the current value is less than the value passed',
        () {
          expect(0.lessThan(1), true);
          expect(0.lessThan(0), false);
          expect(0.lessThan(-1), false);
        },
      );

      test(
        'should return true if the current value is less than or equal to the passed value',
        () {
          expect(21.lessThan(21), false);
          expect(21.lessThan(21, needToBeEqual: true), true);
        },
      );
    });

    group('RubikNumberExtension.hasDecimal', () {
      test('should return true if value has decimal number ', () {
        expect(10.hasDecimal, false);
        expect(3.45.hasDecimal, true);
      });
    });

    group('RubikNumberExtension.isBetween', () {
      test(
        'should return true if the current value is between the values passed',
        () {
          expect(2.isBetween(10, 20), false);
          expect(0.56.isBetween(0, 2), true);
          expect((-4).isBetween(-18, 2), true);
          expect(0.isBetween(-1, 1), true);
          expect(34.isBetween(45, 20), true);

          expect(45.isBetween(0, 1, needToBeEqual: true), false);
          expect(45.isBetween(45, 20, needToBeEqual: true), true);
          expect(2.5.isBetween(1, 2.5, needToBeEqual: true), true);
        },
      );
    });

    group('RubikNumberExtension.greaterThan', () {
      test(
        'should return true if the current value is greaterThan the value passed',
        () {
          expect(2.greaterThan(1), true);
          expect(0.greaterThan(1), false);
          expect(0.greaterThan(-1), true);
        },
      );

      test(
        'should return true if the current value is greaterThan or equal to the passed value',
        () {
          expect(21.greaterThan(21), false);
          expect(21.greaterThan(21, needToBeEqual: true), true);
        },
      );
    });

    group('RubikNumberExtension.pow', () {
      test('should  return value raised to the power of exponent', () {
        expect(0.pow(2), 0);
        expect(2.pow(2), 4);
        expect(4.pow(2), 16);
      });
    });

    group('RubikNumberExtension.toDegrees', () {
      test('should convert current value to degrees', () {
        expect(0.toDegrees, 0);
        expect(1.5707963267948966.toDegrees, 90);
        expect(3.141592653589793.toDegrees, 180);
        expect(6.283185307179586.toDegrees, 360);
      });
    });

    group('RubikNumberExtension.toRadians', () {
      test('should convert current value to radians', () {
        expect(0.toRadians, 0);
        expect(90.toRadians, 1.5707963267948966);
        expect(180.toRadians, 3.141592653589793);
        expect(360.toRadians, 6.283185307179586);
      });
    });

    group('RubikNumberExtension.roundToNearest', () {
      test('should round value to the nearest given number', () {
        expect(10.5.roundToNearest(5), equals(10));
        expect(11.0.roundToNearest(5), equals(10));
        expect(12.0.roundToNearest(5), equals(10));
        expect(12.5.roundToNearest(5), equals(15));
        expect(13.0.roundToNearest(5), equals(15));
        expect(13.5.roundToNearest(5), equals(15));
        expect(14.0.roundToNearest(5), equals(15));
      });
    });

    group('RubikNumberExtension.padLeft', () {
      test('should return string with padding of zero on the left added', () {
        expect(0.padLeft(), '00');
        expect(1.padLeft(), '01');

        expect(10.padLeft(width: 4), '0010');
        expect(1.padLeft(padding: '###'), '###1');
      });

      test('should return string with padding of zero on the right added', () {
        expect(0.padRight(), '00');
        expect(1.padRight(), '10');

        expect(10.padRight(width: 4), '1000');
        expect(1.padRight(padding: '###'), '1###');
      });
    });

    group('RubikNumberExtension.isZero', () {
      test('should return true if value is zero', () {
        expect(0.isZero, true);
        expect(1.isZero, false);
        expect(0.0.isZero, true);
        expect(0.1.isZero, false);
      });
    });

    group('RubikNumberExtension.toDuration', () {
      test('should convert number to milliseconds', () {
        const duration = Duration(milliseconds: 1500);
        expect(1500.toDuration(), equals(duration));
        expect(1500.toDuration(), equals(duration));
      });

      test('should convert number to microseconds', () {
        const type = RubikTimeUnit.microseconds;
        const duration = Duration(microseconds: 1500000);
        expect(1500000.toDuration(unit: type), equals(duration));
      });

      test('should convert number to seconds', () {
        const type = RubikTimeUnit.seconds;
        const duration = Duration(seconds: 30);
        expect(30.toDuration(unit: type), equals(duration));
      });

      test('should convert number to minutes', () {
        const type = RubikTimeUnit.minutes;
        const duration = Duration(minutes: 2);
        expect(2.toDuration(unit: type), equals(duration));
      });

      test('should convert number to hours', () {
        const type = RubikTimeUnit.hours;
        const duration = Duration(hours: 3);
        expect(3.toDuration(unit: type), equals(duration));
      });

      test('should convert number to days', () {
        const type = RubikTimeUnit.days;
        const duration = Duration(days: 7);
        expect(7.toDuration(unit: type), equals(duration));
      });
    });

    group('RubikNumberExtension.convertion', () {
      test('should convert number to duration in microseconds', () {
        const duration = Duration(microseconds: 200);
        expect(200.microseconds, equals(duration));
        expect(300.microseconds, equals(duration + 100.us));
        expect(400.microseconds, equals(duration + 200.microseconds));
      });

      test('should convert number to duration in milliseconds', () {
        const duration = Duration(milliseconds: 200);
        expect(200.milliseconds, equals(duration));
        expect(300.milliseconds, equals(duration + 100.ms));
        expect(400.milliseconds, equals(duration + 200.milliseconds));
      });

      test('should convert number to duration in seconds', () {
        const duration = Duration(seconds: 200);
        expect(200.seconds, equals(duration));
        expect(300.seconds, equals(duration + 100.s));
        expect(400.seconds, equals(duration + 200.seconds));
      });

      test('should convert number to duration in minutes', () {
        const duration = Duration(minutes: 200);
        expect(200.minutes, equals(duration));
        expect(300.minutes, equals(duration + 100.min));
        expect(400.minutes, equals(duration + 200.minutes));
      });

      test('should convert number to duration in hours', () {
        const duration = Duration(hours: 200);
        expect(200.hours, equals(duration));
        expect(300.hours, equals(duration + 100.h));
        expect(400.hours, equals(duration + 200.hours));
      });

      test('should convert number to duration in days', () {
        const duration = Duration(days: 200);
        expect(200.days, equals(duration));
        expect(300.days, equals(duration + 100.d));
        expect(400.days, equals(duration + 200.days));

        expect(1.5.days, const Duration(hours: 36));
        expect(2.4.d, const Duration(hours: 57, minutes: 36));
      });
    });

    group('RubikNumberExtension.toDateTime', () {
      test('should convert any number to datetime', () {
        final dateTime = 1680553403226.toDateTime;
        final expected = DateTime(2023, 4, 3, 17, 23, 23, 226);

        expect(dateTime, isA<DateTime>());
        expect(dateTime, expected);

        expect(1680553403226.565.toDateTime, expected);
        expect(0.toDateTime, DateTime(1969, 12, 31, 21, 00, 00));
      });
    });
  });
}
