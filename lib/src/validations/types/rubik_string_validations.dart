import 'package:string_validator/string_validator.dart' as string_validator;

import '../../../rubik_utils.dart';

typedef RString = RubikStringValidations;

class RubikStringValidations extends RubikValidatorType {
  RubikStringValidations _add({
    required String key,
    required RubikCallbackAction<String, String> action,
  }) {
    required().types([String]);
    addValidate<String>(key: key, value: action);

    return this;
  }

  @override
  RubikValidatorType types(List<Type> types, {String? key, String? message}) {
    super.types(types, key: key, message: message);

    return this;
  }

  @override
  RubikValidatorType optional({String? key, String? message}) {
    super.optional(key: key, message: message);

    return this;
  }

  @override
  RubikStringValidations transform<T, R>(
    RubikCallbackAction<T, R?> value, [
    String? key,
  ]) {
    super.transform<T, R>(value, key);

    return this;
  }

  @override
  RubikStringValidations required({
    String? key,
    String? message = 'Campo obrigatório',
  }) {
    super.required(key: key, message: message);

    return this;
  }

  RubikStringValidations minLength(
    int min, {
    String? message,
    String key = 'minLength',
    bool includeEquals = true,
  }) {
    return _add(
      key: key,
      action: (value) {
        final length = value.length;
        final isValid = includeEquals ? length >= min : length > min;

        return isValid ? null : (message ?? 'Valor mínimo é $min');
      },
    );
  }

  RubikStringValidations maxLength(
    int max, {
    String? message,
    String key = 'maxLength',
    bool includeEquals = true,
  }) {
    return _add(
      key: key,
      action: (value) {
        final length = value.length;
        final isValid = includeEquals ? length <= max : length < max;

        return isValid ? null : message ?? 'Valor máximo é $max';
      },
    );
  }

  RubikStringValidations length(
    int len, {
    String key = 'length',
    String? message,
  }) {
    return _add(
      key: key,
      action: (value) {
        return value.length == len
            ? null
            : message ?? 'Deve ter $len caracteres';
      },
    );
  }

  RubikStringValidations cpf({
    String key = 'cpf',
    String message = 'CPF inválido',
  }) {
    return _add(
      key: key,
      action: (value) => RubikCPFValidator.isValid(value) ? null : message,
    );
  }

  RubikStringValidations cnpj({
    String key = 'cnpj',
    String message = 'CNPJ inválido',
  }) {
    return _add(
      key: key,
      action: (value) => RubikCNPJValidator.isValid(value) ? null : message,
    );
  }

  RubikStringValidations cpfOrCnpj({
    String key = 'cpfOrCnpj',
    String message = 'CPF/CNPJ inválido',
  }) {
    return _add(
      key: key,
      action: (value) {
        if (value.isCpf()) {
          return RubikCPFValidator.isValid(value) ? null : message;
        }

        if (value.isCnpj()) {
          return RubikCNPJValidator.isValid(value) ? null : message;
        }

        return message;
      },
    );
  }

  RubikStringValidations email({
    String key = 'email',
    String message = 'Email inválido',
  }) {
    return _add(
      key: key,
      action: (value) => string_validator.isEmail(value) ? null : message,
    );
  }

  RubikStringValidations url({
    String key = 'url',
    String message = 'URL inválida',
  }) {
    return _add(
      key: key,
      action: (value) => string_validator.isURL(value) ? null : message,
    );
  }

  RubikStringValidations uuid({
    String key = 'uuid',
    String message = 'UUID inválido',
  }) {
    return _add(
      key: key,
      action: (value) => string_validator.isUUID(value) ? null : message,
    );
  }

  RubikStringValidations creditCard({
    String key = 'creditCard',
    String message = 'Cartão de crédito inválido',
  }) {
    return _add(
      key: key,
      action: (value) => string_validator.isCreditCard(value) ? null : message,
    );
  }

  RubikStringValidations randomPixKey({
    String key = 'randomPixKey',
    String message = 'Chave aleatória inválida',
  }) {
    return _add(
      key: key,
      action: (value) =>
          RubikRegExps.randomPixKey.hasMatch(value) ? null : message,
    );
  }

  RubikStringValidations match(
    String pattern, {
    String key = 'match',
    String message = 'Valor inválido',
  }) {
    return _add(
      key: key,
      action: (value) => RegExp(pattern).hasMatch(value) ? null : message,
    );
  }

  RubikStringValidations includes(
    String str, {
    String key = 'includes',
    String? message,
  }) {
    return _add(
      key: key,
      action: (value) =>
          value.contains(str) ? null : message ?? '$str não encontrado',
    );
  }

  RubikStringValidations startsWith(
    String str, {
    String key = 'startsWith',
    String? message,
  }) {
    return _add(
      key: key,
      action: (value) {
        final isValid = value.startsWith(str);

        return isValid ? null : message ?? '$value não inicia com $str';
      },
    );
  }

  RubikStringValidations endsWith(
    String str, {
    String key = 'endsWith',
    String? message,
  }) {
    return _add(
      key: key,
      action: (value) {
        final isValid = value.endsWith(str);

        return isValid ? null : message ?? '$value não termina com $str';
      },
    );
  }

  RubikStringValidations equals(
    String str, {
    String? message,
    String key = 'equals',
    bool equalsIgnoreCase = false,
  }) {
    return _add(
      key: key,
      action: (value) {
        final isValid = equalsIgnoreCase
            ? value.toLowerCase() == str.toLowerCase()
            : value == str;

        return isValid ? null : message ?? '$value não é igual a $str';
      },
    );
  }

  RubikStringValidations ip({
    String key = 'ip',
    String? version,
    String message = 'IP inválido',
  }) {
    return _add(
      key: key,
      action: (value) => string_validator.isIP(value, version) ? null : message,
    );
  }

  RubikStringValidations date({
    String key = 'date',
    String message = 'Data inválida',
  }) {
    return _add(
      key: key,
      action: (value) {
        final match = RubikRegExps.dateRegex.firstMatch(value);
        if (match.isNull) return message;

        final date = match!.group(1)!.toList('-', '/');
        final firstItemIsYear = date.first.length == 4;

        final month = date[1].toInt!;
        final day = (firstItemIsYear ? date.last : date.first).toInt!;

        final isDay = day.isBetween(1, 31, needToBeEqual: true);
        final isMonth = month.isBetween(1, 12, needToBeEqual: true);

        return isDay && isMonth ? null : message;
      },
    );
  }

  String _relativeError(bool isRelative, int quantity) =>
      'Deve conter ${isRelative ? 'pelo menos ' : ''} $quantity';

  RubikStringValidations uppercase(
    int quantity, {
    String? message,
    String key = 'uppercase',
    bool isRelative = false,
  }) {
    return _add(
      key: key,
      action: (value) {
        final relativeError = _relativeError(isRelative, quantity);
        final newValue =
            value.replaceAll(RubikRegExps.contaisUppercaseRegex, '');

        final isValid = isRelative
            ? (value.length - newValue.length) >= quantity
            : (value.length - newValue.length) == quantity;

        return isValid ? null : message ?? '$relativeError letras maiúsculas';
      },
    );
  }

  RubikStringValidations lowercase(
    int quantity, {
    String? message,
    String key = 'lowercase',
    bool isRelative = false,
  }) {
    return _add(
      key: key,
      action: (value) {
        final relativeError = _relativeError(isRelative, quantity);
        final newValue =
            value.replaceAll(RubikRegExps.contaisLowercaseRegex, '');

        final isValid = isRelative
            ? (value.length - newValue.length) >= quantity
            : (value.length - newValue.length) == quantity;

        return isValid ? null : message ?? '$relativeError letras minúsculas';
      },
    );
  }

  RubikStringValidations digits(
    int quantity, {
    String? message,
    String key = 'digits',
    bool isRelative = false,
  }) {
    return _add(
      key: key,
      action: (value) {
        value = value.digitsOnly();
        final relativeError = _relativeError(isRelative, quantity);

        final isValid =
            isRelative ? value.length >= quantity : value.length == quantity;

        return isValid ? null : message ?? '$relativeError dígitos';
      },
    );
  }

  RubikStringValidations specialCharacters(
    int quantity, {
    String? message,
    bool isRelative = false,
    String key = 'specialCharacters',
  }) {
    return _add(
      key: key,
      action: (value) {
        final newValue = value.replaceAll(
          RubikRegExps.withoutLettersOrDigitsRegex,
          '',
        );
        final relativeError = _relativeError(isRelative, quantity);
        final isValid = isRelative
            ? newValue.length >= quantity
            : newValue.length == quantity;

        return isValid
            ? null
            : message ?? '$relativeError caracteres especiais';
      },
    );
  }

  RubikStringValidations digitSequence({
    String key = 'digitSequence',
    String message = 'Não pode conter sequência numérica',
  }) {
    return _add(
      key: key,
      action: (value) {
        for (int i = 1; i < value.length; i++) {
          final int? a = value[i].toInt;
          final int? b = value[i - 1].toInt;

          if (a == null || b == null) continue;

          return (a - 1) == b || (a + 1) == b ? message : null;
        }

        return null;
      },
    );
  }

  RubikStringValidations repetition({
    bool digitsOnly = true,
    String key = 'repetition',
    String message = 'Não deve conter repetição',
  }) {
    return _add(
      key: key,
      action: (value) {
        value = digitsOnly ? value.digitsOnly() : value;
        final matches = RubikRegExps.contaisRepetitionRegex.allMatches(value);

        return matches.isEmpty ? null : message;
      },
    );
  }

  RubikStringValidations confirmPassword(
    String password,
    RString schema, {
    String key = 'confirmPassword',
    String message = 'Senha não coincidem',
  }) {
    return _add(
      key: key,
      action: (value) {
        final initialValidation = schema.validate(value);
        if (initialValidation != null) return initialValidation;

        return password.compareTo(value) == 0 ? null : message;
      },
    );
  }

  RubikStringValidations toUpperCase({String key = 'transform_to_uppercase'}) {
    transform<String, String>((value) => value.toUpperCase(), key);

    return this;
  }

  RubikStringValidations toLowerCase({String key = 'transform_to_lowercase'}) {
    transform<String, String>((value) => value.toLowerCase(), key);

    return this;
  }
}
