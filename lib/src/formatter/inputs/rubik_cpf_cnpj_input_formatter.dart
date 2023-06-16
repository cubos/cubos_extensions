import 'package:flutter/services.dart';

import 'package:rubik_utils/rubik_utils.dart';

/// The `RubikCPFCNPJInputFormatter` class formats the text input
/// as `CPF` or `CNPJ`.
/// This formatter can be used with `TextField` or `TextFormField`.
/// {@tool snippet}
/// ```dart
/// final formatter = RubikCPFCNPJInputFormatter();
/// print(formatter.parse('34567890123')); // 345.678.901-23
/// print(formatter.parse('12345678901234')); // 12.345.678/9012-34
/// ```
/// {@end-tool}
class RubikCPFCNPJInputFormatter extends TextInputFormatter {
  final _formatters = <RubikFormatterBase>[
    RubikCPFInputFormatter(false),
    RubikCNPJInputFormatter(),
  ];

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final delegatedFormatter = _formatters.firstWhere(
      orElse: () => _formatters.last,
      (formatter) => formatter.maxLength! >= newValue.length(),
    );

    return delegatedFormatter.formatEditUpdate(oldValue, newValue);
  }

  /// Returns text in the format of `CPF` or `CNPJ`.
  /// {@tool snippet}
  /// ```dart
  /// final cpf = RubikCPFCNPJInputFormatter().parse('34567890123');
  /// print(cpf); //  345.678.901-23
  ///
  /// final cnpj = RubikCPFCNPJInputFormatter().parse('12345678901234');
  /// print(cnpj); // 12.345.678/9012-34
  /// ```
  /// {@end-tool}
  String parse(String text) => text.formatCPFCNPJ;
}
