import 'package:flutter/material.dart';

import 'package:rubik_utils/rubik_utils.dart';

/// The `RubikCPFInputFormatter` class formats the text input as CPF.
/// This formatter can be used with `TextField` or `TextFormField`.
/// {@tool snippet}
/// ```dart
/// final controller = TextEditingController(
///   text: '34567890123',
/// );
///
/// TextField(
///  controller: controller,
///  inputFormatters: [ RubikCPFInputFormatter() ],
/// );
///
/// print(controller.text); // 345.678.901-23
/// print(RubikCPFInputFormatter().parse('34567890123')); // 345.678.901-23
/// ```
/// {@end-tool}
class RubikCPFInputFormatter extends RubikFormatterBase {
  final bool checkLengthAndisNumeric;
  RubikCPFInputFormatter([this.checkLengthAndisNumeric = true]);

  /// Returns `maxLength` of the formatter, default is `11`.
  @override
  int get maxLength => 11;

  bool _isInvalidLengthAndIsNotNumeric(TextEditingValue newValue) {
    if (!checkLengthAndisNumeric) return false;

    return newValue.length(true) > maxLength ||
        !newValue.isNumeric(RubikRegExps.cpfSpecialCharactersRegex, '');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_isInvalidLengthAndIsNotNumeric(newValue)) return oldValue;

    if (newValue.length(true) == maxLength) {
      final text = parse(newValue.text);

      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }

    final isDeletingText = oldValue.isDeletingText(newValue);
    final text = !isDeletingText ? _add(newValue.text) : remove(newValue.text);

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  String _add(String text) {
    final length = text.length;
    if (text.isEmpty || length < 2) return text;

    final buffer = StringBuffer()..write(text);

    if (const [3, 7].contains(length)) buffer.write('.');

    if (length == 11) buffer.write('-');

    return buffer.toString();
  }

  /// Returns text in `CPF` format.
  /// {@tool snippet}
  /// ```dart
  /// final cpf = RubikCPFInputFormatter().parse('34567890123');
  /// print(cpf); // 345.678.901-23
  /// ```
  /// {@end-tool}
  String parse(String text) => text.formatCPF;

  /// Returns a list of text in `CPF` format.
  /// {@tool snippet}
  /// ```dart
  /// final cpfs = RubikCPFInputFormatter.parseAll(['34567890123', '12456789012']);
  /// print(cpfs); // ['345.678.901-23', '124.567.890-12']
  /// ```
  /// {@end-tool}
  Strings parseAll(Strings values) => values.map(parse).toList();
}
