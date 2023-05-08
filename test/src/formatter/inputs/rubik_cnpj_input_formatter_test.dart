import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

import '../../../utils/tests_utils.dart';

void main() {
  group('RubikCNPJInputFormatter', () {
    test('should return empty value when value empty', () {
      const newValue = TextEditingValue.empty;
      final formatter = RubikCNPJInputFormatter();
      final actual = formatter.formatEditUpdate(newValue, newValue);

      expect(actual.text, '');
      expect(actual.selection.baseOffset, -1);
    });

    test('should not permise max length greater than 11', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1234567890123455644654');

      final formatter = RubikCNPJInputFormatter();
      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(actual.text, '');
      expect(formatter.maxLength, 14);
      expect(actual.selection.baseOffset, -1);

      final formatter2 = RubikCNPJInputFormatter(false);
      final actual2 = formatter2.formatEditUpdate(oldValue, newValue);

      expect(actual2.text, '12.345.678/9012-3455644654');
    });

    test('should format 36839395000168 to 36.839.395/0001-68', () {
      final formatter = RubikCNPJInputFormatter();
      final actual = formatter.formatEditUpdate(
        ''.toEditingValue,
        '36839395000168'.toEditingValue,
      );

      expect(actual.selection.baseOffset, 18);
      expect(actual.text, '36.839.395/0001-68');
    });

    test('should format to CNPJ', () {
      var oldValue = TextEditingValue.empty;
      var newValue = TextEditingValue.empty;

      var actual = ''.toEditingValue;
      final formatter = RubikCNPJInputFormatter();

      '36839395000168'.split('').forEach((it) {
        newValue = newValue.copyWith(
          text: newValue.text + it,
          selection: TextSelection.collapsed(offset: newValue.text.length),
        );

        oldValue = newValue;
        actual = formatter.formatEditUpdate(oldValue, newValue);
      });

      expect(actual.selection.baseOffset, 18);
      expect(actual.text, '36.839.395/0001-68');
    });

    test('should formatter all CNPJs', () {
      final formatter = RubikCNPJInputFormatter();
      final cnpjs = ['36839395000168', '60604187000164', '48713273000100'];

      expect(formatter.parse(cnpjs.first), '36.839.395/0001-68');
      expect(
        formatter.parseAll(cnpjs),
        ['36.839.395/0001-68', '60.604.187/0001-64', '48.713.273/0001-00'],
      );
    });

    group('RubikCNPJInputFormatter.widgets', () {
      testWidgets(
        'should format value correctly when used in a TextField',
        (tester) async {
          final formatter = RubikCNPJInputFormatter();

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
        'should remove formatter when used in a TextField',
        (tester) async {
          final formatter = RubikCNPJInputFormatter();

          const key = Key('input_01');
          final controller = TextEditingController(
            text: '36.839.395/0001-68',
          );

          final textInput = TestsUtils.generatedInput(
            key: key,
            controller: controller,
            inputFormatters: [formatter],
          );

          await TestsUtils.renderInputsWidget(tester, child: textInput);
          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          await tester.enterText(find.byKey(key), '36.839.395/0001-');
          await tester.pumpAndSettle();

          expect(controller.value.text, '36.839.395/0001');
        },
      );
    });
  });
}
