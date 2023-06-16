import 'package:flutter/services.dart';

import 'package:rubik_utils/rubik_utils.dart';

/// The `RubikCNPJInputFormatter` class formats the text input as CNPJ.
/// This formatter can be used with `TextField` or `TextFormField`.
/// {@tool snippet}
/// ```dart
/// final controller = TextEditingController(
///   text: '45487645000139',
/// );
///
/// TextField(
///  controller: controller,
///  inputFormatters: [ RubikCNPJInputFormatter() ],
/// );
///
/// print(controller.text); // 45.487.645/0001-39
/// print(RubikCNPJInputFormatter().parse('45487645000139')); // 45.487.645/0001-39
/// ```
/// {@end-tool}
class RubikCNPJInputFormatter extends RubikFormatterBase {
  final bool checkLengthAndisNumeric;
  RubikCNPJInputFormatter([this.checkLengthAndisNumeric = true]);

  /// Returns `maxLength` of the formatter, default is `14`.
  @override
  int get maxLength => 14;

  bool _isInvalidLengthAndIsNotNumeric(TextEditingValue newValue) {
    if (!checkLengthAndisNumeric) return false;

    return newValue.length(true) > maxLength ||
        !newValue.isNumeric(RubikRegExps.cnpjSpecialCharactersRegex, '');
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_isInvalidLengthAndIsNotNumeric(newValue)) return oldValue;

    if (newValue.length(true) >= maxLength) {
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
    if (text.isEmpty) return text;

    final buffer = StringBuffer()..write(text);

    if (const [2, 6].contains(length)) buffer.write('.');

    if (length == 10) buffer.write('/');

    if (length == 15) buffer.write('-');

    return buffer.toString();
  }

  /// Returns text in `CNPJ` format.
  /// {@tool snippet}
  /// ```dart
  /// final cnpj = RubikCNPJInputFormatter().parse('45487645000139');
  /// print(cnpj); // 45.487.645/0001-39
  /// ```
  /// {@end-tool}
  String parse(String text) => text.formatCNPJ;

  /// Returns a list of text in `CNPJ` format.
  /// {@tool snippet}
  /// ```dart
  /// final cnpjs = RubikCNPJInputFormatter.parseAll(['45487645000139', '45487645000139']);
  /// print(cnpjs); // [45.487.645/0001-39, 45.487.645/0001-39]
  /// ```
  /// {@end-tool}
  Strings parseAll(Strings values) => values.map(parse).toList();
}
