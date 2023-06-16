import 'package:string_validator/string_validator.dart' as string_validator;

import '../../../rubik_utils.dart';

typedef RString = RubikStringValidations;

class RubikStringValidations extends RubikValidatorType {
  RubikStringValidations._();
  factory RubikStringValidations() => instance;
  static final instance = RubikStringValidations._();

  RubikStringValidations _add(RubikCallbackAction<String, String> action) {
    super.required().types([String]);
    addValidate<String>(action);

    return this;
  }

  RubikStringValidations minLength(
    int min, {
    String? message,
    bool includeEquals = true,
  }) {
    return _add((value) {
      final length = value.length;
      final isValid = includeEquals ? length <= min : length < min;

      return isValid ? null : (message ?? 'Valor mínimo é $min');
    });
  }

  RubikStringValidations maxLength(
    int max, {
    String? message,
    bool includeEquals = true,
  }) {
    return _add((value) {
      final length = value.length;
      final isValid = includeEquals ? length <= max : length < max;

      return isValid ? null : message ?? 'Valor máximo é $max';
    });
  }

  RubikStringValidations length(int len, {String? message}) {
    return _add((value) {
      return value.length == len ? null : message ?? 'Deve ter $len caracteres';
    });
  }

  RubikStringValidations cpf({String message = 'CPF inválido'}) {
    return _add((value) => RubikCPFValidator.isValid(value) ? null : message);
  }

  RubikStringValidations cnpj({String message = 'CNPJ inválido'}) {
    return _add((value) => RubikCNPJValidator.isValid(value) ? null : message);
  }

  RubikStringValidations cpfOrCnpj({String message = 'CPF/CNPJ inválido'}) {
    return _add((value) {
      if (value.isCpf()) {
        return RubikCPFValidator.isValid(value) ? null : message;
      }

      if (value.isCnpj()) {
        return RubikCNPJValidator.isValid(value) ? null : message;
      }

      return message;
    });
  }

  RubikStringValidations email({String message = 'Email inválido'}) {
    return _add((value) => string_validator.isEmail(value) ? null : message);
  }

  RubikStringValidations url({String message = 'URL inválida'}) {
    return _add(
      (value) => string_validator.isURL(value) ? null : message,
    );
  }

  RubikStringValidations uuid({String message = 'UUID inválido'}) {
    return _add((value) => string_validator.isUUID(value) ? null : message);
  }

  RubikStringValidations creditCard({
    String message = 'Cartão de crédito inválido',
  }) {
    return _add(
      (value) => string_validator.isCreditCard(value) ? null : message,
    );
  }

  RubikStringValidations randomPixKey({
    String message = 'Chave aleatória inválida',
  }) {
    return _add(
      (value) => RubikRegExps.randomPixKey.hasMatch(value) ? null : message,
    );
  }

  RubikStringValidations match(
    String pattern, {
    String message = 'Valor inválido',
  }) {
    return _add((value) => RegExp(pattern).hasMatch(value) ? null : message);
  }

  RubikStringValidations includes(String str, {String? message}) {
    return _add(
      (value) => value.contains(str) ? null : message ?? '$str não encontrado',
    );
  }

  RubikStringValidations startsWith(String str, {String? message}) {
    return _add((value) {
      final isValid = value.startsWith(str);

      return isValid ? null : message ?? '$value não inicia com $str';
    });
  }

  RubikStringValidations endsWith(String str, {String? message}) {
    return _add((value) {
      final isValid = value.endsWith(str);

      return isValid ? null : message ?? '$value não termina com $str';
    });
  }

  RubikStringValidations equals(
    String str, {
    String? message,
    bool equalsIgnoreCase = false,
  }) {
    return _add((value) {
      final isValid = equalsIgnoreCase
          ? value.toLowerCase() == str.toLowerCase()
          : value == str;

      return isValid ? null : message ?? '$value não é igual a $str';
    });
  }

  RubikStringValidations ip({String? version, String message = 'IP inválido'}) {
    return _add(
      (value) => string_validator.isIP(value, version) ? null : message,
    );
  }

  RubikStringValidations date({String message = 'Data inválida'}) {
    return _add((value) {
      final match = RubikRegExps.dateRegex.firstMatch(value);
      if (match.isNull) return message;

      final date = match!.group(1)!.toList('-', '/');
      final firstItemIsYear = date.first.length == 4;

      final month = date[1].toInt!;
      final day = (firstItemIsYear ? date.last : date.first).toInt!;

      final isDay = day.isBetween(1, 31, needToBeEqual: true);
      final isMonth = month.isBetween(1, 12, needToBeEqual: true);

      return isDay && isMonth ? null : message;
    });
  }

  String _relativeError(bool isRelative, int quantity) =>
      'Deve conter ${isRelative ? 'pelo menos ' : ''} $quantity';

  RubikStringValidations uppercase(
    int quantity, {
    String? message,
    bool isRelative = false,
  }) {
    return _add((value) {
      final relativeError = _relativeError(isRelative, quantity);
      final newValue = value.replaceAll(RubikRegExps.contaisUppercaseRegex, '');

      final isValid = isRelative
          ? (value.length - newValue.length) >= quantity
          : (value.length - newValue.length) == quantity;

      return isValid ? null : message ?? '$relativeError letras maiúsculas';
    });
  }

  RubikStringValidations lowercase(
    int quantity, {
    String? message,
    bool isRelative = false,
  }) {
    return _add((value) {
      final relativeError = _relativeError(isRelative, quantity);
      final newValue = value.replaceAll(RubikRegExps.contaisLowercaseRegex, '');

      final isValid = isRelative
          ? (value.length - newValue.length) >= quantity
          : (value.length - newValue.length) == quantity;

      return isValid ? null : message ?? '$relativeError letras minúsculas';
    });
  }

  RubikStringValidations digits(
    int quantity, {
    String? message,
    bool isRelative = false,
  }) {
    return _add((value) {
      value = value.digitsOnly();
      final relativeError = _relativeError(isRelative, quantity);

      final isValid =
          isRelative ? value.length >= quantity : value.length == quantity;

      return isValid ? null : message ?? '$relativeError dígitos';
    });
  }

  RubikStringValidations specialCharacters(
    int quantity, {
    String? message,
    bool isRelative = false,
  }) {
    return _add((value) {
      final newValue = value.replaceAll(
        RubikRegExps.withoutLettersOrDigitsRegex,
        '',
      );
      final relativeError = _relativeError(isRelative, quantity);
      final isValid = isRelative
          ? newValue.length >= quantity
          : newValue.length == quantity;

      return isValid ? null : message ?? '$relativeError caracteres especiais';
    });
  }

  RubikStringValidations digitSequence({
    String message = 'Não pode conter sequência numérica',
  }) {
    return _add((value) {
      for (int i = 1; i < value.length; i++) {
        final int? a = value[i].toInt;
        final int? b = value[i - 1].toInt;

        if (a == null || b == null) continue;

        return (a - 1) == b || (a + 1) == b ? message : null;
      }

      return null;
    });
  }

  RubikStringValidations repetition({
    bool digitsOnly = true,
    String message = 'Não deve conter repetição',
  }) {
    return _add((value) {
      value = digitsOnly ? value.digitsOnly() : value;
      final matches = RubikRegExps.contaisRepetitionRegex.allMatches(value);

      return matches.isEmpty ? null : message;
    });
  }

  RubikStringValidations toUpperCase() {
    transform<String, String>((value) => value.toUpperCase());

    return this;
  }

  RubikStringValidations toLowerCase() {
    transform<String, String>((value) => value.toLowerCase());

    return this;
  }

  @override
  String? validate(Object? value) {
    final result = super.validate(value);
    super.clear();

    return result;
  }
}
