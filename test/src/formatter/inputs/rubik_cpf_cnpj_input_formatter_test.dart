import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

import '../../../utils/tests_utils.dart';

void main() {
  group('RubikCPFCNPJInputFormatter', () {
    test('should return empty value when value empty', () {
      const newValue = TextEditingValue.empty;
      final formatter = RubikCPFCNPJInputFormatter();
      final actual = formatter.formatEditUpdate(newValue, newValue);

      expect(actual.text, '');
      expect(actual.selection.baseOffset, 0);
    });

    test('should return current value if greater than 18', () {
      const newValue = TextEditingValue(text: '12345678901234567890');
      final formatter = RubikCPFCNPJInputFormatter();
      final actual = formatter.formatEditUpdate(newValue, newValue);

      expect(actual.text, '12345678901234567890');
      expect(actual.selection.baseOffset, -1);
    });

    test('should format 34567890123 to 345.678.901-23', () {
      final formatter = RubikCPFInputFormatter();
      final actual = formatter.formatEditUpdate(
        ''.toEditingValue,
        '34567890123'.toEditingValue,
      );

      expect(actual.text, '345.678.901-23');
      expect(actual.selection.baseOffset, 14);
    });

    test('should format 36839395000168 to 36.839.395/0001-68', () {
      final formatter = RubikCPFCNPJInputFormatter();
      final actual = formatter.formatEditUpdate(
        ''.toEditingValue,
        '36839395000168'.toEditingValue,
      );

      expect(actual.selection.baseOffset, 18);
      expect(actual.text, '36.839.395/0001-68');
    });

    test('should format cpf or cnpj using parse method', () {
      final formatter = RubikCPFCNPJInputFormatter();
      expect(formatter.parse('34567890123'), '345.678.901-23');
      expect(formatter.parse('36839395000168'), '36.839.395/0001-68');
    });

    group('RubikCPFCNPJInputFormatter.widgets', () {
      testWidgets(
        'should format value correctly when used in a TextField',
        (tester) async {
          final formatter = RubikCPFCNPJInputFormatter();

          const key = Key('input_01');
          final controller = TextEditingController();

          final textInput = TestsUtils.generatedInput(
            key: key,
            controller: controller,
            inputFormatters: [formatter],
          );

          await TestsUtils.renderInputsWidget(tester, child: textInput);
          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          await tester.enterText(find.byKey(key), '36839395000168');
          await tester.pumpAndSettle();

          expect(controller.value.text, '36.839.395/0001-68');
        },
      );

      testWidgets(
        'should format value correctly when used in a TextField',
        (tester) async {
          final formatter = RubikCPFInputFormatter();

          const key = Key('input_01');
          final controller = TextEditingController();

          final textInput = TestsUtils.generatedInput(
            key: key,
            controller: controller,
            inputFormatters: [formatter],
          );

          await TestsUtils.renderInputsWidget(tester, child: textInput);
          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          await tester.enterText(find.byKey(key), '34567890123');
          await tester.pumpAndSettle();

          expect(controller.value.text, '345.678.901-23');
        },
      );
    });
  });
}
