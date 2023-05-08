import 'package:flutter/services.dart';

import 'package:rubik_utils/src/extensions/object_extensions.dart';

import '../extensions/string_extensions.dart';

typedef RubikFormatter = String Function(String value);

/// The `RubikFormatterBase` class is the base class for all formatters.
/// {@tool snippet}
/// ```dart
/// final formatter = RubikFormatterBase(
///  maxLength: 14,
///  placeholder: 'X.X',
///  formatter: (value) => value.replaceAll('X', '#'),
/// );
///
/// print(formatter.formatEditUpdate('', '') // '#.#'
/// print(formatter.formatEditUpdate('', '1X.X') //  1#.#'
/// ```
/// {@end-tool}
abstract class RubikFormatterBase extends TextInputFormatter {
  final int? maxLength;
  final String? placeholder;
  final RubikFormatter? formatter;

  RubikFormatterBase({
    this.maxLength,
    this.formatter,
    this.placeholder,
  });

  /// Returns the `TextEditingValue` applying the `placeholder` callback.
  /// {@tool snippet}
  /// ```dart
  /// final formatter = TestFormatter(
  ///  placeholder: 'placeholder',
  /// );
  ///
  /// final textEditingValue = TextEditingValue(text: '123');
  /// print(formatter.applyPlaceholder(textEditingValue)); // 123placeholder
  /// ```
  /// {@end-tool}
  TextEditingValue applyPlaceholder(TextEditingValue oldValue) {
    if (placeholder.isNull) return oldValue;
    final text = oldValue.text + placeholder!;

    return oldValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  /// Returns the `TextEditingValue` applying the `formatter` callback.
  /// {@tool snippet}
  /// ```dart
  /// final formatter = TestFormatter(
  ///   formatter: (value) => value.replaceAll('a', 'b'),
  /// );
  ///
  /// final textEditingValue = TextEditingValue(text: 'abc');
  /// print(formatter.applyFormatter(textEditingValue)); // bbc
  /// ```
  /// {@end-tool}
  TextEditingValue applyFormatter(TextEditingValue value) {
    if (formatter == null) return value;

    final formatted = formatter!.call(value.text);

    return value.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  /// Returns the `new text` removing the `last character`.
  /// {@tool snippet}
  /// ```dart
  /// print( RubikFormatterBase().remove('123.456.789-')); // 123.456.789
  /// print( RubikFormatterBase().remove('123.456.789/')); // 123.456.789
  /// ```
  /// {@end-tool}
  String remove(String text) => text.safeSubstring(0, text.length - 1);
}

extension RubikTextEditingValueExtension on TextEditingValue {
  /// Returns the `text` without `non digits` characters.
  /// {@tool snippet}
  /// ```dart
  /// final textEditingValue = TextEditingValue(text: 'A1B2C3D4');
  /// print(textEditingValue.digitsOnly); // 1234
  /// ```
  /// {@end-tool}
  String get digitsOnly => text.digitsOnly();

  /// Returns the `new text` replacing all `matches` with `replacement`.
  /// {@tool snippet}
  /// ```dart
  /// final textEditingValue = TextEditingValue(text: 'A1B2C3D4');
  /// print(textEditingValue.replaceAll(RegExp(r'[A-Z]'), '')); // 1234
  /// ```
  /// {@end-tool}
  String replaceAll(Pattern regExp, String replacement) {
    return text.replaceAll(regExp, replacement);
  }

  /// Returns `true` if the `text` is numeric.
  /// Can be used with a `RegExp` replacing current `text` with `replacement`.
  /// {@tool snippet}
  /// ```dart
  /// final textEditingValue = TextEditingValue(text: '1234567890');
  /// print(textEditingValue.isNumeric()); // true
  ///
  /// final textEditingValue2 = TextEditingValue(text: 'A1B2C3D4');
  /// print(textEditingValue2.isNumeric(RegExp(r'[A-Z]'), '')); // true
  /// ```
  /// {@end-tool}
  bool isNumeric([RegExp? regExp, String? replacement]) {
    return replaceAll(regExp ?? '', replacement ?? '').isNumeric;
  }

  /// Returns the `length` of the `text`.
  /// Can be used with `isDigitsOnly` to return the `length` replacing `non digits` characters.
  /// {@tool snippet}
  /// ```dart
  /// final textEditingValue = TextEditingValue(text: 'A1B2C3D4');
  /// print(textEditingValue.length()); // 8
  /// print(textEditingValue.length(true)); // 4
  /// ```
  /// {@end-tool}
  int length([bool isDigitsOnly = false]) {
    return isDigitsOnly ? digitsOnly.length : text.length;
  }

  /// Returns `true` if length of `TextEditingValue` is greater than the
  /// `length` of old `TextEditingValue`.
  /// Used to check if the user is adding text or removing characters in inputs formatters
  /// {@tool snippet}
  /// ```dart
  /// final oldValue = TextEditingValue(text: 'dartlang');
  /// final newValue = TextEditingValue(text: 'dartlan');
  ///
  /// print(oldValue.isDeletingText(newValue)); // true
  /// ```
  /// {@end-tool}
  bool isDeletingText(TextEditingValue newValue) {
    return length() > newValue.length();
  }
}
