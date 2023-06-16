import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

void main() {
  group('RubikCNPJValidator', () {
    group('RubikCNPJValidator.isValid', () {
      test('should return true if is cnpj valid or false otherwise', () {
        expect(RubikCNPJValidator.isValid(''), false);
        expect(RubikCNPJValidator.isValid(null), false);

        expect(RubikCNPJValidator.isValid('19996775000197'), true);
        expect(RubikCNPJValidator.isValid('20727498000104'), true);
        expect(RubikCNPJValidator.isValid('20.727.498/0001-04'), true);
        expect(RubikCNPJValidator.isValid('19.996.775/0001-97'), true);

        expect(RubikCNPJValidator.isValid('123'), false);
        expect(RubikCNPJValidator.isValid('1999677500019723'), false);
        expect(RubikCNPJValidator.isValid('2072749800010423'), false);

        expect(RubikCNPJValidator.isValid('12.345.678/9101-12'), false);
        expect(RubikCNPJValidator.isValid('12.345.678/9101-12'), false);
        expect(RubikCNPJValidator.isValid('324abc803.6586-52'), false);
        expect(RubikCNPJValidator.isValid('03teste1671002@mail'), false);

        final cnpjBlackList = RubikStrings.cnpjBlockList();
        expect(cnpjBlackList.every(RubikCNPJValidator.isValid), false);
      });
    });

    group('RubikCNPJValidator.allAreValid', () {
      test('should return true if all cpf are valid or false otherwise', () {
        final cnpjs = ['71364776000139', '15211538000112'];
        expect(RubikCNPJValidator.allAreValid(cnpjs), true);

        final cnpjsWithMask = cnpjs.map((e) => e.formatCNPJ).toList();
        expect(RubikCNPJValidator.allAreValid(cnpjsWithMask), true);
      });

      test('should return false if a element in cnpj list is invalid', () {
        final cnpjs = ['12345678910112', '21101987654321'];
        expect(RubikCNPJValidator.allAreValid(cnpjs), false);

        final cnpjsWithMask = cnpjs.map((e) => e.formatCNPJ).toList();
        expect(RubikCNPJValidator.allAreValid(cnpjsWithMask), false);
      });
    });

    group('RubikCNPJValidator.format', () {
      test('should any string to cnpj format', () {
        expect(
          RubikCNPJValidator.format('45487645000139'),
          '45.487.645/0001-39',
        );
        expect(
          RubikCNPJValidator.format('53750642000174'),
          '53.750.642/0001-74',
        );
        expect(
          RubikCNPJValidator.format('9335754600018523232'),
          '93.357.546/0001-8523232',
        );
      });
    });

    group('RubikCNPJValidator.generate', () {
      test('should generate any cnpj', () {
        final raw = RubikCNPJValidator.generate();
        final formatted = RubikCNPJValidator.generate(true);

        expect(raw != formatted, true);
        expect(RubikCNPJValidator.isValid(raw), true);
        expect(RubikCNPJValidator.isValid(formatted), true);
      });
    });
  });
}
