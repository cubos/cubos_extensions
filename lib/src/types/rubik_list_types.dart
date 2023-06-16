import 'package:rubik_utils/rubik_utils.dart';

typedef GroupPredicate<K, E> = K Function(E);
typedef GroupType<K, E> = Map<K, List<E>>;

typedef ConvertTypeHandle<E> = List<E> Function(List);

typedef SumPredicate<E> = num Function();
typedef ElementPredicate<E> = bool Function(E);
typedef OrElse<E> = E Function();

typedef RubikDateTimes = List<DateTime>;
typedef RubikDurations = List<Duration>;

typedef RubikDoubles = List<double>;
typedef RubikIntegers = List<int>;
typedef RubikNumbers = List<num>;

typedef RubikFindElement<E> = Comparable Function(E);

/// A collection of values, or `elements`, that can be accessed sequentially.
/// RubikBaseCast<E> is a base class for converting a list of any type into a
/// list of a specific type.
///
/// Its objective is to solve the `problem of the default cast of Iterable<E>`,
/// which does not convert to the expected type, returning
/// `type "E" is not a subtype of type "R"` in `List.fromCast<E, R>`, `[1, 2, 3, 4].cast<String>()`
/// and etc.
///
/// For example, the following code:
///
/// ```dart
/// final list = [1, 2, 3, 4];
/// final cast = list.cast<String>(); // type "int" is not a subtype of type "String"
/// ```
///
/// The solution is to create a class that extends `RubikBaseCast<E>` and
/// implements the `cast<R>()` method, which will return the expected type.
///
///{@tool snippet}
/// ```dart
/// class RubikCastIntToString extends RubikBaseCast<int, String> {
///   const RubikCastIntToString(List<int> source) : super(source);
///
///   @override
///   List<String> castFrom() {
///     if (!isSameType<String>()) return [];
///
///     return map((it) => it.toString()).toList();
///   }
/// }
///
/// final handle = RubikCastIntToString([1, 2, 3, 4]);
/// handle.castFrom(); // ['1', '2', '3', '4']
/// ```
/// {@end-tool}
class RubikBaseCast<E, R> extends Iterable<E> {
  final Iterable<E> _source;
  const RubikBaseCast(this._source) : super();

  /// Returns `true` if the type of the list is the same as the type of the
  /// parameter, otherwise returns `false`.
  /// {@tool snippet}
  /// ```dart
  /// final cast = RubikBaseCast<int>([1, 2, 3, 4]);
  /// cast.isSameType<int>(); // true
  /// cast.isSameType<String>(); // false
  /// ```
  /// {@end-tool}
  bool isSameType() => R == E;

  /// Converts a list of any type to a list of a specific type.
  /// {@tool snippet}
  /// ```dart
  /// final cast = RubikBaseCast<int, String>([1, 2, 3, 4]);
  /// cast.castFrom(); //  ['1', '2', '3', '4']
  /// ```
  /// {@end-tool}
  List<R> castFrom() => super.cast<R>().toList();

  @override
  Iterator<E> get iterator => _source.iterator;
}

/// This class converts `List<String>` from `00:00:00.000000`
/// format to a `Duration` list.
/// {@tool snippet}
/// ```dart
/// final cast = RubikCastStringToDuration([ '1:02:00', '36:01:15.000000' ]);
/// cast.cast<Duration>(); // [Duration:1:02:00.000000, Duration:36:01:15.000000]
/// ```
/// {@end-tool}
class RubikCastStringToDuration extends RubikBaseCast<String, Duration> {
  const RubikCastStringToDuration(super._source);

  static RubikDurations parse(List source) {
    return RubikCastStringToDuration(source as Strings).castFrom();
  }

  /// Converts a list of strings to a list of durations.
  /// The string must be in the format `HH:MM:SS.mmmmmm`.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikCastStringToDuration([
  ///   '1:02:00',
  ///   '36:01:15.000000',
  /// ]);
  ///
  /// handle.castFrom<Duration>(); // [Duration:1:02:00.000000, Duration:36:01:15.000000]
  /// ```
  /// {@end-tool}
  @override
  List<Duration> castFrom() => map((it) => it.toDuration).toList();
}

class RubikIntegerToDuration extends RubikBaseCast<num, Duration> {
  final RubikTimeUnit unit;

  const RubikIntegerToDuration(
    super._source, [
    this.unit = RubikTimeUnit.milliseconds,
  ]);

  static RubikDurations parse(List source, RubikTimeUnit unit) {
    return RubikIntegerToDuration(source as RubikIntegers, unit).castFrom();
  }

  /// Converts a list of integers to a list of durations.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikIntegerToDuration([864000000, 54541000);
  /// handle.castFrom() // [Duration:1:02:00.000000, Duration:36:01:15.000000]
  /// ```
  /// {@end-tool}
  @override
  List<Duration> castFrom() => map((it) => it.toDuration(unit: unit)).toList();
}

class RubikDateTimeToDuration extends RubikBaseCast<DateTime, Duration> {
  const RubikDateTimeToDuration(super._source);

  static RubikDurations parse(List source) {
    return RubikDateTimeToDuration(source as RubikDateTimes).castFrom();
  }

  /// Converts a list of date times to a list of durations.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikDateTimeToDuration([
  ///   DateTime(2021, 1, 1, 1, 2, 0),
  ///   DateTime(2021, 1, 2, 36, 1, 15),
  /// ]);
  ///
  /// handle.castFrom() // [Duration:1:02:00.000000, Duration:36:01:15.000000]
  /// ```
  /// {@end-tool}
  @override
  List<Duration> castFrom() => map((it) => it.toDuration).toList();
}

class RubikCastStringToDateTime extends RubikBaseCast<String, DateTime> {
  const RubikCastStringToDateTime(super._source);

  static RubikDateTimes parse(List source) {
    return RubikCastStringToDateTime(source as Strings).castFrom();
  }

  /// Converts a list of strings to a list of date times.
  /// The string must be in the format `yyyy-MM-dd HH:mm:ss.mmmmmm`.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikCastStringToDateTime([
  ///   '2021-01-01 01:02:00',
  ///   '2021-01-02 36:01:15.000000',
  /// ]);
  ///
  /// handle.castFrom() // [DateTime:2021-01-01 01:02:00.000000, DateTime:2021-01-02 36:01:15.000000]
  /// ```
  /// {@end-tool}
  @override
  List<DateTime> castFrom() {
    return map((it) => it.toDateTime ?? DateTime(0, 0, 0)).toList();
  }
}

class RubikIntegerToDateTime extends RubikBaseCast<num, DateTime> {
  const RubikIntegerToDateTime(super._source);

  static RubikDateTimes parse(List source) {
    return RubikIntegerToDateTime(source as RubikIntegers).castFrom();
  }

  /// Converts a list of integers to a list of date times.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikIntegerToDateTime([864000000, 54541000);
  /// handle.castFrom() // [DateTime:2021-01-01 01:02:00.000000, DateTime:2021-01-02 36:01:15.000000]
  /// ```
  /// {@end-tool}
  @override
  List<DateTime> castFrom() => map((it) => it.toDateTime).toList();
}

class RubikDurationToDateTime extends RubikBaseCast<Duration, DateTime> {
  const RubikDurationToDateTime(super._source);

  static RubikDateTimes parse(List source) {
    return RubikDurationToDateTime(source as RubikDurations).castFrom();
  }

  /// Converts a list of durations to a list of date times.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikDurationToDateTime([
  ///   Duration(hours: 1, minutes: 2),
  ///   Duration(hours: 36, minutes: 1, seconds: 15),
  /// ]);
  ///
  /// handle.castFrom() // [DateTime:2021-01-01 01:02:00.000000, DateTime:2021-01-02 36:01:15.000000]
  /// ```
  /// {@end-tool}
  @override
  List<DateTime> castFrom() => map((it) => it.toDateTime()).toList();
}

class RubikCastStringToInteger extends RubikBaseCast<String, int> {
  const RubikCastStringToInteger(super._source);

  static RubikIntegers parse(List source) {
    return RubikCastStringToInteger(source as Strings).castFrom();
  }

  /// Converts a list of strings to a list of integers.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikCastStringToInteger([ '1', '2' ]);
  /// handle.castFrom() // [1, 2]
  /// ```
  /// {@end-tool}
  @override
  List<int> castFrom() => map((it) => it.toInt ?? 0).toList();
}

class RubikDoubleToInteger extends RubikBaseCast<double, int> {
  const RubikDoubleToInteger(super._source);

  static RubikIntegers parse(List source) {
    return RubikDoubleToInteger(source as RubikDoubles).castFrom();
  }

  /// Converts a list of doubles to a list of integers.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikDoubleToInteger([ 34.343, 45.332 ]);
  /// handle.castFrom() //  [34, 45]
  /// ```
  /// {@end-tool}
  @override
  List<int> castFrom() => map((it) => it.toInt()).toList();
}

class RubikDurationToInteger extends RubikBaseCast<Duration, int> {
  const RubikDurationToInteger(super._source);

  static RubikIntegers parse(List source) {
    return RubikDurationToInteger(source as RubikDurations).castFrom();
  }

  /// Converts a list of durations to a list of integers.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikDurationToInteger([
  ///   Duration(hours: 1, minutes: 2),
  ///   Duration(hours: 36, minutes: 1, seconds: 15),
  /// ]);
  ///
  /// handle.castFrom() // [3720000, 12975000]
  /// ```
  /// {@end-tool}
  @override
  List<int> castFrom() => map((it) => it.inMilliseconds).toList();
}

class RubikDateTimeToInteger extends RubikBaseCast<DateTime, int> {
  const RubikDateTimeToInteger(super._source);

  static RubikIntegers parse(List source) {
    return RubikDateTimeToInteger(source as RubikDateTimes).castFrom();
  }

  /// Converts a list of date times to a list of integers.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikDateTimeToInteger([
  ///   DateTime(2021, 1, 1, 1, 2, 0),
  ///   DateTime(2021, 1, 2, 36, 1, 15),
  /// ]);
  ///
  /// handle.castFrom() // [864000000, 54541000]
  /// ```
  /// {@end-tool}
  @override
  List<int> castFrom() => map((it) => it.millisecondsSinceEpoch).toList();
}

class RubikCastStringToDouble extends RubikBaseCast<String, double> {
  const RubikCastStringToDouble(super._source);

  static RubikDoubles parse(List source) {
    return RubikCastStringToDouble(source as Strings).castFrom();
  }

  /// Converts a list of strings to a list of doubles.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikCastStringToDouble([ '1.0', '2.0' ]);
  /// handle.castFrom() // [1.0, 2.0]
  /// ```
  /// {@end-tool}
  @override
  List<double> castFrom() => map((it) => it.toDouble ?? 0.0).toList();
}

class RubikIntegerToDouble extends RubikBaseCast<int, double> {
  const RubikIntegerToDouble(super._source);

  static RubikDoubles parse(List source) {
    return RubikIntegerToDouble(source as RubikIntegers).castFrom();
  }

  /// Converts a list of integers to a list of doubles.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikIntegerToDouble([ 1, 2 ]);
  /// handle.castFrom() // [1.0, 2.0]
  /// ```
  /// {@end-tool}
  @override
  List<double> castFrom() => map((it) => it.toDouble()).toList();
}

class RubikDurationToDouble extends RubikBaseCast<Duration, double> {
  const RubikDurationToDouble(super._source);

  static RubikDoubles parse(List source) {
    return RubikDurationToDouble(source as RubikDurations).castFrom();
  }

  /// Converts a list of durations to a list of doubles.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikDurationToDouble([
  ///   Duration(hours: 1, minutes: 2),
  ///   Duration(hours: 36, minutes: 1, seconds: 15),
  /// ]);
  ///
  /// handle.castFrom() // [3720000.0, 12975000.0]
  /// ```
  /// {@end-tool}
  @override
  List<double> castFrom() => map((it) => it.inMilliseconds / 1000000).toList();
}

class RubikDateTimeToDouble extends RubikBaseCast<DateTime, double> {
  const RubikDateTimeToDouble(super._source);

  static RubikDoubles parse(List source) {
    return RubikDateTimeToDouble(source as RubikDateTimes).castFrom();
  }

  /// Converts a list of date times to a list of doubles.
  /// {@tool snippet}
  /// ```dart
  /// final handle = RubikDateTimeToDouble([
  ///   DateTime(2021, 1, 1, 1, 2, 0),
  ///   DateTime(2021, 1, 2, 36, 1, 15),
  /// ]);
  ///
  /// handle.castFrom() // [864000000.0, 54541000.0]
  /// ```
  /// {@end-tool}
  @override
  List<double> castFrom() =>
      map((it) => it.millisecondsSinceEpoch / 1000000).toList();
}
