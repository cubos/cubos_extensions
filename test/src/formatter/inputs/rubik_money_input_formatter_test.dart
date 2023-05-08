import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

import '../../../utils/tests_utils.dart';

void main() {
  group('RubikMoneyInputFormatter', () {
    test('should return empty value when value empty', () {
      const newValue = TextEditingValue.empty;
      final formatter = RubikMoneyInputFormatter();
      final actual = formatter.formatEditUpdate(newValue, newValue);

      expect(actual.text, '');
      expect(actual.selection.baseOffset, -1);
    });

    test('should format value for Real correctly', () {
      final formatter = RubikMoneyInputFormatter();

      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1000');

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(actual.text, 'R\$ 10,00');
      expect(actual.selection.baseOffset, actual.text.length);
    });

    test('should format value for Dollar correctly', () {
      final formatter = RubikMoneyInputFormatter.dollar();

      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1000');

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(actual.text, 'US\$10.00');
      expect(actual.selection.baseOffset, actual.text.length);
    });

    test('should format value for Euro correctly', () {
      final formatter = RubikMoneyInputFormatter.euro();

      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '1000');

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(actual.text, '€ 10.00');
      expect(actual.selection.baseOffset, actual.text.length);
    });

    test('should format value with placeholder correctly', () {
      final formatter = RubikMoneyInputFormatter(placeholder: 'R\$ 0,00');

      const oldValue = TextEditingValue.empty;
      const newValue = TextEditingValue(text: '');

      final actual = formatter.formatEditUpdate(oldValue, newValue);

      expect(actual.text, 'R\$ 0,00');
      expect(actual.selection.baseOffset, 7);
    });

    test('should format value with custom formatter function correctly', () {
      final formatter = RubikMoneyInputFormatter(
        formatter: (money) => 'REAL ${money.replaceAll('R\$ ', '')}',
      );

      final actual = formatter.formatEditUpdate(
        TextEditingValue.empty,
        '1000'.toEditingValue,
      );

      expect(actual.text, 'REAL 10,00');
      expect(actual.selection.baseOffset, actual.text.length);
    });

    test('should convert string value to money using default formatter', () {
      final cents = [0, 150, 15000];
      final formatter = RubikMoneyInputFormatter();

      expect(formatter.parse('R\$ 10,00'), 10.0);
      expect(formatter.parseAll(['10.00', '10,00']), [10.0, 10.0]);
      expect(formatter.parseAll(['', '1.50', '15000'], cents: true), cents);
    });

    test('should convert dollar formatter to number', () {
      final formatter = RubikMoneyInputFormatter.dollar();
      expect(formatter.parse('US\$10.00'), 10.0);
      expect(formatter.parseAll(['10.00', '10,00']), [10.0, 10.0]);
    });

    test('should convert euro formatter to number', () {
      final formatter = RubikMoneyInputFormatter.euro();
      expect(formatter.parse('€ 10.00'), 10.0);
      expect(formatter.parseAll(['10.00', '10,00']), [10.0, 10.0]);
    });

    test('should returns the correct value with custom decimal digits', () {
      final formatter = RubikMoneyInputFormatter(decimalDigits: 3);

      expect(formatter.parse('0.506'), 0.506);
      expect(formatter.parse('1.503'), 1.503);
      expect(formatter.parse('15,345'), 15.345);
    });

    group('RubikMoneyInputFormatter.widgets', () {
      Future<String> boilerplate(
        WidgetTester tester,
        TextInputFormatter formatter,
      ) async {
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

        await tester.enterText(find.byKey(key), '1000');
        await tester.pumpAndSettle();

        return controller.value.text;
      }

      test('should convert text in TextEditingControllers to money', () {
        final formatter = RubikMoneyInputFormatter();
        final controller = TextEditingController(text: 'R\$ 45,30');

        expect(controller.money(), 45.3);
        expect(controller.money(), formatter.parse(controller.text));
      });

      testWidgets(
        'should format value correctly when used in a TextField',
        (tester) async {
          final formatter = RubikMoneyInputFormatter();
          expect(await boilerplate(tester, formatter), 'R\$ 10,00');

          final dollarFormatter = RubikMoneyInputFormatter.dollar();
          expect(await boilerplate(tester, dollarFormatter), 'US\$10.00');

          final euroFormatter = RubikMoneyInputFormatter.euro();
          expect(await boilerplate(tester, euroFormatter), '€ 10.00');
        },
      );
    });
  });
}
