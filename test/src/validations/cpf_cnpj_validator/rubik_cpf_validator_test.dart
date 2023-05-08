import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

void main() {
  group('RubikCPFValidator', () {
    group('RubikCPFValidator.isValid', () {
      test('should return true if is cpf valid or false otherwise', () {
        expect(RubikCPFValidator.isValid(''), false);
        expect(RubikCPFValidator.isValid(null), false);

        expect(RubikCPFValidator.isValid('35999906032'), true);
        expect(RubikCPFValidator.isValid('87734263933'), true);
        expect(RubikCPFValidator.isValid('334.616.710-02'), true);
        expect(RubikCPFValidator.isValid('877.342.639-33'), true);

        expect(RubikCPFValidator.isValid('35999906031'), false);
        expect(RubikCPFValidator.isValid('033461671002'), false);
        expect(RubikCPFValidator.isValid('123.456.789-10'), false);
        expect(RubikCPFValidator.isValid('12.3456.7891-0'), false);
        expect(RubikCPFValidator.isValid('324abc803.6586-52'), false);
        expect(RubikCPFValidator.isValid('03teste1671002@mail'), false);

        final cpfBlackList = RubikStrings.cpfBlockList();
        expect(cpfBlackList.every(RubikCPFValidator.isValid), false);
      });
    });

    group('RubikCPFValidator.allAreValid', () {
      test('should return true if all cpf are valid or false otherwise', () {
        final cpfs = ['76461234047', '23223537600'];
        expect(RubikCPFValidator.allAreValid(cpfs), true);

        final cpfsWithMask = cpfs.map((e) => e.formatCPF).toList();
        expect(RubikCPFValidator.allAreValid(cpfsWithMask), true);
      });

      test('should return false if a element in cpf list is invalid', () {
        final cpfs = ['12345678910', '10987654321'];
        expect(RubikCPFValidator.allAreValid(cpfs), false);

        final cpfsWithMask = cpfs.map((e) => e.formatCPF).toList();
        expect(RubikCPFValidator.allAreValid(cpfsWithMask), false);
      });
    });

    group('RubikCPFValidator.format', () {
      test('should any string to cpf format', () {
        expect(RubikCPFValidator.format(''), '');
        expect(RubikCPFValidator.format('359999'), '359999');
        expect(RubikCPFValidator.format('35999906032'), '359.999.060-32');
        expect(RubikCPFValidator.format('33461671002'), '334.616.710-02');

        final forged = RubikCPFValidator.format('334616710021234', true);
        expect(forged, '334.616.710-021234');
      });
    });

    group('RubikCPFValidator.generate', () {
      test('should generate any cpf', () {
        final raw = RubikCPFValidator.generate();
        final formatted = RubikCPFValidator.generate(true);

        expect(raw != formatted, true);
        expect(RubikCPFValidator.isValid(raw), true);
        expect(RubikCPFValidator.isValid(formatted), true);
      });
    });
  });
}
