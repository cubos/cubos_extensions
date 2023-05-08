import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

void main() {
  group('RubikTextEditingValueExtension', () {
    group('RubikTextEditingValueExtension.digitsOnly', () {
      test('should return digits only', () {
        expect('A1B2C3D4'.toEditingValue.digitsOnly, '1234');
        expect('a1b2c3d4'.toEditingValue.digitsOnly, '1234');
      });
    });

    group('RubikTextEditingValueExtension.replaceAll', () {
      test('should replace all', () {
        final pattern = RubikRegExps.digitsOnlyRegex;

        final actual = 'A1B2C3D4'.toEditingValue;
        expect(actual.replaceAll(pattern, ''), '1234');

        final actual2 = 'a1b2c3d4'.toEditingValue;
        expect(actual2.replaceAll(pattern, ''), '1234');
      });
    });

    group('RubikTextEditingValueExtension.isNumeric', () {
      test('should return true when text is numeric', () {
        expect('1234567890'.toEditingValue.isNumeric(), isTrue);
        expect('1234567890a'.toEditingValue.isNumeric(), isFalse);
      });

      test('should return true when text is numeric with RegExp', () {
        final pattern = RubikRegExps.digitsOnlyRegex;

        final actual = 'A1B2C3D4'.toEditingValue.isNumeric(pattern, '');
        expect(actual, isTrue);

        final actual2 = 'a1b2c3d4'.toEditingValue.isNumeric(pattern, '');
        expect(actual2, isTrue);
      });
    });

    group('RubikTextEditingValueExtension.length', () {
      test('should return length of text editing value', () {
        expect('1234567890'.toEditingValue.length(), 10);
        expect('1234567890a'.toEditingValue.length(), 11);
      });

      test(
        'should return length of text editing value removing non digits',
        () {
          expect('A1B2C3D4'.toEditingValue.length(true), 4);
          expect('a1b2c3d4e5'.toEditingValue.length(true), 5);
        },
      );
    });

    group('RubikTextEditingValueExtension.isDeletingText', () {
      test('should return true if is deleting text', () {
        final oldValue = 'dartlang'.toEditingValue;
        expect(oldValue.isDeletingText('dartlan'.toEditingValue), isTrue);

        final oldValue2 = 'dartlan'.toEditingValue;
        expect(oldValue2.isDeletingText('dartlang'.toEditingValue), isFalse);
      });
    });
  });
}
