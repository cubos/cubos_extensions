import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

void main() {
  group('RubikStringNames', () {
    group('RubikStringNames.fullName', () {
      test('should return full Name and sortName if is not empty', () {
        const name = RubikStringNames('Rubik', shortName: 'package');
        expect(name.fullName, 'Rubik');
        expect(name.shortName, 'package');

        expect(name.fullNameOrShortName, 'Rubik');
        expect(name.shortNameOrFullName, 'package');

        const name2 = RubikStringNames('Rubik');
        expect(name2.fullName, 'Rubik');
        expect(name2.shortName, isEmpty);
        expect(name2.fullNameOrShortName, 'Rubik');
        expect(name2.shortNameOrFullName, 'Rubik');
      });
    });

    group('RubikStringNames.sortName', () {
      test('should return full name and sort name separated by space', () {
        const name = RubikStringNames('Rubik', shortName: 'package');
        expect(name.joinWithSpace, 'Rubik package');

        const name2 = RubikStringNames('Rubik');
        expect(name2.joinWithSpace, 'Rubik ');
        expect(name2.hasAbbreviations, false);

        const toString = 'RubikStringNames(fullName: Rubik, shortName: '
            ', abbreviations: [])';
        expect(name2.toString(), toString);
      });
    });

    group('RubikStringNames.toAbbreviation', () {
      test('should return list of abbreviations', () {
        const name = RubikStringNames('Rubik', shortName: 'package');
        expect(name.toAbbreviation(), 'Rubik');

        const name2 = RubikStringNames('Rubik', abbreviations: ['R', 'P']);
        expect(name2.toAbbreviation(), 'R');
        expect(name2.toAbbreviation(1), 'P');
        expect(name2.toAbbreviation(31), 'R');
      });
    });
  });

  group('RubikRange', () {
    test('should create RubikRange empty', () {
      const range = RubikRange();
      expect([range.start, range.end], [0, 0]);

      const range2 = RubikRange.empty();
      expect([range2.start, range2.end], [0, 0]);

      expect(range.isEmpty, true);
      expect(range2.isEmpty, true);
    });
  });
}
