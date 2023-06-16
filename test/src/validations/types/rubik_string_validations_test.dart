import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/validations/rubik_validator.dart';

TypeMatcher<String> get isString => isA<String>();

void main() {
  group('RubikStringRString.validations', () {
    test('RString.required', () {
      expect(RString().required().validate(''), isString);
      expect(RString().required().validate({}), isString);
      expect(RString().required().validate([]), isString);
      expect(RString().required().validate(' '), isString);
      expect(RString().required().validate(null), isString);

      expect(RString().required().validate(10), isNull);
      expect(RString().required().validate(false), isNull);
      expect(RString().required().validate('hello'), isNull);
      expect(RString().required(message: 'is Null').validate(null), 'is Null');
    });

    test('RString.minLength', () {
      expect(RString().minLength(1).validate(null), isString);
      expect(RString().minLength(1).validate(false), isString);

      expect(RString().minLength(3).validate(''), isString);
      expect(RString().minLength(3).validate('tes'), isNull);
      expect(
        RString().minLength(3, includeEquals: false).validate('tes'),
        isString,
      );

      const message = 'invalid_minLength';
      expect(
        RString().minLength(2, message: message).validate('test'),
        message,
      );
    });

    test('RString.maxLength', () {
      expect(RString().maxLength(1).validate(null), isString);
      expect(RString().maxLength(1).validate(false), isString);

      expect(RString().maxLength(3).validate(''), isString);
      expect(RString().maxLength(3).validate('tes'), isNull);
      expect(
        RString().maxLength(3, includeEquals: false).validate('tes'),
        isString,
      );

      const message = 'invalid_maxLength';
      expect(
        RString().maxLength(2, message: message).validate('test'),
        message,
      );
    });

    test('RString.length', () {
      expect(RString().length(4).validate(''), isString);
      expect(RString().length(4).validate(null), isString);
      expect(RString().length(4).validate(false), isString);
      expect(RString().length(4).validate('abcd'), isNull);
      expect(RString().length(4).validate('test'), isNull);

      const message = 'invalid_length';
      expect(RString().length(5, message: message).validate('test'), message);
    });

    test('RString.email', () {
      const String email = 'example@example.example';

      expect(RString().email().validate(''), isString);
      expect(RString().email().validate(null), isString);
      expect(RString().email().validate(false), isString);
      expect(RString().email().validate(email), isNull);

      const message = 'invalid_email';
      expect(RString().email(message: message).validate('test'), message);
    });

    test('RString.match', () {
      const digAndLetters = r'^[a-zA-Z0-9]+$';
      expect(RString().match(digAndLetters).validate('55aaA'), isNull);
      expect(RString().match(digAndLetters).validate('abCDe'), isNull);
      expect(RString().match(digAndLetters).validate('5A^]&'), isString);

      const message = 'invalid_match';
      final match = RString().match(digAndLetters, message: message);
      expect(match.validate('5A^]&'), message);
    });

    test('RString.creditCard', () {
      expect(RString().creditCard().validate(''), isString);
      expect(RString().creditCard().validate(null), isString);
      expect(RString().creditCard().validate('5350 0719'), isString);
      expect(RString().creditCard().validate('535007197302'), isString);
      expect(RString().creditCard().validate('5350.0719.7302'), isString);

      expect(RString().creditCard().validate('5350 0719 7302 8604'), isNull);
      expect(RString().creditCard().validate('5350.0719.7302.8604'), isNull);
      expect(RString().creditCard().validate('5350-0719-7302-8604'), isNull);

      const message = 'invalid_credit_card';
      final creditCard = RString().creditCard(message: message);
      expect(creditCard.validate('5350 0719'), message);
    });

    test('RString.cpf', () {
      expect(RString().cpf().validate(''), isString);
      expect(RString().cpf().validate(null), isString);
      expect(RString().cpf().validate('584 687'), isString);
      expect(RString().cpf().validate('5846874207489'), isString);
      expect(RString().cpf().validate('387.542.180'), isString);

      expect(RString().cpf().validate('38027378060'), isNull);
      expect(RString().cpf().validate('833.755.200-00'), isNull);
      expect(RString().cpf().validate('628 731 810 44'), isNull);

      const message = 'invalid_cpf';
      expect(RString().cpf(message: message).validate('584 687'), message);
    });

    test('RString.cnpj', () {
      expect(RString().cnpj().validate(''), isString);
      expect(RString().cnpj().validate(null), isString);
      expect(RString().cnpj().validate('569755'), isString);
      expect(RString().cnpj().validate('37.251/000'), isString);
      expect(RString().cnpj().validate('56975505000126454'), isString);

      expect(RString().cnpj().validate('91965576000149'), isNull);
      expect(RString().cnpj().validate('18.696.320/0001-93'), isNull);
      expect(RString().cnpj().validate('11 184 037/0001 33'), isNull);

      const message = 'invalid_cnpj';
      expect(RString().cnpj(message: message).validate('584 687'), message);
    });

    test('RString.cpfOrCnpj', () {
      expect(RString().cpfOrCnpj().validate(''), isString);
      expect(RString().cpfOrCnpj().validate(null), isString);
      expect(RString().cpfOrCnpj().validate(false), isString);
      expect(RString().cpfOrCnpj().validate('569755'), isString);
      expect(RString().cpfOrCnpj().validate('37.251/000'), isString);

      expect(RString().cpfOrCnpj().validate('83375520000'), isNull);
      expect(RString().cpfOrCnpj().validate('833.755.200-00'), isNull);
      expect(RString().cpfOrCnpj().validate('18696320000193'), isNull);
      expect(RString().cpfOrCnpj().validate('18.696.320/0001-93'), isNull);

      const message = 'invalid_cpfOrCnpj';
      expect(RString().cpfOrCnpj(message: message).validate('584'), message);
    });

    test('RString.uppercase', () {
      expect(RString().uppercase(2).validate(''), isString);
      expect(RString().uppercase(0).validate(null), isString);
      expect(RString().uppercase(2).validate('Aasds'), isString);

      expect(RString().uppercase(2).validate('AbCde'), isNull);
      expect(RString().uppercase(5).validate('ABCDE'), isNull);
      expect(RString().uppercase(0).validate('abcde'), isNull);

      final relative = RString().uppercase(1, isRelative: true);
      expect(relative.validate('abcdeF'), isNull);

      const message = 'invalid_uppercase';
      expect(RString().uppercase(2, message: message).validate('ass'), message);
    });

    test('RString.lowercase', () {
      expect(RString().lowercase(2).validate(''), isString);
      expect(RString().lowercase(0).validate(null), isString);
      expect(RString().lowercase(2).validate('ABDDBD'), isString);

      expect(RString().lowercase(2).validate('abCDE'), isNull);
      expect(RString().lowercase(5).validate('abcde'), isNull);
      expect(RString().lowercase(0).validate('ABCDE'), isNull);

      final relative = RString().lowercase(1, isRelative: true);
      expect(relative.validate('aaCDE'), isNull);

      const message = 'invalid_lowercase';
      expect(RString().lowercase(2, message: message).validate('AB'), message);
    });

    test('RString.digits', () {
      expect(RString().digits(2).validate(''), isString);
      expect(RString().digits(0).validate(null), isString);
      expect(RString().digits(2).validate('abcde'), isString);

      expect(RString().digits(0).validate('abcde'), isNull);
      expect(RString().digits(5).validate('abcde12345'), isNull);
      expect(RString().digits(2).validate('abc42'), isNull);

      final relative = RString().digits(2, isRelative: true);
      expect(relative.validate('abc4123212'), isNull);

      const message = 'invalid_digits';
      expect(RString().digits(2, message: message).validate('avdd'), message);
    });

    test('RString.specialCharacters', () {
      expect(RString().specialCharacters(2).validate(''), isString);
      expect(RString().specialCharacters(0).validate(null), isString);
      expect(RString().specialCharacters(2).validate('abcde'), isString);
      expect(RString().specialCharacters(2).validate('ab!@&'), isString);

      expect(RString().specialCharacters(2).validate('ab!@'), isNull);
      expect(RString().specialCharacters(3).validate('abcde-=_'), isNull);
      expect(RString().specialCharacters(0).validate('abcde12345'), isNull);

      final relative = RString().specialCharacters(2, isRelative: true);
      expect(relative.validate('ab!@&'), isNull);

      const message = 'invalid_special_characters';
      final actual = RString().specialCharacters(2, message: message);
      expect(actual.validate('abcde'), message);
    });

    test('RString.date', () {
      expect(RString().date().validate(null), isString);
      expect(RString().date().validate('abcde'), isString);
      expect(RString().date().validate(false), isString);
      expect(RString().date().validate('dd/mm/yyyy'), isString);
      expect(RString().date().validate('yyyy/mm/dd'), isString);
      expect(RString().date().validate('88/88/8888'), isString);

      expect(RString().date().validate('10-03-2023'), isNull);
      expect(RString().date().validate('2023-03-10'), isNull);
      expect(RString().date().validate('10/03/2023'), isNull);
      expect(RString().date().validate('2023/03/10'), isNull);

      expect(RString().date().validate('10/03/2023 11:54:06.00'), isNull);
      expect(RString().date().validate('2023/03/10 11:54:06.00'), isNull);
      expect(RString().date().validate('10-03-2023 11:54:06.00'), isNull);
      expect(RString().date().validate('2023-03-10 11:54:06.00'), isNull);
    });

    test('RString.url', () {
      expect(RString().url().validate(''), isString);
      expect(RString().url().validate(null), isString);
      expect(RString().url().validate('abcde'), isString);

      expect(RString().url().validate('pub.dev'), isNull);
      expect(RString().url().validate('https://pub.dev/packages'), isNull);

      const message = 'invalid_url';
      expect(RString().url(message: message).validate('.dev'), message);
    });

    test('RString.uuid', () {
      expect(RString().uuid().validate(''), isString);
      expect(RString().uuid().validate(null), isString);
      expect(RString().uuid().validate('abcde'), isString);

      const uuid = 'A987FBC9-4BED-3078-CF07-9141BA07C9F3';
      expect(RString().uuid().validate(uuid), isNull);

      const invalidUuid = 'xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3';
      expect(RString().uuid().validate(invalidUuid), isString);

      const message = 'invalid_uuid';
      expect(RString().uuid(message: message).validate('.dev'), message);
    });

    test('RString.randomPixKey', () {
      expect(RString().randomPixKey().validate(''), isString);
      expect(RString().randomPixKey().validate(null), isString);
      expect(RString().randomPixKey().validate(false), isString);

      const key = '01234567-ABCD-EF01-2345-6789ABCDEF12';
      expect(RString().randomPixKey().validate(key), isNull);

      const invalidKey = '01234567-ABCD-EF01-2345-6789ABCDEF12';
      expect(RString().randomPixKey().validate(invalidKey), isNull);

      const message = 'invalid_random_pix_key';
      expect(RString().randomPixKey(message: message).validate('a'), message);
    });

    test('RString.includes', () {
      expect(RString().includes('a').validate(''), isString);
      expect(RString().includes('a').validate(null), isString);
      expect(RString().includes('a').validate(false), isString);

      expect(RString().includes('a').validate('abc'), isNull);
      expect(RString().includes('a').validate('hello'), isString);
      expect(RString().includes('word').validate('hello word'), isNull);

      const message = 'invalid_includes';
      expect(RString().includes('b', message: message).validate('ac'), message);
    });

    test('RString.startsWith', () {
      expect(RString().startsWith('a').validate(''), isString);
      expect(RString().startsWith('a').validate(null), isString);
      expect(RString().startsWith('a').validate(false), isString);

      expect(RString().startsWith('a').validate('abc'), isNull);
      expect(RString().startsWith('a').validate('hello'), isString);
      expect(RString().startsWith('a').validate('a hello'), isNull);

      const message = 'invalid_starts_with';
      expect(
        RString().startsWith('b', message: message).validate('ac'),
        message,
      );
    });

    test('RString.endsWith', () {
      expect(RString().endsWith('a').validate(''), isString);
      expect(RString().endsWith('a').validate(null), isString);
      expect(RString().endsWith('a').validate(false), isString);

      expect(RString().endsWith('c').validate('abc'), isNull);
      expect(RString().endsWith('a').validate('hello'), isString);
      expect(RString().endsWith('a').validate('hello a'), isNull);

      const message = 'invalid_ends_with';
      expect(
        RString().endsWith('b', message: message).validate('ac'),
        message,
      );
    });

    test('RString.equals', () {
      expect(RString().equals('a').validate(''), isString);
      expect(RString().equals('a').validate(null), isString);
      expect(RString().equals('a').validate(false), isString);

      expect(RString().equals('a').validate('b'), isString);
      expect(RString().equals('a').validate('a hello'), isString);
      expect(RString().equals('hello').validate('hello'), isNull);

      expect(RString().equals('a').validate('a'), isNull);
      expect(RString().equals('A').validate('a'), isString);

      final equalsIgnoreCase = RString().equals('A', equalsIgnoreCase: true);
      expect(equalsIgnoreCase.validate('a'), isNull);

      const message = 'invalid_equals';
      expect(RString().equals('b', message: message).validate('ac'), message);
    });

    test('RString.ip', () {
      expect(RString().ip().validate(''), isString);
      expect(RString().ip().validate('abc'), isString);
      expect(RString().ip().validate(null), isString);
      expect(RString().ip().validate(false), isString);

      expect(RString().ip().validate('::1'), isNull);
      expect(RString().ip().validate('0.0.0.0'), isNull);
      expect(RString().ip().validate('1.2.3.4'), isNull);
      expect(RString().ip().validate('127.0.0.1'), isNull);
      expect(RString().ip().validate('255.255.255.255'), isNull);
      expect(RString().ip().validate('2001:db8:0000:1:1:1:1:1'), isNull);

      expect(RString().ip().validate('256.0.0.0'), isString);
      expect(RString().ip().validate('0.0.0.256'), isString);
      expect(RString().ip().validate('26.0.0.256'), isString);

      const message = 'invalid_ip';
      expect(RString().ip(message: message).validate('123'), message);
    });

    test('RString.digitSequence', () {
      expect(RString().digitSequence().validate(''), isString);
      expect(RString().digitSequence().validate(null), isString);
      expect(RString().digitSequence().validate(false), isString);

      expect(RString().digitSequence().validate('123'), isString);
      expect(RString().digitSequence().validate('123456789012'), isString);

      expect(RString().digitSequence().validate('a148'), isNull);
      expect(RString().digitSequence().validate('a1b2b4'), isNull);

      const message = 'invalid_digit_sequence';
      expect(RString().digitSequence(message: message).validate('12'), message);
    });

    test('RString.repetition', () {
      expect(RString().repetition().validate(''), isString);
      expect(RString().repetition().validate(null), isString);
      expect(RString().repetition().validate(false), isString);

      expect(RString().repetition().validate('abc'), isNull);
      expect(RString().repetition().validate('abc124'), isNull);
      expect(RString().repetition().validate('aabbcc'), isNull);
      expect(RString().repetition().validate('abc1111trt'), isString);
      expect(RString().repetition(digitsOnly: true).validate('aa11'), isString);
      expect(RString().repetition(digitsOnly: true).validate('aabbcc'), isNull);

      const message = 'invalid_repetition';
      expect(RString().repetition(message: message).validate('11'), message);
    });

//   test('RString.confirmPassword', () {
//     expect(RString.confirmPassword('', ''), isString);
//     expect(RString.confirmPassword(' ', ''), isString);
//     expect(RString.confirmPassword('', null), isString);

//     expect(RString.confirmPassword('10', '10'), isNull);
//     expect(RString.confirmPassword('hello', 'hello'), isNull);
//     expect(RString.confirmPassword('Senha2132', 'Senha2132'), isNull);
//   });
  });

  group('RubikStringRString.transforms', () {
    test('RString.toUpperCase', () {
      const value = 'test';
      expect(RString().uppercase(4).validate(value), isString);
      expect(RString().toUpperCase().uppercase(4).validate(value), isNull);
    });

    test('RString.toLowerCase', () {
      const value = 'TEST';
      expect(RString().lowercase(4).validate(value), isString);
      expect(RString().toLowerCase().lowercase(4).validate(value), isNull);
    });
  });
}
