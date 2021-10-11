import 'package:cubos_extensions/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cubos_extensions/cubos_extensions.dart';

main() {
  group('StringExtensions', () {
    group('String.cleanCpf', () {
      test('Should transform 123.456.789-00 into 12345678900', () {
        final cpf = '123.456.789-00';
        final result = cpf.cleanCpf;

        expect(result, '12345678900');
      });
    });

    group('String.cleanPhone', () {
      test('Should transform (81) 99999-9999 into 81999999999', () {
        final phone = '(81) 99999-9999';
        final result = phone.cleanPhone;

        expect(result, '81999999999');
      });

      test('Should transform +55(81)99999-9999 into 5581999999999', () {
        final phone = '+55(81)99999-9999 ';
        final result = phone.cleanPhone;

        expect(result, '5581999999999');
      });
    });

    group('String.isNumeric', () {
      test('Should return false for a null string', () {
        final example = '';
        final result = example.isNumeric;

        expect(result, false);
      });

      test('Should return true if is a number string', () {
        final example = '987654';
        final result = example.isNumeric;

        expect(result, true);
      });

      test('Should return false if is a character string ', () {
        final example = 'character';
        final result = example.isNumeric;

        expect(result, false);
      });
    });

    group('String.capitalize', () {
      test("Should convert 'word' into 'Word'", () {
        final example = 'word';
        final result = example.capitalize;

        expect(result, 'Word');
      });

      test("Should convert 'another word' into 'Another word'", () {
        final example = 'another word';
        final result = example.capitalize;

        expect(result, 'Another word');
      });

      test("Should not brake if string is empty", () {
        final example = '';
        final result = example.capitalize;

        expect(result, '');
      });

      test("Should return 'A' for string 'a'", () {
        final example = 'a';
        final actual = example.capitalize;
        final matcher = 'A';

        expect(actual, matcher);
      });
    });

    group('String.hasUppercase', () {
      test("Should return false if the string contains a uppercase letter", () {
        final example = 'Word';
        final result = example.hasUppercase;

        expect(result, true);
      });

      test("Should return false if the string not contains a uppercase letter",
          () {
        final example = 'word';
        final result = example.hasUppercase;

        expect(result, false);
      });

      final verifyer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      final range = verifyer.length;

      for (var i = 0; i < range; i++) {
        test(
            'Verify if the function hasUpperCase return true within range [A-Z] - ${verifyer[i]}',
            () {
          final example = '${verifyer[i]}word';
          final result = example.hasUppercase;

          expect(result, true);
        });
      }
    });

    group('String.hasLowercase', () {
      test("Should return true if the string contains a lowercase letter", () {
        final example = 'wORD';
        final result = example.hasLowercase;

        expect(result, true);
      });

      test("Should return false if the string not contains a lowercase letter",
          () {
        final example = 'WORD';
        final result = example.hasLowercase;

        expect(result, false);
      });

      final verifyer = 'abcdefghijklmnopqrstuvxwyz';
      final range = verifyer.length;

      for (var i = 0; i < range; i++) {
        test(
            'Verify if the function hasLowerCase returns true within range [a-z] - ${verifyer[i]}',
            () {
          final example = '${verifyer[i]}word';
          final result = example.hasLowercase;

          expect(result, true);
        });
      }
    });

    group('String.hasLetter', () {
      test("Should return true if the string contains a letter", () {
        final example = 'a123456';
        final result = example.hasLetter;

        expect(result, true);
      });

      test("Should return false if the string not contains a letter", () {
        final example = '123456';
        final result = example.hasLetter;

        expect(result, false);
      });

      final verifyer = 'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ';
      final range = verifyer.length;

      for (var i = 0; i < range; i++) {
        test(
            'Verify if the funcition hasLetter returns true within range [a-z][A-Z] - ${verifyer[i]}',
            () {
          final example = '${verifyer[i]}word';
          final result = example.hasLetter;

          expect(result, true);
        });
      }
    });

    group('String.hasDigits', () {
      test("Should return true if the string contains digits", () {
        final example = '1word';
        final result = example.hasDigits;

        expect(result, true);
      });

      test("Should return false if the string not contains digits", () {
        final example = 'word';
        final result = example.hasDigits;

        expect(result, false);
      });

      final verifyer = '0123456789';
      final range = verifyer.length;

      for (var i = 0; i < range; i++) {
        test(
            'Verify if the funcition hasDigits returns true within range [0-9] - ${verifyer[i]}',
            () {
          final example = '${verifyer[i]}word';
          final result = example.hasDigits;

          expect(result, true);
        });
      }
    });

    group('String.hasSpecialCharacters', () {
      test("Should return true if the string contains special characters", () {
        final example = '&word';
        final result = example.hasSpecialCharacters;

        expect(result, true);
      });

      test("Should return false if the string not contains special characters",
          () {
        final example = 'word';
        final result = example.hasSpecialCharacters;

        expect(result, false);
      });

      final verifyer = '[!@#\$%^&*(),.?":{}|<>_+=]';
      final range = verifyer.length;

      for (var i = 0; i < range; i++) {
        test(
            'Verify if the funcition hasSpecialCharacters returns true within range [!@#\$%^&*(),.?":{}|<>_+=] - ${verifyer[i]}',
            () {
          final example = '${verifyer[i]}word';
          final result = example.hasSpecialCharacters;

          expect(result, true);
        });
      }
    });

    group('String.toDateTimeStr', () {
      test(
          "Should convert format 'yyyy-mm-dd hh:mm:ss.SSSS' into 'dd/mm/yyyy' ",
          () {
        DateTime example = new DateTime(2020, 4, 11, 0, 0, 0, 0, 0);
        final result = example.toDateTimeStr;

        expect(result, '11/04/2020');
      });

      test("Should convert DateTime type into String type", () {
        DateTime example = new DateTime(2020, 4, 11, 0, 0, 0, 0, 0);
        var result = false;

        if (example.toDateTimeStr is String) {
          result = true;
        }

        expect(result, true);
      });
    });

    group('String.toInt', () {
      test('Should return int number', () {
        final input = '1234';
        final actual = input.toInt;
        final expected = 1234;

        expect(actual, expected);
      });

      test('Should return for empty value', () {
        final input = '';
        final actual = input.toInt;
        final expected = null;

        expect(actual, expected);
      });

      test('Should return null for non numeric value', () {
        final input = '1123h';
        final actual = input.toInt;
        final expected = null;

        expect(actual, expected);
      });
    });

    group('String.capitalizeWords()', () {
      test("Returns Posto das Margaridas", () {
        final input = 'POSTO DAS MARGARIDAS';
        final expected = 'Posto das Margaridas';
        final actual = input.capitalizeWords;

        expect(actual, expected);
      });

      test("Returns Posto O Rei da Pamonha", () {
        final input = 'POSTO o rei da pamonha';
        final expected = 'Posto O Rei da Pamonha';
        final actual = input.capitalizeWords;

        expect(actual, expected);
      });

      test("Returns Posto BR 123", () {
        final input = 'posto br 123';
        final expected = 'Posto BR 123';
        final actual = input.capitalizeWords;

        expect(actual, expected);
      });
    });

    group('String.firstName', () {
      test("Returns the first name capitalized", () {
        final input = 'Danilo Rêgo';
        final expected = 'Danilo';
        final actual = input.firstName;

        expect(actual, expected);
      });

      test("Returns empty string", () {
        final input = '';
        final expected = '';
        final actual = input.firstName;

        expect(actual, expected);
      });

      test("Returns null string for null values", () {
        final input = null;
        final expected = null;
        final actual = input?.firstName;

        expect(actual, expected);
      });
    });

    group('String.toDateTime', () {
      test("Parse 2020-09-12 into DateTime", () {
        final input = '2020-09-12';
        final expected = DateTime(2020, 09, 12);
        final actual = input.toDateTime;

        expect(actual, expected);
      });

      test("Return null for null input", () {
        final input = '';
        final expected = null;
        final actual = input.toDateTime;

        expect(actual, expected);
      });
    });
  });

  group('DateTimeExtensions', () {
    group('DateTime.toIsoStr', () {
      test(
          "Should convert format 'yyyy-mm-dd hh:mm:ss.SSSS' into 'yyyy-mm-dd' ",
          () {
        DateTime example = new DateTime(2020, 4, 11, 0, 0, 0, 0, 0);
        final result = example.toIsoStr;

        expect(result, '2020-04-11');
      });

      test("Should convert DateTime type into String type", () {
        DateTime example = new DateTime(2020, 4, 11, 0, 0, 0, 0, 0);
        var result = false;

        if (example.toIsoStr is String) {
          result = true;
        }

        expect(result, true);
      });
    });

    group('DateTime.subtractYears', () {
      test("Should subtract 10 years from the date '2020-04-11 00:00:00.000'",
          () {
        DateTime example = new DateTime(2020, 4, 11);
        final result = example.subtractYears(10);
        final match = new DateTime(2010, 4, 11);

        expect(result, match);
      });

      test("Should subtract 0 years from the date '2020-04-11 00:00:00.000'",
          () {
        DateTime example = new DateTime(2020, 4, 11);
        final result = example.subtractYears(0);
        final match = new DateTime(2020, 4, 11);

        expect(result, match);
      });

      test("Should subtract 43 years from the date '2018-03-04 00:00:00.000'",
          () {
        DateTime example = new DateTime(2018, 3, 4);
        final result = example.subtractYears(43);
        final match = new DateTime(1975, 3, 4);

        expect(result, match);
      });
    });

    group('DateTime.toCompleteDateStr()', () {
      test("Returns 12 de Abril de 2020", () {
        final input = DateTime(2020, 04, 12);
        final expected = '12 de Abril de 2020';
        final actual = input.toCompleteDateStr;

        expect(actual, expected);
      });
    });

    group('DateTime.toMonthStr()', () {
      test("Returns month name in April", () {
        final input = DateTime(2020, 04, 12);
        const expected = 'Abril';
        final actual = input.toMonthStr;

        expect(actual, expected);
      });

      test("Returns the abbreviated name of the month in April", () {
        final input = DateTime(2020, 04, 12);
        const expected = 'Abr';
        final actual = input.toMonthAbbreviationStr;

        expect(actual, expected);
      });

      test("Returns weekday using suffixe market", () {
        final input = DateTime(2021, 10, 12);
        final expected = weekDaysInPortuguesePtBR[2];
        final actual = input.toWeekdayStr();

        expect(actual, expected);
      });

      test("Returns weekday using suffixe market", () {
        final input = DateTime(2021, 10, 12);
        final expected = 'Terça';
        final actual = input.toWeekdayStr(false);

        expect(actual, expected);
      });
    });
  });

  group('ListExtensions', () {
    group('List.lastIndex', () {
      test('Should return the index of the last element from the list', () {
        List<int> example = [4, 6, 7, 0, 12];
        final result = example.lastIndex;

        expect(result, 4);
      });

      test('Should return -1 if the list is empty', () {
        List<int> example = [];
        final result = example.lastIndex;

        expect(result, -1);
      });

      test('Should return index equal to 0 if the list have only one element',
          () {
        List<int> example = [10];
        final result = example.lastIndex;

        expect(result, 0);
      });
    });

    group('List.copyOf', () {
      test('Should return a new list with the same elements of the old list',
          () {
        List<int> example = [4, 6, 7, 0, 12, 2, 13, 45, 67, 84, 9, 112];
        final result = example.copyOf(12);
        final List<int> match = [4, 6, 7, 0, 12, 2, 13, 45, 67, 84, 9, 112];

        expect(result, match);
      });

      test(
          'Should return a new list with less elements but keeping all values from the old list',
          () {
        List<int> example = [4, 6, 7, 0, 12, 2, 13, 45, 67, 84, 9, 112];
        final result = example.copyOf(5);
        final List<int> match = [4, 6, 7, 0, 12];

        expect(result, match);
      });

      test(
          'Should return a new list with more elements than the old list and all new elemens should be equal to 0',
          () {
        List<int> example = [4, 6, 7, 0, 12, 2, 13, 45, 67, 84, 9, 112];
        final result = example.copyOf(16);
        final List<int> match = [
          4,
          6,
          7,
          0,
          12,
          2,
          13,
          45,
          67,
          84,
          9,
          112,
          0,
          0,
          0,
          0
        ];

        expect(result, match);
      });
    });

    group('List.removeLastWhere', () {
      test('Should remove the last element where length equal to 2', () {
        List<String> example = ['a', 'ab', 'cd', 'efg'];
        final List<String> match = ['a', 'ab', 'efg'];

        example.removeLastWhere((element) => element.length == 2);

        expect(example, match);
      });

      test('Should remove the last empty element', () {
        List<String> example = ['a', 'ab', '', 'efg', ''];
        final List<String> match = ['a', 'ab', '', 'efg'];

        example.removeLastWhere((element) => element.isEmpty);

        expect(example, match);
      });

      test('Should remove the last element where value equal to 4', () {
        final List<int> example = [1, 2, 3, 4, 1, 4, 7, 8];
        final List<int> match = [1, 2, 3, 4, 1, 7, 8];

        example.removeLastWhere((element) => element == 4);

        expect(example, match);
      });

      test(
          'When used removeLastWhere on a fixed-length list should return a Unsupported Error',
          () {
        final List<int> example = new List.unmodifiable([3, 1]);

        expect(() => example.removeLastWhere((element) => element == 3),
            throwsUnsupportedError);
      });
    });

    group('Sum', () {
      test('Should sum all elements on the list', () {
        List<int> example = [4, 6, 7, 0, 12];
        final result = example.integerSum;

        expect(result, 29);
      });

      test('Should sum all elements on the list', () {
        List<double> example = [4, 6, 7, 0, 12];
        final result = example.floatSum;

        expect(result, 29);
      });
    });

    group('List.isNullOrEmpty', () {
      test('Returns true for null list', () {
        final List<dynamic>? input = null;
        final result = input.isNullOrEmpty;
        final expectedResult = true;

        expect(result, expectedResult);
      });

      test('Returns true for empty list', () {
        final List<dynamic> input = [];
        final result = input.isNullOrEmpty;
        final expectedResult = true;

        expect(result, expectedResult);
      });

      test('Returns false for not empty list, even if its values are null', () {
        final List<dynamic> input = [null];
        final result = input.isNullOrEmpty;
        final expectedResult = false;

        expect(result, expectedResult);
      });
    });
  });

  group('DurationExtentions', () {
    group('Duration.toTimeStr', () {
      test("Returns 5:21", () {
        final input = Duration(minutes: 5, seconds: 21, milliseconds: 600);
        final expected = '5:21';
        final actual = input.toTimeStr;

        expect(actual, expected);
      });
    });
  });
}
