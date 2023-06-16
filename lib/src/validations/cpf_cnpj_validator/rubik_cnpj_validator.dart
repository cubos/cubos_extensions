//Credits: CPF/CNPJ Validators
//https://github.com/leonardocaldas/flutter-cpf-cnpj-validator

import 'dart:math';

import '../../../rubik_utils.dart';

/// The `RubikCNPJValidator` is class to handle CNPJs.
/// {@tool snippet}
/// ```dart
/// import 'package:rubik_utils/rubik_utils.dart';
///
/// void main() {
///   final cnpj = '45487645000139';
///   print(RubikCNPJValidator.isValid(cnpj)); // true
///   print(RubikCNPJValidator.format(cnpj)); // '45.487.645/0001-39'
/// }
/// ```
/// {@end-tool}
class RubikCNPJValidator {
  static const int maxLength = 14;
  static const int maxLengthWithMask = 18;

  /// Compute the Verifier Digit (or 'Dígito Verificador (DV)' in PT-BR).
  /// You can learn more about the algorithm on [wikipedia (pt-br)](https://pt.wikipedia.org/wiki/D%C3%ADgito_verificador)
  static String _verifierDigit(String cnpj) {
    int sum = 0;
    int index = 2;
    final numbers = cnpj.split('').map((it) => int.parse(it)).toList();

    for (int number in numbers.reversed.toList()) {
      sum += number * index;
      index = (index == 9 ? 2 : index + 1);
    }

    final int mod = sum % 11;

    return (mod < 2 ? 0 : 11 - mod).toString();
  }

  /// Format a CNPJ string to the format `XX.XXX.XXX/XXXX-XX`
  /// {@tool snippet}
  /// ```dart
  /// RubikCNPJValidator.format('45487645000139'); // '45.487.645/0001-39'
  /// RubikCPFValidator.format('45.487.645/0001-39'); // '45.487.645/0001-39'
  /// ```
  /// {@end-tool}
  static String format(String cnpj) {
    cnpj = cnpj.digitsOnly();

    if (cnpj.length > maxLength) {
      final formatted = cnpj
          .safeSubstring(0, maxLength)
          .replaceAllMapped(RubikRegExps.cnpjRegex, _replaceByMatch);

      return formatted + cnpj.safeSubstring(maxLength);
    }

    return cnpj.replaceAllMapped(RubikRegExps.cnpjRegex, _replaceByMatch);
  }

  static String _replaceByMatch(Match m) =>
      '${m[1]}.${m[2]}.${m[3]}/${m[4]}-${m[5]}';

  /// Returns `true` if the CNPJ is valid or false otherwise.
  /// The `validateOnlyDigits` parameter is used to validate only the digits of the CNPJ,
  /// default is `true`.
  /// {@tool snippet}
  /// ```dart
  ///
  /// RubikCNPJValidator.isValid(null); // false
  /// RubikCNPJValidator.isValid(''); // false
  ///
  /// RubikCNPJValidator.isValid('45487645000139'); // true
  /// RubikCNPJValidator.isValid('45.487.645/0001-39'); // true
  ///
  /// RubikCNPJValidator.isValid('45487509'); // false
  /// RubikCNPJValidator.isValid('45.45/00-39'); // false
  /// ```
  /// {@end-tool}
  static bool isValid(String? cnpj) {
    cnpj = cnpj?.digitsOnly();
    if ((cnpj ?? '').isEmpty || cnpj!.length != maxLength) return false;

    if (RubikStrings.cnpjBlockList().contains(cnpj)) return false;

    String numbers = cnpj.substring(0, 12);
    numbers += _verifierDigit(numbers);
    numbers += _verifierDigit(numbers);

    return numbers.substring(numbers.length - 2) ==
        cnpj.substring(cnpj.length - 2);
  }

  /// Generate a random `CNPJ`, this method not consider valid CNPJs.
  /// This method can generate a formatted or unformatted CNPJ, the default is unformatted.
  /// {@tool snippet}
  /// ```dart
  /// RubikCNPJValidator.generate(); // '45487645000139'
  /// RubikCNPJValidator.generate(true); // '45.487.645/0001-39'
  /// ```
  /// {@end-tool}
  static String generate([bool formatted = false]) {
    final Random random = Random();
    final StringBuffer numbers = StringBuffer();

    for (var i = 0; i < 12; i += 1) {
      numbers.write(random.nextInt(9).toString());
    }

    numbers.write(_verifierDigit(numbers.toString()));
    numbers.write(_verifierDigit(numbers.toString()));

    return formatted ? format(numbers.toString()) : numbers.toString();
  }

  /// Returns `true` if all CNPJs are valid or false otherwise.
  /// The `validateOnlyDigits` parameter is used to validate only the digits of the CNPJs,
  /// default is `true`.
  /// {@tool snippet}
  /// ```dart
  /// RubikCNPJValidator.allAreValid(['45487645000139', '45.487.645/0001-39']); // true
  /// RubikCNPJValidator.allAreValid(['454839', '45.47./0039']); // false
  /// ```
  /// {@end-tool}
  static bool allAreValid(Strings cpfs) =>
      cpfs.every((it) => RubikCNPJValidator.isValid(it));
}
