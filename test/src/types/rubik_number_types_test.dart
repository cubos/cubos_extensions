import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/types/rubik_number_types.dart';

void main() {
  group('RubikNumberSeparator', () {
    group('RubikNumberSeparator.comma', () {
      test('should replace dot symbol to comma', () {
        expect(RubikNumberSeparator.comma.resolva('3-5'), '3-5');
        expect(RubikNumberSeparator.comma.resolva('3.5'), '3,5');
        expect(RubikNumberSeparator.comma.resolva('3.45.67'), '3,45,67');
        expect(RubikNumberSeparator.comma.resolva('[12.45.67]'), '[12,45,67]');
      });
    });

    group('RubikNumberSeparator.dot', () {
      test('should replace comma symbol to dot', () {
        expect(RubikNumberSeparator.dot.resolva('3-5'), '3-5');
        expect(RubikNumberSeparator.dot.resolva('3,5'), '3.5');
        expect(RubikNumberSeparator.dot.resolva('3,45,67'), '3.45.67');
        expect(RubikNumberSeparator.dot.resolva('[12,45,67]'), '[12.45.67]');
      });
    });
  });
}
