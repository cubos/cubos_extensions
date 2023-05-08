import 'package:rubik_utils/rubik_utils.dart';

extension RubikNullObjectExtension on Object? {
  /// Returns `true` if the object is `null`.
  ///
  /// To `dynamic` types this function returns expection `NoSuchMethodError`, so
  /// you can use `isNull` only for `Object` types.
  /// {@tool snippet}
  /// ```dart
  /// final object = null;
  /// print(object.isNull); // true
  /// ```
  /// {@end-tool}
  bool get isNull => this == null;

  /// Returns `true` if the object is not `null`.
  ///
  /// To `dynamic` types this function returns expection `NoSuchMethodError`, so
  /// you can use `isNull` only for `Object` types.
  /// {@tool snippet}
  /// ```dart
  /// final object = null;
  /// print(object.isNotNull); // false
  /// ```
  /// {@end-tool}
  bool get isNotNull => !isNull;

  /// Returns `true` if the object is an instance of the given `type`.
  ///
  /// To `dynamic` types this function returns expection `NoSuchMethodError`, so
  /// you can use `isNull` only for `Object` types.
  /// {@tool snippet}
  /// ```dart
  /// final object = 1;
  /// print(object.isInstanceOf<int>()); // true
  /// ```
  /// {@end-tool}
  bool isInstanceOf<T>() => this is T;

  /// Converts the object to the given `type`.
  /// {@tool snippet}
  /// ```dart
  /// 1.castAs<int>()); // 1
  /// 1.castAs<double>()); // 1.0
  ///
  /// 'true'.castAs<bool>();
  /// '10:24:45'.castAs<Duration>(); // Duration(hours: 10, minutes: 24, seconds: 45);
  /// ```
  /// {@end-tool}
  T castAs<T>({bool force = true, T? defaultValue}) {
    if (isInstanceOf<T>()) return this as T;

    if (!force) throw Exception('Cannot cast $this to $T');

    final castHandle = {
      'String': () => toString(),
      'int': () => toString().toInt,
      'bool': () => toString().toBool,
      'double': () => toString().toDouble,
      'Duration': () => toString().toDuration,
      'DateTime': () => toString().toDateTime,
    };

    final callbalck = castHandle[T.toString()];
    if (callbalck.isNull && defaultValue.isNull) {
      throw Exception('Unsupported cast to $T');
    }

    return (callbalck?.call() ?? defaultValue) as T;
  }

  /// Calls the given `action` if the object is `not null`.
  ///
  /// To `dynamic` types this function returns expection `NoSuchMethodError`, so
  /// you can use `isNull` only for `Object` types.
  /// {@tool snippet}
  /// ```dart
  /// final object = null;
  /// object.ifNotNull(() => print('The object is null'));
  /// ```
  /// {@end-tool}
  void ifNotNull(void Function(Object) action) {
    if (this != null) action(this!);
  }

  /// Returns the result of calling the given `action` with `this` value as its
  /// argument if the object is not `null`, otherwise returns `null`.
  ///
  /// To `dynamic` types this function returns expection `NoSuchMethodError`, so
  /// you can use `isNull` only for `Object` types.
  /// {@tool snippet}
  /// ```dart
  /// final int object = 1;
  /// object.ifNotNullThen<int, String>((it) => 'int: $it') // int: 1
  /// ```
  /// {@end-tool}
  R? ifNotNullThen<T, R>(R Function(T) action) {
    if (isNotNull) return action(castAs<T>());

    return null;
  }

  R? ifNullThen<T, R>(R Function(T) action) {
    if (isNull) return action(this as T);

    return null;
  }

  /// Returns `true` if the object is not `null` and not empty.
  ///
  /// To `dynamic` types this function returns expection `NoSuchMethodError`, so
  /// you can use `isNull` only for `Object` types.
  /// {@tool snippet}
  /// ```dart
  /// final int object = 1;
  /// print(object.isNotNullOrEmpty); // true
  /// ```
  /// {@end-tool}
  bool get isNotNullOrEmpty {
    if (isNull) return false;

    final types = <Type, bool Function()>{
      int: () => castAs<int>() != 0,
      double: () => castAs<double>() != 0,
      String: () => castAs<String>().isNotEmpty,
      Duration: () => castAs<Duration>() != Duration.zero,
      DateTime: () => castAs<DateTime>().microsecondsSinceEpoch != 0,
    };

    if (isInstanceOf<Set>()) {
      return castAs<Set>().isNotEmpty;
    } else if (isInstanceOf<List>()) {
      return castAs<List>().isNotEmpty;
    } else if (isInstanceOf<Map>()) {
      return castAs<Map>().isNotEmpty;
    }

    return types[runtimeType]?.call() ?? false;
  }

  /// Returns `className` of the object.
  ///
  /// To `dynamic` types this function returns expection `NoSuchMethodError`, so
  /// you can use `isNull` only for `Object` types.
  /// {@tool snippet}
  /// ```dart
  /// final int object = 1;
  /// print(object.className); // int
  /// ```
  /// {@end-tool}
  String get className => runtimeType.toString();

  /// Returns `className` of the object without generic.
  /// {@tool snippet}
  /// ```dart
  /// print(List<int>.cleanGeneric); // List
  /// print(Map<String, int>.cleanGeneric); // Map
  /// ```
  /// {@end-tool}
  String get cleanGeneric {
    final className = this.className;
    final index = className.indexOf('<');
    if (index == -1) return className;

    return className.substring(0, index).replaceAll('_', '');
  }
}
