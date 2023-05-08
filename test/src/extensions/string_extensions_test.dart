import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/extensions/string_extensions.dart';
import 'package:rubik_utils/src/types/rubik_types.dart';

void main() {
  group('RubikStringExtensions:', () {
    group('RubikStringExtensions.digitsOnly', () {
      test('should clear string by removing all non-numeric charactersr', () {
        expect(''.digitsOnly(), '');
        expect('1&2@6#88:?>'.digitsOnly(), '12688');
        expect('3a8-c5ffa bd-b4 11ed'.digitsOnly(true), '385 4 11');
        expect('96-bdb7-11ed-afa1-0242ac120'.digitsOnly(), '9671110242120');
      });
    });

    group('RubikStringExtensions.withoutDigits', () {
      test('should clear string by removing all digits', () {
        expect(''.withoutDigits(), '');
        expect('abc123xyz456'.withoutDigits(), 'abcxyz');
        expect('abc1#\$%tyop'.withoutDigits(), 'abc#\$%tyop');
      });

      test('should clear string by removing specialCharacters', () {
        expect(''.withoutDigits(), '');
        expect('ab@c123xyz456\$'.withoutDigits(true), 'abcxyz');
        expect('abc1#\$%tyop 13213aqes'.withoutDigits(true), 'abctyop aqes');
      });
    });

    group('RubikStringExtensions.cleanCpf', () {
      test('should transform 123.456.789-00 into 12345678900', () {
        expect('123.456.789-00'.cleanCpf, '12345678900');
        expect('123456789-00'.cleanCpf, '12345678900');
      });
    });

    group('RubikStringExtensions.cleanCnpj', () {
      test('should transform 45.487.645/0001-39 into 45487645000139', () {
        expect('45487645/0001-39'.cleanCnpj, '45487645000139');
        expect('45.487.645/0001-39'.cleanCnpj, '45487645000139');
      });
    });

    group('RubikStringExtensions.cleanPhone', () {
      test('should transform (81) 99999-9999 into 81999999999', () {
        const phone = '(81) 99999-9999';
        final result = phone.cleanPhone;

        expect(result, '81999999999');
      });

      test('should transform +55(81)99999-9999 into 5581999999999', () {
        const phone = '+55(81)99999-9999 ';
        final result = phone.cleanPhone;

        expect(result, '5581999999999');
      });
    });

    group('RubikStringExtensions.cleanZipCode', () {
      test('should transform 45810-000 into 45810000', () {
        const zipcode = '45810-000';
        final result = zipcode.cleanZipCode;

        expect(result, '45810000');
      });
    });

    group('RubikStringExtensions.isNumeric', () {
      test('should return true if is a number string', () {
        expect(''.isNumeric, false);
        expect('00'.isNumeric, true);
        expect('987654'.isNumeric, true);
        expect('10.67'.isNumeric, true);
        expect('10,67'.isNumeric, true);
      });

      test('should return false if is a character string ', () {
        expect('Abc123'.isNumeric, false);
        expect('4500,67'.isNumeric, true);
        expect('434.000,67'.isNumeric, true);
        expect('1304045,67'.isNumeric, true);
        expect('1.000.000,67'.isNumeric, true);
        expect('1as%\$%dasdsadas.000.000,67'.isNumeric, false);
      });
    });

    group('RubikStringExtensions.capitalize', () {
      test('should convert "word" into "Word" ', () {
        expect(''.capitalize, '');
        expect('a'.capitalize, 'A');
        expect('word'.capitalize, 'Word');
        expect('another word'.capitalize, 'Another word');
      });
    });

    group('RubikStringExtensions.capitalizeWords', () {
      test('should convert "mr. john wick" into "Mr. John Wick" ', () {
        expect(''.capitalizeWords, '');
        expect('mr. john wick'.capitalizeWords, 'Mr. John Wick');
        expect('Lorem ipsum dolor'.capitalizeWords, 'Lorem Ipsum Dolor');
      });
    });

    group('RubikStringExtensions.name', () {
      test('should convert "john wick" into "John" ', () {
        expect(''.firstName, '');
        expect('john wick'.firstName, 'John');
        expect('Lorem ipsum dolor'.firstName, 'Lorem');
      });

      test('should convert "john wick json" into "John Wick" ', () {
        expect(''.socialName, '');
        expect('john'.socialName, 'John');
        expect('john wick json'.socialName, 'John Json');
        expect('Marcos Vinicius Santos Fernandes'.socialName, 'Marcos Santos');
      });
      test('should convert "john wick json" into "Json"', () {
        expect(''.lastName, '');
        expect('john wick json'.lastName, 'Json');
        expect('Marcos Vinicius Fernandes André'.lastName, 'André');
      });
    });

    group('RubikStringExtensions.lastChars', () {
      test(
        'should return the last [N] characters of a RubikStringExtensions.',
        () {
          expect(''.lastChars(), '');
          expect('john wick'.lastChars(34), 'john wick');
          expect('john wick'.lastChars(2), 'ick');
          expect('Lorem ipsum dolor'.lastChars(4), 'dolor');
        },
      );
    });

    group('RubikStringExtensions.hasUppercase', () {
      test('should return false if the string contains a uppercase letter', () {
        expect('Word'.hasUppercase, true);
        expect('word'.hasUppercase, false);
      });

      test('should return true within the range [A-Z] hasUpperCase', () {
        final verifyer = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
        final range = verifyer.map((char) => '$char word');

        expect(range.any((it) => it.hasUppercase), true);
      });
    });

    group('RubikStringExtensions.hasLowercase', () {
      test('should return false if the string contains a lowercase letter', () {
        expect('Word'.hasLowercase, true);
        expect('WORD'.hasLowercase, false);
      });

      test('should return true within the range [A-Z] hasLowercase', () {
        final verifyer = 'abcdefghijklmnopqrstuvxwyz'.split('');
        final range = verifyer.map((char) => '$char WORD');

        expect(range.any((it) => it.hasLowercase), true);
      });
    });

    group('RubikStringExtensions.hasLetter', () {
      test('should return true if the string contains a letter', () {
        expect('a123s456'.hasLetter, true);
        expect('123456@#'.hasLetter, false);
      });

      test('should return true within the range [a-z][A-Z] hasLetter', () {
        const verifyer = 'aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ';
        final range = verifyer.split('').map((char) => '$char 123');

        expect(range.any((it) => it.hasLetter), true);
      });
    });

    group('RubikStringExtensions.hasDigits', () {
      test('should return true if the string contains digits', () {
        expect('1word'.hasDigits, true);
        expect('1wo2r3d'.hasDigits, true);
        expect('word@\$'.hasDigits, false);
      });

      test('should return true within the range [0-9] hasDigits', () {
        final verifyer = '0123456789'.split('').map((char) => '$char word');
        final result = verifyer.any((it) => it.hasDigits);

        expect(result, true);
      });
    });

    group('RubikStringExtensions.hasSpecialCharacters', () {
      test('should return true if the string contains special characters', () {
        expect('&wo#rd'.hasSpecialCharacters, true);
        expect('&wor%%@d'.hasSpecialCharacters, true);
        expect('word122word'.hasSpecialCharacters, false);
      });

      test(
        'should return true within the range [!@#\$%^&*(),.?\':{}|<>_+=] hasSpecialCharacters',
        () {
          final verifyer = '[!@#\$%^&*(),.?\':{}|<>_+=]'.split('');
          final range = verifyer.map((char) => '$char word');

          expect(range.any((it) => it.hasSpecialCharacters), true);
        },
      );
    });

    group('RubikStringExtensions.toDateTime', () {
      final dateFormats = [
        'yyyy-mm-dd',
        'yyyy/mm/dd',
        'dd-mm-yyyy',
        'dd/mm/yyyy',
      ];

      test('should convert format $dateFormats into DateTime', () {
        expect(''.toDateTime, isNull);
        expect('2023-03-09'.toDateTime, isNotNull);
        expect('2023/03/09'.toDateTime, isNotNull);

        expect('09-03-2023'.toDateTime, isNotNull);
        expect('09/03/2023'.toDateTime, isNotNull);
      });

      test('should convert String to DateTime type', () {
        expect('2023-03-09'.toDateTime, isA<DateTime>());
        expect('2023-03-09'.toDateTime, DateTime(2023, 03, 09));
        expect('2023/03/10'.toDateTime, DateTime(2023, 03, 10, 00, 00));

        final actual = DateTime(2023, 03, 10, 11, 54, 06, 00);
        expect('2023-03-10 11:54:06.00'.toDateTime, actual);
        expect('2023/03/10 11:54:06.00'.toDateTime, actual);
        expect('2023-03-10 00:00:00.00'.toDateTime, DateTime(2023, 03, 10));

        const strDate = '2023-05-03 11:09:13.728995';
        final expected = DateTime(2023, 05, 03, 11, 09, 13, 728, 995);

        expect(strDate.toDateTime, expected);
      });
    });

    group('RubikStringExtensions.toInt', () {
      test('should return int number', () {
        expect(''.toInt, isNull);
        expect('1234'.toInt, 1234);
        expect('1123h'.toInt, isNull);
        expect('1234'.toInt, isA<int>());
      });
    });

    group('RubikStringExtensions.toDouble', () {
      test('should return double number', () {
        expect(''.toDouble, isNull);
        expect('12.34'.toDouble, 12.34);
        expect('11.23h'.toDouble, isNull);
        expect('12.34'.toDouble, isA<double>());
      });
    });

    group('RubikStringExtensions.isCpf', () {
      test('should return true if string is CPF', () {
        expect(''.isCpf(), false);
        expect('1234'.isCpf(), false);

        expect('12345678990'.isCpf(), true);
        expect('123.456.789-90'.isCpf(true), true);
      });
    });

    group('RubikStringExtensions.isCnpj', () {
      test('should return true if string is CNPJ', () {
        expect(''.isCnpj(), false);
        expect('1234'.isCnpj(), false);

        expect('13528652000145'.isCnpj(), true);
        expect('13528652000145'.isCnpj(true), false);
        expect('13.528.652/0001-45'.isCnpj(true), true);
      });
    });

    group('RubikStringExtensions.isCpfOrCnpj', () {
      test('should return true if string is Cpf or Cnpj', () {
        expect(''.isCpfOrCnpj(), false);
        expect('1234'.isCpfOrCnpj(), false);

        expect('36839395000168'.isCpfOrCnpj(), true);
        expect('123.456.789-90'.isCpfOrCnpj(true), true);
      });
    });

    group('RubikStringExtensions.noNBSP', () {
      test('should return string without NBSP', () {
        expect(''.noNBSP, '');
        expect('1234'.noNBSP, '1234');
        expect('1234 '.noNBSP, '1234');
      });
    });

    group('RubikStringExtensions.toDuration', () {
      test('should return Duration', () {
        expect(''.toDuration, Duration.zero);
        expect('1234'.toDuration, Duration.zero);
        expect('1234'.toDuration, Duration.zero);

        expect('00:00:00'.toDuration, const Duration());
        expect('00:00:01'.toDuration, const Duration(seconds: 1));
        expect('00:01:00'.toDuration, const Duration(minutes: 1));
        expect('01:00:00'.toDuration, const Duration(hours: 1));

        const expected = Duration(hours: 1, minutes: 1, seconds: 1);
        expect('01:01:01'.toDuration, expected);
      });
    });

    group('RubikStringExtensions.toBool', () {
      test('should return bool', () {
        expect(''.toBool, isFalse);
        expect('1234'.toBool, isFalse);
        expect('false'.toBool, isFalse);
        expect('FALSE'.toBool, isFalse);

        expect('true'.toBool, isTrue);
        expect('True'.toBool, isTrue);
        expect('TRUE'.toBool, isTrue);
      });
    });

    group('RubikStringExtensions.toBase64', () {
      test('should return base64 string', () {
        expect(''.toBase64, '');
        expect('1234'.toBase64, 'MTIzNA==');
        expect('1234'.toBase64, isA<String>());
      });
    });

    group('RubikStringExtensions.fromBase64', () {
      test('should return base64 string', () {
        expect(''.fromBase64, '');
        expect('MTIzNA=='.fromBase64, '1234');
        expect('MTIzNA=='.fromBase64, isA<String>());
      });
    });

    group('RubikStringExtensions.format', () {
      test('should return formatted string', () {
        expect(''.format([]), '');
        expect('{} 1234'.format(['digitos:']), 'digitos: 1234');
        expect('Hello {}!'.format(['World']), 'Hello World!');

        expect(
          'For only {} dollars!'.format([49.0]),
          'For only 49.0 dollars!',
        );
      });
    });

    group('RubikStringExtensions.safeSubstring', () {
      test('should return substring', () {
        expect(''.safeSubstring(0, 1), '');
        const String dartlang = 'dartlang';

        expect(dartlang.safeSubstring(0, 4), 'dart');
        expect(dartlang.safeSubstring(4, 0), 'trad');

        expect(dartlang.safeSubstring(-1, -4), 'art');
        expect(dartlang.safeSubstring(-4, -1), 'tra');
      });
    });

    group('RubikStringExtensions.toEditingValue', () {
      test('should return a TextEditingValue', () {
        final atual = '123'.toEditingValue;
        expect(atual, isA<TextEditingValue>());
        expect(atual.text, '123');
      });
    });

    group('RubikStringExtensions.formatCPFCNPJ', () {
      test('should format CPF correctly', () {
        expect(''.formatCPF, '');
        expect('1234'.formatCPF, '1234');
        expect('12345678909'.formatCPF, '123.456.789-09');
        expect('123.456.789-09'.formatCPF, '123.456.789-09');
      });

      test('should format CNPJ correctly', () {
        expect('45487645000139'.formatCNPJ, '45.487.645/0001-39');
        expect('93357546000185'.formatCNPJ, '93.357.546/0001-85');
      });

      test('should format CPJ or CNPJ correctly', () {
        expect('12345678909'.formatCPFCNPJ, '123.456.789-09');
        expect('123.456.789-09'.formatCPFCNPJ, '123.456.789-09');
        expect('45487645000139'.formatCPFCNPJ, '45.487.645/0001-39');
        expect('93357546000185'.formatCPFCNPJ, '93.357.546/0001-85');
      });
    });

    group('RubikStringExtensions.formatCPFCNPJ', () {
      test('should format phone number', () {
        expect('12345678'.formatPhone, '1234-5678');
        expect('999999999'.formatPhone, '99999-9999');
        expect('1987654321'.formatPhone, '(01) 98765-4321');
        expect('11987654321'.formatPhone, '(11) 98765-4321');
        expect('5511987654321'.formatPhone, '+55 (11) 98765-4321');
        expect('123456789012'.formatPhone, '+1 (23) 45678-9012');
      });
    });

    group('RubikStringExtensions.toList', () {
      test('should convert string to list', () {
        expect(''.toList(), []);
        expect('1234'.toList(), ['1', '2', '3', '4']);
        expect('dart'.toList(), ['d', 'a', 'r', 't']);
      });

      test('should convert to list using replace', () {
        expect('12/34/22-34'.toList('/'), ['12', '34', '22-34']);
        expect('12/34/22-34'.toList('-', '/'), isA<List<String>>());
        expect('12/34/22-34'.toList('-', '/'), ['12', '34', '22', '34']);
      });
    });

    group('RubikStringExtensions.reversed', () {
      test('should return reversed string', () {
        expect(''.reversed, '');
        expect('1234'.reversed, '4321');
        expect('1234567890'.reversed, '0987654321');
      });
    });

    group('RubikStringExtensions.toReversedList', () {
      test('should return reversed list', () {
        expect(''.toReversedList, []);
        expect('1234'.toReversedList, ['4', '3', '2', '1']);
        expect('dart'.toReversedList, ['t', 'r', 'a', 'd']);
      });
    });

    group('RubikStringExtensions.maskObscuredCPF', () {
      test('should replace CPF with asterisks', () {
        expect(''.maskObscuredCPF(), isEmpty);
        expect('12345'.maskObscuredCPF(), '12345');
        expect('123456789091312'.maskObscuredCPF(), '123456789091312');

        expect('12345678909'.maskObscuredCPF(), '***.456.789-**');
        expect('123.456.789-09'.maskObscuredCPF(), '***.456.789-**');
      });

      test('should return current value if range is invalid', () {
        const end = RubikRange(start: 6, end: 96, mask: '***');
        const start = RubikRange(start: 4, end: 7, mask: '***');
        expect('123.456.789-09'.maskObscuredCPF(start, end), '123.***.789-09');

        const end2 = RubikRange(start: 44, end: 44, mask: '***');
        const start2 = RubikRange(start: 44, end: 44, mask: '***');
        expect(
          '123.456.789-09'.maskObscuredCPF(start2, end2),
          '123.456.789-09',
        );
      });
    });
  });
}
