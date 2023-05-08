import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

import '../../../utils/tests_utils.dart';

void main() {
  group('RubikCPFInputFormatter', () {
    test('should return empty value when value empty', () {
      const newValue = TextEditingValue.empty;
      final formatter = RubikCPFInputFormatter();
      final actual = formatter.formatEditUpdate(newValue, newValue);

      expect(actual.text, '');
      expect(actual.selection.baseOffset, -1);
    });

    test('should not permise max length greater than 11', () {
      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '123456789012345');

      final formatter = RubikCPFInputFormatter();
      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(actual.text, '');
      expect(formatter.maxLength, 11);
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

    test('should format to CPF', () {
      var oldValue = TextEditingValue.empty;
      var newValue = TextEditingValue.empty;

      var actual = ''.toEditingValue;
      final formatter = RubikCPFInputFormatter();

      '34567890124'.split('').forEach((it) {
        newValue = newValue.copyWith(
          text: newValue.text + it,
          selection: TextSelection.collapsed(offset: newValue.text.length),
        );

        oldValue = newValue;
        actual = formatter.formatEditUpdate(oldValue, newValue);
      });

      expect(actual.text, '345.678.901-24');
      expect(actual.selection.baseOffset, 14);
    });

    test('should formatter all CPFs', () {
      final formatter = RubikCPFInputFormatter();
      final cpfs = ['34567890123', '12456789012', '45678901234'];

      expect(formatter.parse(cpfs.first), '345.678.901-23');
      expect(
        formatter.parseAll(cpfs),
        ['345.678.901-23', '124.567.890-12', '456.789.012-34'],
      );
    });

    group('RubikCPFInputFormatter.widgets', () {
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

      testWidgets(
        'should remove formatter when used in a TextField',
        (tester) async {
          final formatter = RubikCPFInputFormatter();

          const key = Key('input_01');
          final controller = TextEditingController(
            text: '345.678.901-23',
          );

          final textInput = TestsUtils.generatedInput(
            key: key,
            controller: controller,
            inputFormatters: [formatter],
          );

          await TestsUtils.renderInputsWidget(tester, child: textInput);
          await tester.tap(find.byKey(key));
          await tester.pumpAndSettle();

          await tester.enterText(find.byKey(key), '345.678.901-');
          await tester.pumpAndSettle();

          expect(controller.value.text, '345.678.901');
        },
      );
    });
  });
}
