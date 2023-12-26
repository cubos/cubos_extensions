import '../types/rubik_types.dart';

/// This extension adds some useful methods to `List` class.
/// {@tool snippet}
/// ```dart
///  final peoples = [
///   Person('Alice', 25), Person('Bob', 30),
///   Person('Charlie', 25), Person('Alice', 30),
/// ];
///
/// final peoplesByAge = peoples.groupListBy((person) => person.age);
/// print(peopleByAge); // {25: [Person('Alice', 25), Person('Charlie', 25)], 30: [Person('Bob', 30), Person('David', 30)]}
///
/// final peoplesByName = peoples.groupListBy((person) => person.name);
/// print(peopleByName); // {Alice: [Person('Alice', 25), Person('Alice', 30)], Bob: [Person('Bob', 30)], Charlie: [Person('Charlie', 25)]}
/// ```
/// {@end-tool}
extension RubikListExtensions<E> on List<E> {
  /// Returns a `new list` with all the `duplicates removed`.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 1, 1, 2, 3, 4, 5, 5, 9, 10];
  /// list.removeDuplicates; // [1, 2, 3, 4, 5, 9, 10]
  /// ```
  /// {@end-tool}
  List<E> get removeDuplicates => toSet().toList();

  /// Returns a `new list` with new elements `added` that match the given predicate.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// list.addWhere(6, (element) => element > 5); // [1, 2, 3, 4, 5, 6]
  /// ```
  /// {@end-tool}
  void addWhere(E element, ElementPredicate<E> predicate, {int? index}) {
    if (!predicate(element)) return;

    index == null ? add(element) : insert(index, element);
  }

  /// The method takes a `keySelector` function that is responsible for mapping each
  /// element in the list to a key `K`. It then iterates over each element in the list,
  /// uses the `keySelector` function to get the corresponding key, and adds the element
  /// to the corresponding list in the map result. If the key does not already exist in
  /// the map, a new empty list is created to hold the element.
  ///
  /// The method returns a `Map<K, List<E>>` where the keys are the values returned by
  /// the `keySelector` function and the values are the lists of elements that have the
  /// corresponding key.
  ///
  /// Example:
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// final result = list.groupListBy<int>((it) => it.isOdd ? 'odd' : 'even');
  ///
  /// print(result); // {odd: [1, 3, 5], even: [2, 4]}
  /// ```
  /// {@end-tool}
  GroupType groupListBy<K>(GroupPredicate keySelector) {
    final GroupType result = {};

    for (final element in this) {
      final key = keySelector(element);
      final hasKey = result.containsKey(key);

      hasKey ? result[key]!.add(element) : result[key] = <E>[element];
    }

    return result;
  }

  /// Returns a `true` if all the elements in the list are unique.
  /// {@tool snippet}
  /// ```dart
  /// [1, 2, 3, 4, 5].isUnique; // true
  /// [1, 2, 3, 4, 5, 5].isUnique; // false
  /// ```
  /// {@end-tool}
  bool get isUnique => toSet().length == length;

  /// Returns a `true` if all the elements in the list are not unique.
  /// {@tool snippet}
  /// ```dart
  /// [1, 2, 3, 4, 5].isNotUnique; // false
  /// [1, 2, 3, 4, 5, 5].isNotUnique; // true
  /// ```
  /// {@end-tool}
  bool get isNotUnique => !isUnique;

  /// Returns a `new list` converted to `Duration`.
  /// If the conversion fails, the method returns an empty list.
  /// Converting to `Duration` and `DateTime` considers the `milliseconds` unit.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1680100974265, 1679582574265, 1677163374265];
  /// list.toDuration(); // [Duration: 20 years, 4 months, 1 day, Duration: 20 years, 3 months, 1 day, Duration: 20 years, 1 month, 1 day]
  /// ```
  /// {@end-tool}
  RubikDurations toDuration({
    RubikTimeUnit unit = RubikTimeUnit.milliseconds,
  }) {
    if (isEmpty) return [];

    final castHandle = {
      RubikDurations: () => this as RubikDurations,
      Strings: () => RubikCastStringToDuration.parse(this),
      RubikDateTimes: () => RubikDateTimeToDuration.parse(this),
      RubikIntegers: () => RubikIntegerToDuration.parse(this, unit),
    };

    return castHandle[runtimeType]?.call() ?? [];
  }

  /// Returns a `new list` converted to `DateTime`.
  /// If the conversion fails, the method returns an empty list.
  /// Converting to `Duration` considers the `milliseconds` unit.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1680100974265, 1679582574265, 1677163374265];
  /// list.toDateTimes; // [DateTime:2023-05-01, DateTime:2023-04-01, DateTime:2023-02-01]
  ///
  /// final list = ['2023-05-01', '2023-04-01', '2023-02-01'];
  /// list.toDateTime; // [DateTime:2023-05-01, DateTime:2023-04-01, DateTime:2023-02-01]
  /// ```
  /// {@end-tool}
  RubikDateTimes get toDateTime {
    if (isEmpty) return [];

    final castHandle = {
      RubikDateTimes: () => this as RubikDateTimes,
      Strings: () => RubikCastStringToDateTime.parse(this),
      RubikIntegers: () => RubikIntegerToDateTime.parse(this),
      RubikDurations: () => RubikDurationToDateTime.parse(this),
    };

    return castHandle[runtimeType]?.call() ?? [];
  }

  /// Returns a `new list` converted to list of `integers`.
  /// If the conversion fails, the method returns an empty list.
  /// Converting to `Duration` and `DateTime` considers the `milliseconds` unit.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1.0, 2.0, 3.0, 4.0, 5.0];
  /// list.toIntegers; // [1, 2, 3, 4, 5]
  /// ```
  /// {@end-tool}
  RubikIntegers get toInts {
    if (isEmpty) return [];

    final castHandle = {
      RubikIntegers: () => this as RubikIntegers,
      Strings: () => RubikCastStringToInteger.parse(this),
      RubikDoubles: () => RubikDoubleToInteger.parse(this),
      RubikDurations: () => RubikDurationToInteger.parse(this),
      RubikDateTimes: () => RubikDateTimeToInteger.parse(this),
    };

    return castHandle[runtimeType]?.call() ?? [];
  }

  /// Returns a `new list` converted to list of `doubles`.
  /// If the conversion fails, the method returns an empty list.
  /// Converting to `Duration` and `DateTime` considers the `milliseconds` unit.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// list.toDoubles; // [1.0, 2.0, 3.0, 4.0, 5.0]
  /// ```
  /// {@end-tool}
  RubikDoubles get toDoubles {
    if (isEmpty) return [];

    final castHandle = {
      RubikDoubles: () => this as RubikDoubles,
      Strings: () => RubikCastStringToDouble.parse(this),
      RubikIntegers: () => RubikIntegerToDouble.parse(this),
      RubikDurations: () => RubikDurationToDouble.parse(this),
      RubikDateTimes: () => RubikDateTimeToDouble.parse(this),
    };

    return castHandle[runtimeType]?.call() ?? [];
  }

  /// Returns a `sum` of all elements in the list.
  /// If empty list or the conversion fails, the method returns `0`.
  /// Converting to `Duration` and `DateTime` considers the `milliseconds` unit.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// list.sum; // 15
  /// ```
  /// {@end-tool}
  num get sum {
    if (isEmpty) return 0;

    final sumHandle = <Type, SumPredicate<E>>{
      Strings: () => toInts.fold(0, (a, b) => a + b),
      RubikIntegers: () => toInts.fold(0, (a, b) => a + b),
      RubikDoubles: () => toDoubles.fold(0, (a, b) => a + b),
      RubikDurations: () =>
          toDuration().fold(0, (a, b) => a + b.inMilliseconds),
      RubikDateTimes: () =>
          toDateTime.fold(0, (a, b) => a + b.millisecondsSinceEpoch),
    };

    return sumHandle[runtimeType]?.call() ?? 0;
  }

  /// Replace all elements in the list that are equal to
  /// `oldValue` with `newValue`.
  /// If `start` and `end` are provided, only elements in the range
  /// from `start` to `end` (excluding `end`) are replaced.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// list.replace(1, 10); // [10, 2, 3, 4, 5]
  /// list.replace(1, 10, start: 1); // [10, 2, 3, 4, 5]
  /// list.replace(1, 10, start: 1, end: 3); // [10, 2, 3, 4, 5]
  /// ```
  /// {@end-tool}
  void replace(E oldValue, E newValue, {int start = 0, int? end}) {
    if (isEmpty) return;

    end = end ?? length;
    start = start < 0 ? 0 : start;
    end = end > length ? length : end;

    for (int i = start; i < end; i++) {
      if (this[i] == oldValue) this[i] = newValue;
    }
  }

  ///  Returns the largest element in the list based on a function `keySelector`.
  /// If the list is empty, the method returns `null`.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// list.findMax((e) => e * 2); // 10
  /// ```
  /// {@end-tool}
  E? findMax(RubikFindElement<E> keySelector) {
    if (isEmpty) return null;

    E max = first;

    for (int i = 1; i < length; i++) {
      final selected = keySelector(max);
      final element = keySelector(this[i]);

      if (element.compareTo(selected) > 0) max = this[i];
    }

    return max;
  }

  /// Returns the smallest element in the list based on a function `keySelector`.
  /// If the list is empty, the method returns `null`.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// list.findMin((e) => e * 2); // 2
  /// ```
  /// {@end-tool}
  E? findMin(RubikFindElement<E> keySelector) {
    if (isEmpty) return null;

    E min = first;

    for (int i = 1; i < length; i++) {
      final selected = keySelector(min);
      final element = keySelector(this[i]);

      if (element.compareTo(selected) < 0) min = this[i];
    }

    return min;
  }

  /// Returns a `map that contains` each element of the list and its
  /// occurrence count. If the list is empty, the method returns an empty map.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5];
  /// list.countOccurrences(); // {1: 2, 2: 2, 3: 2, 4: 2, 5: 2}
  /// ```
  /// {@end-tool}
  Map<E, int> get countOccurrences {
    final result = <E, int>{};
    if (isEmpty) return result;

    for (final element in this) {
      result[element] = (result[element] ?? 0) + 1;
    }

    return result;
  }

  /// Returns a `quantity` of occurrences of the element `value` in the list.
  /// If the list is empty, the method returns `0`.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5];
  /// list.countOccurrences(1); // 2
  /// ```
  /// {@end-tool}
  int occurrencesOf(E value) => countOccurrences[value] ?? 0;

  /// Calcula a média dos elementos da lista.
  /// Returns the `average` of all elements in the list.
  /// If empty list or the conversion fails, the method returns `0`.
  /// Converting to `Duration` and `DateTime` considers the `milliseconds` unit.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// list.average; // 3
  /// ```
  /// {@end-tool}
  double get average => isEmpty ? 0 : sum / length;

  /// Rotates the elements of the list `n` times to the left.
  /// {@tool snippet}
  /// ```dart
  /// final list = [1, 2, 3, 4, 5];
  /// list.rotate(2); // [3, 4, 5, 1, 2]
  /// ```
  /// {@end-tool}
  void rotate(int n) {
    if (isEmpty) return;

    final shift = n % length;
    if (shift == 0) return;

    final removed = sublist(0, shift);
    removeRange(0, shift);
    addAll(removed);
  }

  /// Invokes `action` on each element of this iterable in iteration order.
  /// Passes the index of the element as the first argument to the `action` function.
  /// {@tool snippet}
  /// ```dart
  /// final numbers = <int>[1, 2, 6, 7];
  /// numbers.forElement((i, e) => print('$i $e'));
  /// // 0 1
  /// // 1 2
  /// // 2 6
  /// ```
  /// {@end-tool}
  void forElement(void Function(int index, E element) action) {
    for (int i = 0; i < length; i++) {
      action(i, this[i]);
    }
  }
}
