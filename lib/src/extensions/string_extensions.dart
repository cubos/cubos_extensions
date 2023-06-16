import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:rubik_utils/rubik_utils.dart';

/// This extension provides methods to manipulate strings.
/// {@tool snippet}
/// ```dart
/// 'abc123xyz456'.withoutDigits() // returns 'abcxyz'
/// 'abc1#\$%tyop'.withoutDigits(true) // returns 'abctyop'
/// ```
/// {@end-tool}
extension RubikStringExtensions on String {
  /// O method `withoutDigits` returns only characters of a string
  /// {@tool snippet}
  /// ```dart
  /// 'abc123xyz456'.withoutDigits() // returns 'abcxyz'
  /// 'abc1#\$%tyop'.withoutDigits(true) // returns 'abctyop'
  /// ```
  /// {@end-tool}
  String withoutDigits([bool specialCharacters = false]) {
    return !specialCharacters
        ? replaceAll(RubikRegExps.withoutDigitsRegex, '')
        : replaceAll(RubikRegExps.withoutDigitsRegexSpecialCharacter, '');
  }

  /// O method `digitsOnly` returns only numbers of a string
  /// {@tool snippet}
  /// ```dart
  /// 'Abc123'.digitsOnly() // returns '123'
  /// 'Abc123 Asqw890'.digitsOnly(true) // returns '123 890'
  /// ```
  /// {@end-tool}
  String digitsOnly([bool includeWhitespace = false]) {
    return !includeWhitespace
        ? replaceAll(RubikRegExps.digitsOnlyRegex, '')
        : replaceAll(RubikRegExps.digitsOnlyWhiteSpaceRegex, '');
  }

  /// Returns only numbers of a `CPF` string, removing all special characters('.' and '-')
  /// {@tool snippet}
  /// ```dart
  /// '123.456.789-90'.cleanCpf // returns '12345678990'
  /// ```
  /// {@end-tool}
  String get cleanCpf => digitsOnly();

  /// Returns only numbers of a `CNPJ` string, removing all special characters('.' and '-')
  /// {@tool snippet}
  /// ```dart
  /// '12.345.678/0001-90'.cleanCnpj // returns '12345678000190'
  /// ```
  /// {@end-tool}
  String get cleanCnpj => digitsOnly();

  /// Returns only numbers of a `ZIPCODE` string, removing all special characters('.' and '-')
  /// {@tool snippet}
  /// ```dart
  /// '45810-000'.cleanZipCode // returns '45810000'
  /// ```
  /// {@end-tool}
  String get cleanZipCode => digitsOnly();

  /// Returns only numbers of a `Phone` string, removing all special characters.
  /// {@tool snippet}
  /// ```dart
  /// '+55 (73) 99999-9999'.cleanPhone // returns '55739999999999'
  /// ```
  /// {@end-tool}
  String get cleanPhone => digitsOnly();

  /// Returns `true` is the string is a number.
  /// {@tool snippet}
  /// ```dart
  /// '10.67'.isNumeric // returns true
  /// '23,67'.isNumeric // returns true
  /// 'Abc123'.isNumeric // returns false
  /// ```
  /// {@end-tool}
  bool get isNumeric {
    final sepator = replaceAll(',', '.').split('.');
    final hasMoreThanOneDecimalSeparator = sepator.length >= 2;

    if (hasMoreThanOneDecimalSeparator) {
      return sepator.every((it) => double.tryParse(it) != null);
    }

    return double.tryParse(this) != null;
  }

  /// Capitalize the first letter.
  /// {@tool snippet}
  /// ```dart
  /// 'Flutter is awesome'.capitalize // returns 'Fluter is awesome'
  /// ```
  String get capitalize {
    if (length > 1) return '${this[0].toUpperCase()}${substring(1)}';

    return toUpperCase();
  }

  /// Capitalize the first letter of each word.
  /// {@tool snippet}
  /// ```dart
  /// 'mr. john wick'.capitalizeWords // returns 'Mr. John Wick'
  /// ```
  String get capitalizeWords {
    if (isEmpty) return '';

    final whitespaceSeparated = split(' ');
    if (whitespaceSeparated.length == 1) return capitalize;

    return whitespaceSeparated.map((word) => word.capitalize).join(' ');
  }

  /// Return the first name of a string.
  /// {@tool snippet}
  /// ```dart
  /// 'John wick'.firstName // returns 'John'
  /// ```
  String get firstName {
    if (isEmpty) return this;

    return split(' ').first.capitalize;
  }

  /// Return the last name of a string.
  /// {@tool snippet}
  /// ```dart
  /// 'wick'.lastName // returns 'Wick'
  /// ```
  String get lastName {
    if (isEmpty) return this;

    final words = split(' ');
    if (words.length == 1) return this;

    return words.last.capitalize;
  }

  /// Return the last n characters of a string.
  /// {@tool snippet}
  /// ```dart
  /// 'John wick'.lastChars(2) // returns 'ck'
  /// ```
  /// {@end-tool}
  String lastChars([int n = 1]) {
    if (isEmpty) return this;

    final int range = length - n - 1;

    return range.isNegative ? this : substring(range);
  }

  /// Return user socialName of a string.
  /// {@tool snippet}
  /// ```dart
  /// 'Marcos Vinicius Santos Fernandes'.socialName // returns 'Marcos Santos'
  /// ```
  String get socialName {
    if (isEmpty) return this;

    final words = split(' ');
    if (words.length >= 2) {
      return '${words[0].capitalize} ${words[2].capitalize}';
    }

    return capitalize;
  }

  /// Returns `true` is the string contains uppercase characters.
  /// {@tool snippet}
  /// ```dart
  /// 'aBcD'.hasUppercase // returns true
  /// 'xyz'.hasUppercase // returns false
  /// ```
  /// {@end-tool}
  bool get hasUppercase => contains(RubikRegExps.contaisUppercaseRegex);

  /// Returns `true` is the string contains lowercase characters.
  /// {@tool snippet}
  /// ```dart
  /// 'aBcD'.hasLowercase // returns true
  /// 'XYZ'.hasLowercase // returns false
  /// ```
  /// {@end-tool}
  bool get hasLowercase => contains(RubikRegExps.contaisLowercaseRegex);

  /// Returns `true` is the string contains letters.
  /// {@tool snippet}
  /// ```dart
  /// '24h6A9a'.hasLetter // returns true
  /// '123'.hasLetter // returns false
  /// ```
  /// {@end-tool}
  bool get hasLetter => contains(RubikRegExps.contaisLetterRegex);

  /// Returns `true` is the string contains digits.
  /// {@tool snippet}
  /// ```dart
  /// '24h6A9a'.hasDigits // returns true
  /// 'abc'.hasDigits // returns false
  /// ```
  /// {@end-tool}
  bool get hasDigits => contains(RubikRegExps.contaisDigitsRegex);

  /// Returns `true` is the string contains special characters.
  /// {@tool snippet}
  /// ```dart
  /// '2h6A9a#@$%'.hasSpecialCharacters // returns true
  /// 'abc123'.hasSpecialCharacters // returns false
  /// ```
  /// {@end-tool}
  bool get hasSpecialCharacters =>
      contains(RubikRegExps.contaisSpecialCharactersRegex);

  /// Converts date formats `[ 'yyyy-mm-dd','yyyy/mm/dd','dd-mm-yyyy','dd/mm/yyyy' ]`
  /// or  String to Datetime. Returns null if the String is in the wrong format;
  /// {@tool snippet}
  /// ```dart
  /// '09/03/2023'.toDateTime // returns DateTime(2023, 03, 09)
  /// ```
  /// {@end-tool}
  DateTime? get toDateTime {
    final formattedString = replaceAll('/', '-');
    final dateSplit = formattedString.split('-');

    if (dateSplit.first.length != 4) {
      return DateTime.tryParse(dateSplit.reversed.join('-'));
    }

    return DateTime.tryParse(formattedString);
  }

  /// Converts `String` to Duration, return `Duration.zero` if the String is in
  /// the wrong format;
  /// {@tool snippet}
  /// ```dart
  /// '51:45'.toDuration // returns Duration(hours: 51, minutes: 45)
  /// '34'.toDuration // returns Duration.zero
  /// ```
  /// {@end-tool}
  Duration get toDuration {
    final match = RubikRegExps.partsDurationRegex.firstMatch(this);
    if (match == null) Duration.zero;

    return Duration(
      hours: int.parse(match?.group(1) ?? '0'),
      minutes: int.parse(match?.group(2) ?? '0'),
      seconds: int.parse(match?.group(3) ?? '0'),
      milliseconds: int.parse(match?.group(4) ?? '0'),
      microseconds: int.parse(match?.group(5) ?? '0'),
    );
  }

  /// Converts `String` to int, return null if the String is in the wrong format;
  /// /// {@tool snippet}
  /// ```dart
  /// '10'.toInt // returns 10
  /// ```
  /// {@end-tool}
  int? get toInt => int.tryParse(this);

  /// Converts `String` to double, return null if the String is in the wrong format;
  /// {@tool snippet}
  /// ```dart
  /// '10.5'.toDouble // returns 10.5
  /// ```
  /// {@end-tool}
  double? get toDouble => double.tryParse(this);

  /// Returns `true` is the string contais CPF length.
  /// {@tool snippet}
  /// ```dart
  /// '12345678990'.isCpf() // returns true
  /// '123.456.789-90'.isCpf(true) // returns true
  /// ```
  /// {@end-tool}
  bool isCpf([bool includeMask = false]) {
    return includeMask
        ? length == RubikCPFValidator.maxLengthWithMask
        : digitsOnly().length == RubikCPFValidator.maxLength;
  }

  /// Returns `true` is the string contais CNPJ length.
  /// {@tool snippet}
  /// ```dart
  /// '36839395000168'.isCnpj() // returns true
  /// '22.134.381/0001-34'.isCnpj(true) // returns true
  /// ```
  /// {@end-tool}
  bool isCnpj([bool includeMask = false]) {
    return includeMask
        ? length == RubikCNPJValidator.maxLengthWithMask
        : digitsOnly().length == RubikCNPJValidator.maxLength;
  }

  /// Returns `true` is the string contais CPF or CNPJ length.
  /// {@tool snippet}
  /// ```dart
  /// '12345678990'.isCpfOrCnpj() // returns true
  /// '36839395000168'.isCpfOrCnpj() // returns true
  /// ```
  /// {@end-tool}
  bool isCpfOrCnpj([bool includeMask = false]) =>
      isCpf(includeMask) || isCnpj(includeMask);

  /// Returns `new String` removing all hard space.
  /// {@tool snippet}
  /// ```dart
  /// 'a\u00A0b'.noNBSP() // returns 'ab'
  /// ```
  /// {@end-tool}
  String get noNBSP => replaceAll(String.fromCharCode(0xa0), '');

  /// Returns `true` if the string is a valid boolean in string format.
  /// {@tool snippet}
  /// ```dart
  /// 'true'.toBool() // returns true
  /// 'false'.toBool() // returns false
  /// ```
  /// {@end-tool}
  bool get toBool => ['1', 'true'].contains(toLowerCase());

  /// Converts `String` to `Base64`.
  /// {@tool snippet}
  /// ```dart
  /// 'Hello World'.toBase64 // returns 'SGVsbG8gV29ybGQ='
  /// ```
  /// {@end-tool}
  String get toBase64 => base64Encode(utf8.encode(this));

  /// Converts `Base64` to `String`.
  /// {@tool snippet}
  /// ```dart
  /// 'SGVsbG8gV29ybGQ='.fromBase64 // returns 'Hello World'
  /// ```
  /// {@end-tool}
  String get fromBase64 => utf8.decode(base64Decode(this));

  /// Returns `new string` formatted with the given arguments.
  /// Similiar to `String.format` in python.
  /// {@tool snippet}
  /// ```dart
  /// 'Hello {}!'.format(['World']) // returns 'Hello World!'
  /// ```
  /// {@end-tool}
  String format(List<Object> args, {Pattern from = '{}'}) {
    String formatted = this;

    for (final it in args) {
      formatted = formatted.replaceFirst(from, it.toString());
    }

    return formatted;
  }

  /// Returns `substring` of this string from `start`, inclusive, to `end`,
  /// For cases where either `start` or `end` is invalid.
  /// {@tool snippet}
  /// ```dart
  /// const string = 'dartlang';
  ///
  /// print(string.safeSubstring(0, 4)); // 'dart'
  /// print(string.safeSubstring(4, 0)); // 'trad'
  ///
  /// print(string.safeSubstring(-1, -4)); //  'art'
  /// print(string.safeSubstring(-4, -1)); //  'tra'
  /// ```
  /// {@end-tool}
  String safeSubstring(int start, [int? end]) {
    end = end?.abs();
    start = start.abs();

    start = start >= length ? length : start;
    end = end.isNotNull && end! >= length ? length : end;

    if (end.isNotNull && start > end!) {
      return substring(end, start).split('').reversed.join();
    }

    return substring(start, end);
  }

  /// Convert any `string` to `TextEditingValue`.
  /// {@tool snippet}
  /// ```dart
  /// 'dartlang'.toEditingValue // TextEditingValue(text: 'dartlang')
  /// ```
  /// {@end-tool}
  TextEditingValue get toEditingValue => TextEditingValue(text: this);

  /// Returns `list of string` from `string` separated by `separator`.
  /// {@tool snippet}
  /// ```dart
  /// 'dartlang'.toList() // ['d', 'a', 'r', 't', 'l', 'a', 'n', 'g']
  /// ```
  /// {@end-tool}
  Strings toList([String separator = '', String? replace]) {
    if (replace.isNull) return split(separator);

    return replaceAll(replace!, separator).split(separator);
  }

  /// Returns `new string` with all characters reversed
  /// {@tool snippet}
  /// ```dart
  /// 'dartlang'.reversed // 'gnaltrad'
  /// ```
  /// {@end-tool}
  String get reversed => toList().reversed.join();

  /// Returns `new string` with all characters reversed as `List<String>`
  /// {@tool snippet}
  /// ```dart
  ///'dartlang'.toReversedList // ['g', 'n', 'a', 'l', 't', 'r', 'a', 'd']
  /// ```
  /// {@end-tool}
  Strings get toReversedList => reversed.toList();

  /// Returns new `String` formatted as `CPF`.
  /// This format is `000.000.000-00`, this formatting is not considered validation.
  /// {@tool snippet}
  /// ```dart
  /// '12345678990'.formatCPF // returns '123.456.789-90'
  /// ```
  /// {@end-tool}
  String get formatCPF => RubikCPFValidator.format(digitsOnly());

  /// Returns new `String` formatted as `CNPJ`.
  /// This format is `00.000.000/0000-00`, this formatting is not considered validation.
  /// {@tool snippet}
  /// ```dart
  /// '36839395000168'.formatCNPJ // returns '36.839.395/0001-68'
  /// ```
  /// {@end-tool}
  String get formatCNPJ => RubikCNPJValidator.format(digitsOnly());

  /// Returns new `String` formatted as `CPF` or `CNPJ`.
  /// This format is `000.000.000-00` or `00.000.000/0000-00`, this formatting
  /// is not considered validation.
  /// {@tool snippet}
  /// ```dart
  /// '12345678990'.formatCPFCNPJ // returns '123.456.789-90'
  /// '36839395000168'.formatCPFCNPJ // returns '36.839.395/0001-68'
  /// ```
  /// {@end-tool}
  String get formatCPFCNPJ {
    final cpfFormatted = isCpf() ? formatCPF : this;

    return isCnpj() ? formatCNPJ : cpfFormatted;
  }

  /// Returns new `String` formatted as `Phone`.
  /// This format is `(00) 0000-0000`, `(00) 00000-0000` or `00 (00) 00000-0000`,
  /// this formatting is not considered validation.
  /// {@tool snippet}
  /// ```dart
  /// '987654321'.formatPhone // returns '98765-4321'
  /// '11987654321'.formatPhone // returns '(11) 98765-4321'
  /// '5511987654321'.formatPhone // returns '+55 (11) 98765-4321'
  /// ```
  /// {@end-tool}
  String get formatPhone {
    if (isEmpty) return this;

    String digits = cleanPhone;
    final int length = digits.length;

    String phoneParts(int start, [int? end]) => digits.substring(start, end);

    final formatters = <int, Function>{
      8: () => '${phoneParts(0, 4)}-${phoneParts(4)}',
      9: () => '${phoneParts(0, 5)}-${phoneParts(5)}',
      10: () => '(0${phoneParts(0, 1)}) ${phoneParts(1, 6)}-${phoneParts(6)}',
      11: () => '(${phoneParts(0, 2)}) ${phoneParts(2, 7)}-${phoneParts(7)}',
    };

    if (digits.length > 11) {
      digits = digits.reversed;

      final line = phoneParts(0, 4).reversed;
      final prefix = phoneParts(4, 9).reversed;
      final areaCode = phoneParts(9, 11).reversed;
      final countryCode = phoneParts(11).reversed;

      return '+$countryCode ($areaCode) $prefix-$line';
    }

    return formatters[length]?.call() ?? this;
  }

  /// Retuns `new string` applying `mask` to `this`.
  /// Consider `range` is valid to `CPF`, case `range` is not valid, the `mask` is not applied.
  /// {@tool snippet}
  /// ```dart
  /// '12345678990'.maskObscuredCPF() //  '123.***.***-90'
  /// '123.456.789-09'.maskObscuredCPF() //  '123.***.***-90'
  ///
  /// const end = RubikRange(start: 6, end: 96, mask: '***');
  /// const start = RubikRange(start: 4, end: 7, mask: '***');
  ///
  /// '123.456.789-09'.maskObscuredCPF(start, end); // '123.***.789-09'
  /// ```
  /// {@end-tool}
  String maskObscuredCPF([
    RubikRange start = const RubikRange(start: 0, end: 3, mask: '***'),
    RubikRange end = const RubikRange(start: 12, end: 14, mask: '**'),
  ]) {
    var formatted = formatCPF;

    if (!formatted.isCpf(true)) return this;

    if (start.isValid(RubikCPFValidator.maxLengthWithMask)) {
      formatted = formatted.replaceRange(start.start, start.end, start.mask);
    }

    if (end.isValid(RubikCPFValidator.maxLengthWithMask)) {
      formatted = formatted.replaceRange(end.start, end.end, end.mask);
    }

    return formatted;
  }
}
