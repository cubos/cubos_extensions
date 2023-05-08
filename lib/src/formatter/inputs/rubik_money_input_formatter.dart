import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:rubik_utils/rubik_utils.dart';

/// The `RubikMoneyInputFormatter` class formats the text input as CPF.
/// This formatter can be used with `TextField` or `TextFormField`.
/// {@tool snippet}
/// ```dart
/// final formatter = RubikMoneyInputFormatter();
/// final controller = TextEditingController( text: '1222' );
///
/// TextField(
///  controller: controller,
///  inputFormatters: [ formatter],
/// );
///
/// print(controller.text); // R$ 12.22
/// print(controller.money()); // 12.22
///
/// print(formatter.parse('R$ 12.22')); // 12.22
/// print(formatter.parse('R$ 12.22', cents: true)); // 1222
/// ```
/// {@end-tool}
class RubikMoneyInputFormatter extends RubikFormatterBase {
  final String symbol;
  final String locale;
  final int decimalDigits;

  /// Creates default formatter for money, default is real `R$`.
  /// {@tool snippet}
  /// ```dart
  /// final formatter = RubikMoneyInputFormatter();
  /// print(formatter.parse('R$ 12.22')); // 12.22
  /// print(formatter.parse('R$ 12.22', cents: true)); // 1222
  /// ```
  /// {@end-tool}
  RubikMoneyInputFormatter({
    super.formatter,
    super.placeholder,
    this.decimalDigits = 2,
    this.locale = RubikStrings.defaultLocale,
    this.symbol = RubikStrings.defaultCurrencySymbol,
  });

  /// Creates formatter for money with dollar symbol `US$`.
  /// {@tool snippet}
  /// ```dart
  /// final formatter = RubikMoneyInputFormatter.dollar();
  ///
  /// print(formatter.parse('US$ 12.22')); // 12.22
  /// print(formatter.parse('US$ 12.22', cents: true)); // 1222
  /// ```
  /// {@end-tool}
  RubikMoneyInputFormatter.dollar({
    super.formatter,
    super.placeholder,
    this.symbol = r'US$',
    this.locale = 'en_US',
    this.decimalDigits = 2,
  });

  /// Creates formatter for money with euro symbol `€`.
  /// {@tool snippet}
  /// ```dart
  /// final formatter = RubikMoneyInputFormatter.euro();
  /// print(formatter.parse('€ 12.22')); // 12.22
  /// print(formatter.parse('€ 12.22', cents: true)); // 1222
  /// ```
  /// {@end-tool}
  RubikMoneyInputFormatter.euro({
    super.formatter,
    super.placeholder,
    this.symbol = r'€ ',
    this.locale = 'de_CH',
    this.decimalDigits = 2,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.digitsOnly;
    if (text.isEmpty) return applyPlaceholder(oldValue);

    final money = parse(text).formatToCurrency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );

    return applyFormatter(newValue.copyWith(
      text: money,
      selection: TextSelection.collapsed(offset: money.length),
    ));
  }

  /// Converts the text to money, if `cents` is `true` the value will be
  /// converted to cents.
  /// {@tool snippet}
  /// ```dart
  /// final formatter = RubikMoneyInputFormatter();
  /// print(formatter.parse('R$ 12.22')); // 12.22
  /// print(formatter.parse('R$ 12.22', cents: true)); // 1222
  /// ```
  /// {@end-tool}
  num parse(String text, {bool cents = false}) {
    final digitsOnly = text.digitsOnly();
    if (digitsOnly.isEmpty) return 0;

    final money = num.parse(digitsOnly) / math.pow(10, decimalDigits);

    return cents ? money.toCents : money;
  }

  /// Converts the list of texts to money, if `cents` is `true` the value will
  /// be converted to cents.
  /// {@tool snippet}
  /// ```dart
  /// final formatter = RubikMoneyInputFormatter();
  /// print(formatter.parseAll(['R$ 12.22', 'R$ 12.22'])); // [12.22, 12.22]
  /// print(formatter.parseAll(['R$ 12.22', 'R$ 12.22'], cents: true)); // [1222, 1222]
  /// ```
  /// {@end-tool}
  RubikNumbers parseAll(Strings values, {bool cents = false}) {
    return values.map((it) => parse(it, cents: cents)).toList();
  }
}

/// Extension for `TextEditingController` to get the money value.
/// {@tool snippet}
/// ```dart
/// final controller = TextEditingController( text: '1222' );
/// print(controller.money()); // 12.22
/// ```
/// {@end-tool}
extension RubikMoneyInputFormatterExtension on TextEditingController {
  /// Returns the `money` value of the text.
  /// {@tool snippet}
  /// ```dart
  /// final controller = TextEditingController( text: '1222' );
  /// print(controller.money()); // 12.22
  /// ```
  /// {@end-tool}
  num money({
    bool cents = false,
    String locale = RubikStrings.defaultLocale,
    String symbol = RubikStrings.defaultCurrencySymbol,
  }) {
    final formatter = RubikMoneyInputFormatter(locale: locale, symbol: symbol);

    return formatter.parse(text, cents: cents);
  }
}
