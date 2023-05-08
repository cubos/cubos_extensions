import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/constants/rubik_strings.dart';
import 'package:rubik_utils/src/types/rubik_types.dart';

void main() {
  group('RubikStrings', () {
    group('RubikStrings.defaultLocale', () {
      test('should return true if default locale is pt_BR', () {
        const locale = RubikStrings.defaultLocale;
        expect(locale == 'en', equals(false));
        expect(locale == 'pt_BR', equals(true));
      });

      test('should return empty map to locale de_CH', () {
        final weekdays = RubikStrings.weekdaysByLocale(locale: 'de_CH');

        expect(weekdays, isA<Map>());
        expect(weekdays, isEmpty);
      });
    });

    group('RubikStrings.weekdaysByLocale', () {
      test('sould return weekdays map to locale pt_BR', () {
        final weekdays = RubikStrings.weekdaysByLocale();

        expect(weekdays, isA<Map>());
        expect(weekdays, isNotEmpty);
        expect(weekdays.length, 7);

        final saturday = weekdays[DateTime.saturday];
        expect(saturday, isNotNull);
        expect(saturday, isA<RubikStringNames>());

        expect(saturday!.shortName, 'Sáb');
        expect(saturday.fullName, 'Sábado');
      });

      test('sould return weekdays map to locale en', () {
        final weekdays = RubikStrings.weekdaysByLocale(locale: 'en');

        expect(weekdays, isA<Map>());
        expect(weekdays, isNotEmpty);
        expect(weekdays.length, 7);

        final saturday = weekdays[DateTime.saturday];
        expect(saturday, isNotNull);
        expect(saturday, isA<RubikStringNames>());

        expect(saturday!.shortName, 'Sat');
        expect(saturday.fullName, 'Saturday');
      });
    });

    group('RubikStrings.abbreviation', () {
      test('should return RubikUtils abbreviation name', () {
        const name = RubikStringNames('Rubik', abbreviations: ['RubikUtils']);
        expect(name.toAbbreviation(), 'RubikUtils');

        const name2 = RubikStringNames('Rubik');
        expect(name2.toAbbreviation(), 'Rubik');
      });
    });
  });
}
