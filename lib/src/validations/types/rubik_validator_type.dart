import '../../extensions/object_extensions.dart';

/// A typedef representing a callback function that takes a generic type `T` as
/// its input and returns an optional generic type `R`.
///
/// The `RubikCallbackAction` function type is used to define a function that
/// can be passed as a callback to another function or method. It takes a single
/// argument of type `T`, and returns an optional value of type `R`.
/// {@tool snippet}
/// ```dart
/// RubikCallbackAction<int, String> callback = (int value) => value.toString()
/// print(callback(42)); // returns '42'
/// ```
/// {@end-tool}
typedef RubikCallbackAction<T, R> = R? Function(T);
typedef RubikActionEvent = void Function(String, Object?);

/// The `RubikFieldAction` an class  abstract class representing an action that can be executed on a field.
/// It has two generic type parameters, `T` and `R`,
/// that represent the types of the input value and the return value of the
/// action's `execute` method, respectively.
///
/// Example usage:
/// {@tool snippet}
/// ```dart
/// class MyAction extends RubikFieldAction<int, String> {
///   String execute(int value) => value.toString()
/// }
///
/// final MyAction action = MyAction();
/// print(action.execute(42)); // returns '42'
/// ```
/// {@end-tool}
abstract class RubikFieldAction<T, R> {
  String get key;
  R execute(T value);
}

/// The `RubikValidationAction` is class representing a validation action that can be executed on a field.
///
/// The `RubikValidationAction` class has a final field `validator` of type
/// `RubikCallbackAction<T, String>`, which is used to validate the input value
/// of the action's `execute` method.
///
/// Example usage:
/// {@tool snippet}
/// ```dart
/// final action = RubikValidationAction<int>(
///   (int value) => value > 0 ? null : 'Value must be positive',
/// );
///
/// print(action.execute(12)); // returns null
/// print(action.execute(-1)); // returns 'Value must be positive'
/// ```
/// {@end-tool}
class RubikValidationAction<T> implements RubikFieldAction<T, String?> {
  @override
  final String key;

  final RubikCallbackAction<T, String> validator;
  const RubikValidationAction(this.validator, this.key);

  @override
  String? execute(T value) => validator.call(value);
}

/// The `RubikTransformAction` is class representing a transform action that can
/// be executed on a field.
///
/// The `RubikTransformAction` class has a final field `transform` of type
/// `RubikCallbackAction<T, R>`, which is used to transform the input value of
/// the action's `execute` method.
///
/// Example usage:
/// {@tool snippet}
/// ```dart
/// final action = RubikTransformAction<int, String>(
///   (int value) => 'value_$value'
/// );
///
/// print(action.execute(42)); // 'value_42'
/// ```
/// {@end-tool}
class RubikTransformAction<T, R> implements RubikFieldAction<T, R?> {
  @override
  final String key;

  final RubikCallbackAction<T, R> transform;
  const RubikTransformAction(this.transform, this.key);

  @override
  R? execute(T value) => transform.call(value);
}

/// The `RubikValidatorType` is abstract class representing a validator type
/// that can be used to validate and transform input values for a field.
///
/// The `RubikValidatorType` class defines several methods for adding validation
/// and transformation actions to the validator. Each of these methods returns an
/// instance of the `RubikValidatorType` class, which allows for method chaining.
///
/// The `RubikValidatorType` class also implements a `validate` method, which
/// takes an input value and executes each of the validator's actions on it. If
/// any action returns a non-null value, the `validate` method returns that value,
/// indicating that the input value is invalid. Otherwise, if all actions execute
/// successfully, the `validate` method returns `null`, indicating that the input
/// value is valid.
///
/// Example usage:
/// {@tool snippet}
/// ```dart
/// class MyValidator extends RubikValidatorType {}
///
/// final validator = MyValidator()
///   .require(message: 'This field is required')
///   .transform<String, int>((value) => int.tryParse(value))
///   .types([int, double], message: 'This field must be a number')
///   .addValidate((value) => value > 0 ? null : 'This field must be positive');
///
/// print(validator.validate('42.0')); // returns null
/// print(validator.validate('-1')); // returns 'This field must be positive'
/// ```
/// {@end-tool}
abstract class RubikValidatorType {
  final List<RubikFieldAction> _actions = [];

  /// Adds a new validation action to the validator, which executes the specified
  /// `value` function on the input value.
  ///
  /// The `addValidate` method takes a function with a generic type parameter `T`
  /// and a return type of `String?`. This function is wrapped in a `RubikValidationAction`
  /// instance and added to the validator's action list.
  ///
  /// Example usage:
  /// {@tool snippet}
  /// ```dart
  /// class MyValidator extends RubikValidatorType {}
  ///
  /// final validator = MyValidator()
  ///   .addValidate<String>((value) => value.isNotEmpty ? null : 'This field is required');
  ///
  /// print(validator.validate('John Doe')); // returns null
  /// ```
  /// {@end-tool}
  RubikValidatorType addValidate<T>({
    required String key,
    required RubikCallbackAction<T, String?> value,
  }) {
    _actions.add(RubikValidationAction<T>(value, key));

    return this;
  }

  /// Adds a new transform action to the validator, which executes the specified
  /// `value` function on the input value.
  ///
  /// The `transform` method takes a function with generic type parameters `T` and `R`.
  /// This function is wrapped in a `RubikTransformAction` instance and added to the
  /// validator's action list.
  ///
  /// Example usage:
  /// {@tool snippet}
  /// ```dart
  /// class MyValidator extends RubikValidatorType {}
  ///
  /// final validator = MyValidator()
  ///   .transform<String, int>((value) => int.tryParse(value))
  ///   .types([int, double], message: 'This field must be a number')
  ///
  /// print(validator.validate('42')); // returns null
  /// print(validator.validate('John Doe')); // returns 'This field must be a number'
  /// ```
  /// {@end-tool}
  RubikValidatorType transform<T, R>(
    RubikCallbackAction<T, R?> value, [
    String? key,
  ]) {
    _actions.add(RubikTransformAction<T, R>(
      value,
      key ?? 'trasform_${value.hashCode}',
    ));

    return this;
  }

  /// Adds a validation action that requires a non-null value.
  ///
  /// The `required` method takes an optional `message` parameter, which is used
  /// as the error message if the input value is null.
  ///
  /// Example usage:
  /// {@tool snippet}
  /// ```dart
  /// final validator = MyValidator().required(message: 'This field is required');
  ///
  /// print(validator.validate('John Doe')); // returns null
  /// print(validator.validate(null)); // returns 'This field is required'
  /// ```
  /// {@end-tool}
  RubikValidatorType required({String? key, String? message}) {
    return addValidate(
      key: key ?? 'required',
      value: (value) {
        return value == null ||
                (value is Map && value.isEmpty) ||
                (value is Set && value.isEmpty) ||
                (value is Iterable && value.isEmpty) ||
                (value is List && value.isEmpty) ||
                (value is String && value.trim().isEmpty)
            ? message ?? 'Campo obrigatório'
            : null;
      },
    );
  }

  /// Adds a validation action that allows a null value.
  ///
  /// The `optional` method takes an optional `message` parameter, which is used
  /// as the error message if the input value is not null.
  ///
  /// Example usage:
  /// {@tool snippet}
  /// ```dart
  /// final validator = MyValidator().optional(message: 'This field is optional');
  ///
  /// print(validator.validate('John Doe')); // returns null
  /// print(validator.validate(null)); // returns null
  /// ```
  /// {@end-tool}
  RubikValidatorType optional({String? key, String? message}) {
    return addValidate(key: key ?? 'optional', value: (value) => null);
  }

  /// Adds a validation action that checks if the input value is an instance of
  /// one of the specified types.
  ///
  /// The `types` method takes a list of types and an optional `message` parameter,
  /// which is used as the error message if the input value is not an instance of
  /// one of the specified types.
  ///
  /// Example usage:
  /// {@tool snippet}
  /// ```dart
  /// final validator = MyValidator()
  ///   .types([int, double], message: 'This field must be a number');
  ///
  /// print(validator.validate(42)); // returns null
  /// print(validator.validate('John Doe')); // returns 'This field must be a number'
  /// ```
  /// {@end-tool}
  RubikValidatorType types(List<Type> types, {String? key, String? message}) {
    return addValidate(
      key: 'types',
      value: (value) {
        final isValid = types.contains(value.runtimeType);

        return isValid ? null : message ?? 'O tipo $value não é válido';
      },
    );
  }

  /// Adds a validation action that checks if the input value is equal to one of
  /// the specified values.
  ///
  /// The `values` method takes a list of values and an optional `message` parameter,
  /// which is used as the error message if the input value is not equal to one of
  /// the specified values.
  ///
  /// Example usage:
  /// {@tool snippet}
  /// ```dart
  /// final validator = MyValidator().require().types([int, double]);
  ///
  /// print(validator.validate(42)); // returns null
  /// print(validator.validate('John Doe')); // returns 'This field must be a number'
  /// ```
  /// {@end-tool}
  String? validate(Object? value, [RubikActionEvent? event]) {
    for (final action in _actions) {
      if (action.isInstanceOf<RubikTransformAction>()) {
        value = (action as RubikTransformAction).execute(value);
        event?.call(action.key, value);

        continue;
      }

      final result = action.execute(value);
      event?.call(action.key, result);

      if (result != null) return result;
    }

    return null;
  }

  /// Converts the input value using the validator's transform actions.
  /// If the input value fails any of the validator's validation actions, the
  /// `parse` method returns null.
  ///
  /// Example usage:
  /// {@tool snippet}
  /// ```dart
  /// final schema = MyValidator()
  ///  .transform<String, int>((value) => int.tryParse(value))
  /// .types([int, double], message: 'This field must be a number');
  ///
  /// print(schema.parse('42')); // returns 42
  /// print(schema.parse('John Doe')); // returns null
  /// ```
  /// {@end-tool}
  ({TResult? result, String? error})
      parse<TInput extends Object, TResult extends Object>(
    TInput? value,
  ) {
    Object? newValue;

    for (final action in _actions) {
      if (action.isInstanceOf<RubikValidationAction>()) {
        final error = action.execute(value);
        if (error != null) return (result: null, error: error);

        continue;
      }

      newValue = (action as RubikTransformAction).execute(newValue ?? value);
    }

    return (result: newValue as TResult?, error: null);
  }

  /// Clears all actions from the validator.
  /// {@tool snippet}
  /// ```dart
  /// final validator = MyValidator()
  ///   .addValidate((value) => value != null ? null : 'This field is required')
  ///  .clear();
  ///
  /// print(validator.validate('John Doe')); // returns null
  /// print(validator.validate(null)); // returns null
  /// ```
  /// {@end-tool}
  void clear() => _actions.clear();
}
