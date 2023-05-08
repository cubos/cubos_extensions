//Credits: CPF/CNPJ Validators
//https://github.com/leonardocaldas/flutter-cpf-cnpj-validator

import 'dart:math';

import '../../../rubik_utils.dart';

/// The `RubikCPFValidator` is class to handle CPFs.
/// {@tool snippet}
/// ```dart
/// import 'package:rubik_utils/rubik_utils.dart';
///
/// void main() {
///   final cpf = '35999906032';
///   print(RubikCPFValidator.isValid(cpf)); // true
///   print(RubikCPFValidator.format(cpf)); // '359.999.060-32'
/// }
/// ```
/// {@end-tool}
abstract class RubikCPFValidator {
  static const int maxLength = 11;
  static const int maxLengthWithMask = 14;

  /// Compute the Verifier Digit (or 'Dígito Verificador (DV)' in PT-BR).
  /// You can learn more about the algorithm on [wikipedia (pt-br)](https://pt.wikipedia.org/wiki/D%C3%ADgito_verificador)
  static String _verifierDigit(String cpf) {
    var numbers = cpf.split('').map((it) => int.parse(it, radix: 10)).toList();

    final int modulus = numbers.length + 1;
    final RubikIntegers multiplied = <int>[];

    for (int i = 0; i < numbers.length; i++) {
      multiplied.add(numbers[i] * (modulus - i));
    }

    final mod = multiplied.reduce((buffer, number) => buffer + number) % 11;

    return (mod < 2 ? 0 : 11 - mod).toString();
  }

  /// Format a CPF string to the format `XXX.XXX.XXX-XX`
  /// {@tool snippet}
  /// ```dart
  /// RubikCPFValidator.format('35999906032'); // '359.999.060-32'
  /// RubikCPFValidator.format('359.999.060-32'); // '359.999.060-32'
  /// ```
  /// {@end-tool}
  static String format(String cpf, [bool forceFormatted = false]) {
    cpf = cpf.digitsOnly();

    if (forceFormatted && cpf.length > maxLength) {
      final formatted = cpf
          .safeSubstring(0, maxLength)
          .replaceAllMapped(RubikRegExps.cpfRegex, _replaceByMatch);

      return formatted + cpf.safeSubstring(maxLength);
    }

    return cpf.replaceAllMapped(RubikRegExps.cpfRegex, _replaceByMatch);
  }

  static String _replaceByMatch(Match m) => '${m[1]}.${m[2]}.${m[3]}-${m[4]}';

  /// Returns `true` if the CPF is valid or false otherwise.
  /// The `validateOnlyDigits` parameter is used to validate only the digits of the CPF,
  /// default is `true`.
  /// {@tool snippet}
  /// ```dart
  ///
  /// RubikCPFValidator.isValid(null); // false
  /// RubikCPFValidator.isValid(''); // false
  ///
  /// RubikCPFValidator.isValid('35999906032'); // true
  /// RubikCPFValidator.isValid('359.999.060-32'); // true
  ///
  /// RubikCPFValidator.isValid('35999906031'); // false
  /// RubikCPFValidator.isValid('03.3461.67100-2'); // false
  /// ```
  /// {@end-tool}
  static bool isValid(String? cpf) {
    cpf = cpf?.digitsOnly();
    if ((cpf ?? '').isEmpty || cpf!.length != maxLength) return false;

    if (RubikStrings.cpfBlockList().contains(cpf)) return false;

    String numbers = cpf.substring(0, 9);
    numbers += _verifierDigit(numbers);
    numbers += _verifierDigit(numbers);

    return numbers.substring(numbers.length - 2) ==
        cpf.substring(cpf.length - 2);
  }

  /// Generate a random `CPF`, this method not consider valid CPFs.
  /// This method can generate a formatted or unformatted CPF, the default is unformatted.
  /// {@tool snippet}
  /// ```dart
  /// RubikCPFValidator.generate(); // '35999906032'
  /// RubikCPFValidator.generate(true); // '359.999.060-32'
  /// ```
  /// {@end-tool}
  static String generate([bool formatted = false]) {
    final Random random = Random();
    final StringBuffer numbers = StringBuffer();

    for (var i = 0; i < 9; i += 1) {
      numbers.write(random.nextInt(9).toString());
    }

    numbers.write(_verifierDigit(numbers.toString()));
    numbers.write(_verifierDigit(numbers.toString()));

    return formatted ? format(numbers.toString()) : numbers.toString();
  }

  /// Returns `true` if all CPFs are valid or false otherwise.
  /// The `validateOnlyDigits` parameter is used to validate only the digits of the CPFs,
  /// default is `true`.
  /// {@tool snippet}
  /// ```dart
  /// RubikCPFValidator.allAreValid(['35999906032', '359.999.060-32']); // true
  /// RubikCPFValidator.allAreValid(['35932', '359.99931']); // false
  /// ```
  /// {@end-tool}
  static bool allAreValid(Strings cpfs) =>
      cpfs.every((it) => RubikCPFValidator.isValid(it));
}
