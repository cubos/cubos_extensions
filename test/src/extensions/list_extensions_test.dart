// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/extensions/list_extensions.dart';

class _Person {
  final int age;
  final String name;

  const _Person(this.age, this.name);

  @override
  String toString() => '_Person(age: $age, name: $name)';
}

List<_Person> generatePersons([int length = 3]) {
  return List.generate(length, (i) => _Person(i * 10, 'Person $i'));
}

void main() {
  group('RubikListExtensions', () {
    group('RubikListExtensions.removeDuplicates', () {
      test('should return a new list with all the duplicates removed', () {
        final numbers = [1, 1, 1, 2, 3, 4, 5, 5, 9, 10];
        expect(numbers.removeDuplicates, [1, 2, 3, 4, 5, 9, 10]);

        final strings = ['a', 'a', 'A', 'b', 'c', 'c', 'd', 'e', 'e'];
        expect(strings.removeDuplicates, ['a', 'A', 'b', 'c', 'd', 'e']);
      });
    });

    group('RubikListExtensions.addWhere', () {
      test(
        'should return a new list with new elements added that match the given predicate',
        () {
          final numbers = [1, 2, 3, 4, 5];
          numbers.addWhere(6, (element) => element > 5);
          expect(numbers, [1, 2, 3, 4, 5, 6]);

          final strings = ['a', 'c', 'd', 'e', 'f'];
          strings.addWhere('b', (element) => element == 'b');
          expect(strings, ['a', 'c', 'd', 'e', 'f', 'b']);

          strings.addWhere('Ω', (element) => element == 'alfa');
          expect(strings, ['a', 'c', 'd', 'e', 'f', 'b']);
        },
      );

      test(
        'should return a new list with new elements added at the given index',
        () {
          final numbers = [1, 2, 3, 4, 5];
          numbers.addWhere(6, (element) => element > 5, index: 0);
          expect(numbers, [6, 1, 2, 3, 4, 5]);

          final strings = ['a', 'c', 'd', 'e', 'f'];
          strings.addWhere('b', (element) => element == 'b', index: 1);
          expect(strings, ['a', 'b', 'c', 'd', 'e', 'f']);

          strings.addWhere('Ω', (element) => element == 'alfa', index: 2);
          expect(strings, ['a', 'b', 'c', 'd', 'e', 'f']);
        },
      );
    });

    group('RubikListExtensions.groupListBy', () {
      test(
        'should return a map with the elements grouped by the given key',
        () {
          final result = [1, 2, 3, 4, 5].groupListBy<int>(
            (it) => it.isOdd ? 'odd' : 'even',
          );

          final expected = {
            'odd': [1, 3, 5],
            'even': [2, 4],
          };

          expect(result, expected);
        },
      );

      const persons = [
        _Person(20, 'Maria'),
        _Person(5, 'João'),
        _Person(25, 'Pedro'),
        _Person(15, 'Maria'),
        _Person(40, 'Ana'),
        _Person(13, 'Paulo'),
        _Person(22, 'Lucas'),
        _Person(35, 'Mariana'),
        _Person(29, 'Ana'),
        _Person(17, 'Felipe'),
      ];

      test('should group people of legal age', () {
        final result = persons.groupListBy<String>(
          (it) => it.age >= 18 ? 'legal' : 'illegal',
        );

        final expected = {
          'legal': const [
            _Person(20, 'Maria'),
            _Person(25, 'Pedro'),
            _Person(40, 'Ana'),
            _Person(22, 'Lucas'),
            _Person(35, 'Mariana'),
            _Person(29, 'Ana'),
          ],
          'illegal': const [
            _Person(5, 'João'),
            _Person(15, 'Maria'),
            _Person(13, 'Paulo'),
            _Person(17, 'Felipe'),
          ],
        };

        expect(result, expected);
        expect(result['legal']!.length, equals(6));
        expect(result['illegal']!.length, equals(4));
      });

      test('should group names that start with [ma] or [Ma]', () {
        final result = persons.groupListBy<String>((it) {
          final includes = it.name.contains('ma') || it.name.contains('Ma');

          return includes ? 'ma' : 'other';
        });

        final expected = {
          'ma': const [
            _Person(20, 'Maria'),
            _Person(15, 'Maria'),
            _Person(35, 'Mariana'),
          ],
          'other': const [
            _Person(5, 'João'),
            _Person(25, 'Pedro'),
            _Person(40, 'Ana'),
            _Person(13, 'Paulo'),
            _Person(22, 'Lucas'),
            _Person(29, 'Ana'),
            _Person(17, 'Felipe'),
          ],
        };

        expect(result, expected);
        expect(result['ma']!.length, equals(3));
        expect(result['other']!.length, equals(7));
      });
    });

    group('RubikListExtensions.isUnique', () {
      test('should return true if the list has unique elements', () {
        expect([1, 2, 3, 4, 5].isUnique, isTrue);
        expect(['a', 'b', 'c', 'd', 'e'].isUnique, isTrue);
      });

      test('should return false if the list has duplicated elements', () {
        expect([1, 2, 3, 4, 5, 1].isUnique, isFalse);
        expect(['a', 'b', 'c', 'd', 'e', 'a'].isUnique, isFalse);
      });
    });

    group('RubikListExtensions.isNotUnique', () {
      test('should return false if the list has unique elements', () {
        expect([1, 2, 3, 4, 5].isNotUnique, isFalse);
        expect(['a', 'b', 'c', 'd', 'e'].isNotUnique, isFalse);
      });

      test('should return true if the list has duplicated elements', () {
        expect([1, 2, 3, 4, 5, 1].isNotUnique, isTrue);
        expect(['a', 'b', 'c', 'd', 'e', 'a'].isNotUnique, isTrue);
      });
    });

    group('RubikListExtensions.toDuration', () {
      test(
        'should return empty list if the type is invalid',
        () {
          const persons = [_Person(12, 'Ana'), _Person(14, 'João')];
          final durations = persons.toDuration();

          expect(durations, isEmpty);
          expect([].toDuration(), isEmpty);
        },
      );

      test('should return this if the type is Duration', () {
        final durations = [const Duration(hours: 1), const Duration(hours: 2)];
        final result = durations.toDuration();

        expect(result, durations);
      });

      test('should convert list of strings to a list of durations', () {
        final strings = ['1:00:00', '2:00:00', '3:00:00', '4:00:00', '5:00:00'];
        final durations = strings.toDuration();

        expect(durations.length, strings.length);
        expect(durations, [
          const Duration(hours: 1),
          const Duration(hours: 2),
          const Duration(hours: 3),
          const Duration(hours: 4),
          const Duration(hours: 5),
        ]);
      });

      test('should convert list of numbers to a list of durations', () {
        final numbers = [864000000, 1728000000, 2592000000];
        final durations = numbers.toDuration();

        expect(durations.length, numbers.length);
        expect(durations, [
          const Duration(days: 10),
          const Duration(days: 20),
          const Duration(days: 30),
        ]);
      });

      test('should convert list of datetimes to a list of durations', () {
        final dateTimes = [
          DateTime(2020, 1, 1),
          DateTime(2020, 1, 2),
          DateTime(2020, 1, 3),
          DateTime(2020, 1, 4),
          DateTime(2020, 1, 5),
        ];
        final durations = dateTimes.toDuration();

        expect(durations.length, dateTimes.length);
        expect(durations, [
          const Duration(days: 1),
          const Duration(days: 2),
          const Duration(days: 3),
          const Duration(days: 4),
          const Duration(days: 5),
        ]);
      });
    });

    group('RubikListExtensions.toDateTime', () {
      test('should return empty list if the type is invalid', () {
        const persons = [_Person(12, 'Ana'), _Person(14, 'João')];

        expect(persons.toDateTime, isEmpty);
        expect([].toDateTime, isEmpty);
      });

      test('should return this if the type is DateTime', () {
        final dateTimes = [
          DateTime(2020, 1, 1),
          DateTime(2020, 1, 2),
          DateTime(2020, 1, 3),
          DateTime(2020, 1, 4),
          DateTime(2020, 1, 5),
        ];
        final result = dateTimes.toDateTime;

        expect(result, dateTimes);
      });

      test('should convert list of strings to a list of datetime', () {
        final strings = ['2023-05-01', '2023-04-01', '2023-02-01'];
        final dates = strings.toDateTime;

        expect(dates.length, strings.length);
        expect(dates, [
          DateTime(2023, 5, 1),
          DateTime(2023, 4, 1),
          DateTime(2023, 2, 1),
        ]);
      });

      test('should convert list of numbers to a list of durations', () {
        final numbers = [1680100974265, 1679582574265];
        final dates = numbers.toDateTime;

        expect(dates.length, numbers.length);
        expect(dates, [
          DateTime(2023, 3, 29, 11, 42, 54, 265),
          DateTime(2023, 3, 23, 11, 42, 54, 265),
        ]);
      });

      test('should convert list of durations to a list of durations', () {
        const durations = [
          Duration(days: 1, minutes: 45, seconds: 20),
          Duration(days: 2, minutes: 45, seconds: 20),
          Duration(days: 3, minutes: 45, seconds: 20),
          Duration(days: 4, minutes: 45, seconds: 20),
        ];

        final dates = durations.toDateTime;
        final now = DateTime.now();

        expect(dates.length, durations.length);
        expect(dates, [
          DateTime(now.year, now.month, now.day + 1, 0, 45, 20),
          DateTime(now.year, now.month, now.day + 2, 0, 45, 20),
          DateTime(now.year, now.month, now.day + 3, 0, 45, 20),
          DateTime(now.year, now.month, now.day + 4, 0, 45, 20),
        ]);
      });
    });

    group('RubikListExtensions.toInts', () {
      test('should return empty list if the type is invalid', () {
        const persons = [_Person(12, 'Ana'), _Person(14, 'João')];

        expect(persons.toDoubles, isEmpty);
        expect([].toDoubles, isEmpty);
      });

      test('should return this if the type is double', () {
        final numbers = [1.0, 2.0, 3.0, 4.0, 5.0];
        final result = numbers.toDoubles;

        expect(result.length, numbers.length);
        expect(result, [1.0, 2.0, 3.0, 4.0, 5.0]);
      });

      test('should convert list of strings to a list of double', () {
        final strings = ['1', '2', '3', '4', '5'];
        final numbers = strings.toDoubles;

        expect(numbers.length, strings.length);
        expect(numbers, [1.0, 2.0, 3.0, 4.0, 5.0]);
      });

      test('should convert list of int to a list of doubles', () {
        final ints = [1324, 223, 33, 40, 587];
        final numbers = ints.toDoubles;

        expect(numbers.length, ints.length);
        expect(numbers, [1324.0, 223.0, 33.0, 40.0, 587.0]);
      });

      test('should convert list of durations to a list of doubles', () {
        final durations = [
          const Duration(days: 1),
          const Duration(days: 2),
          const Duration(days: 3),
          const Duration(days: 4),
          const Duration(days: 5),
        ];
        final numbers = durations.toDoubles;

        expect(numbers.length, durations.length);
        expect(numbers, [86.4, 172.8, 259.2, 345.6, 432.0]);
      });

      test('should convert list of datetime to a list of double', () {
        final dateTimes = [
          DateTime(2023, 04, 04),
          DateTime(2023, 04, 05),
          DateTime(2023, 04, 23),
          DateTime(2023, 04, 17),
        ];
        final numbers = dateTimes.toDoubles;

        expect(numbers.length, dateTimes.length);
        expect(numbers, [1680577.2, 1680663.6, 1682218.8, 1681700.4]);
      });
    });

    group('RubikListExtensions.toInt', () {
      test('should return empty list if the type is invalid', () {
        const persons = [_Person(12, 'Ana'), _Person(14, 'João')];

        expect(persons.toInts, isEmpty);
        expect([].toInts, isEmpty);
      });

      test('should return this if the type is int', () {
        final numbers = [1, 2, 3, 4, 5];
        final result = numbers.toInts;

        expect(result, numbers);
      });

      test('should convert list of strings to a list of ints', () {
        final strings = ['1', '2', '3', '4', '5'];
        final numbers = strings.toInts;

        expect(numbers.length, strings.length);
        expect(numbers, [1, 2, 3, 4, 5]);
      });

      test('should convert list of doubles to a list of ints', () {
        final doubles = [1.0, 2.0, 3.0, 4.0, 5.0];
        final numbers = doubles.toInts;

        expect(numbers.length, doubles.length);
        expect(numbers, [1, 2, 3, 4, 5]);
      });

      test('should convert list of durations to a list of ints', () {
        final durations = [
          const Duration(days: 1),
          const Duration(days: 2),
          const Duration(days: 3),
          const Duration(days: 4),
          const Duration(days: 5),
        ];
        final numbers = durations.toInts;

        expect(numbers.length, durations.length);
        expect(numbers, [86400000, 172800000, 259200000, 345600000, 432000000]);
      });

      test('should convert list of datetime to a list of ints', () {
        final dateTimes = [
          DateTime(2023, 04, 04),
          DateTime(2023, 04, 05),
          DateTime(2023, 04, 23),
          DateTime(2023, 04, 17),
        ];
        final numbers = dateTimes.toInts;

        expect(numbers.length, dateTimes.length);
        expect(numbers, [
          1680577200000,
          1680663600000,
          1682218800000,
          1681700400000,
        ]);
      });
    });

    group('RubikListExtensions.sum', () {
      test('should return zero if empty list or invalid', () {
        expect([].sum, 0);
        expect(const [_Person(12, 'Ana'), _Person(14, 'João')].sum, 0);
      });

      test('should return the sum of the list of int', () {
        final numbers = [1, 2, 3, 4, 5];
        final result = numbers.sum;

        expect(result, 15);
      });

      test('should return the sum of the list of double', () {
        final numbers = [1.0, 2.0, 3.0, 4.0, 5.0];
        final result = numbers.sum;

        expect(result, 15.0);
      });

      test('should return the sum of the list of strings', () {
        final strings = ['1', '2', '3', '4', '5'];
        final result = strings.sum;

        expect(result, 15);
      });

      test('should return the sum of the list of durations', () {
        final durations = [
          const Duration(days: 1),
          const Duration(days: 2),
          const Duration(days: 3),
          const Duration(days: 4),
          const Duration(days: 5),
        ];

        expect(durations.sum, 1296000000);
        expect(
          (durations.first +
                  durations[1] +
                  durations[2] +
                  durations[3] +
                  durations.last)
              .inMilliseconds,
          1296000000,
        );
      });

      test('should return the sum of the list of datetime', () {
        final dateTimes = [
          DateTime(2023, 04, 04),
          DateTime(2023, 04, 05),
          DateTime(2023, 04, 23),
          DateTime(2023, 04, 17),
        ];

        expect(dateTimes.sum, 6725160000000);
      });
    });

    group('RubikListExtensions.replace', () {
      test('should return empty list if the type is invalid', () {
        final persons = [const _Person(12, 'Ana'), const _Person(14, 'João')];
        persons.replace(persons.first, const _Person(15, 'Igor'));

        expect(persons, [const _Person(15, 'Igor'), const _Person(14, 'João')]);
        expect([]..replace(0, 1), isEmpty);
      });

      test('should replace the value of the list of int', () {
        final numbers = [1, 2, 3, 4, 5];
        numbers.replace(0, 10);

        expect(numbers.length, 5);

        numbers.replace(3, 10);
        expect(numbers, [1, 2, 10, 4, 5]);
      });

      test('should replace the value of the list of strings', () {
        final strings = ['1', '2', '3', '4', '5'];
        strings.replace('4', '10');

        expect(strings.length, 5);
        expect(strings, ['1', '2', '3', '10', '5']);
      });

      test('should replace the value of the list of doubles', () {
        final doubles = [1.0, 2.0, 3.0, 4.0, 5.0];
        doubles.replace(3.0, 10.0);

        expect(doubles.length, 5);
        expect(doubles, [1.0, 2.0, 10.0, 4.0, 5.0]);
      });
    });

    group('RubikListExtensions.findMax', () {
      test('should return null if the type is invalid', () {
        final persons = [const _Person(12, 'Ana'), const _Person(14, 'João')];

        expect([].findMax((e) => e), isNull);
        expect(persons.findMax((e) => e.age), persons.last);
      });

      test('should return the max value of the list of int', () {
        final numbers = [1, 2, 3, 4, 5];
        final result = numbers.findMax((e) => e);

        expect(result, 5);
      });
    });

    group('RubikListExtensions.findMin', () {
      test('should return null if the type is invalid', () {
        final persons = [const _Person(12, 'Ana'), const _Person(14, 'João')];

        expect([].findMin((e) => e), isNull);
        expect(persons.findMin((e) => e.age), persons.first);
      });

      test('should return the min value of the list of int', () {
        final numbers = [1, 2, 3, 4, 5];
        final result = numbers.findMin((e) => e);

        expect(result, 1);
      });
    });
    group('RubikListExtensions.countOccurrences', () {
      test('should return empty map if not contains any occurrences', () {
        expect([].countOccurrences, isEmpty);
        expect([1, 2].countOccurrences, {1: 1, 2: 1});
      });

      test('should return count of occurrences of the value', () {
        final numbers = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5];
        expect(numbers.countOccurrences, {1: 2, 2: 2, 3: 2, 4: 2, 5: 2});
      });
    });

    group('RubikListExtensions.occurrencesOf', () {
      test('should return zero if not contains any occurrences', () {
        expect([].occurrencesOf(1), 0);
        expect([1, 2].occurrencesOf(1), 1);
      });

      test('should return count of occurrences of the value', () {
        final numbers = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5];
        expect(numbers.occurrencesOf(1), 2);
        expect(numbers.occurrencesOf(2), 2);
        expect(numbers.occurrencesOf(3), 2);
        expect(numbers.occurrencesOf(4), 2);
        expect(numbers.occurrencesOf(5), 2);
      });
    });

    group('RubikListExtensions.averageList', () {
      test('should return zero if list isEmptyor invalid type', () {
        final persons = [const _Person(12, 'Ana'), const _Person(14, 'João')];

        expect([].average, 0);
        expect(persons.average, 0);
      });

      test('should return average of the list of int', () {
        final numbers = [1, 2, 3, 4, 5];
        expect(numbers.average, 3);
      });
    });

    group('RubikListExtensions.rotate', () {
      test('should rotates a non-empty list to the right', () {
        final list = [1, 2, 3, 4, 5];
        list.rotate(2);
        expect(list, equals([3, 4, 5, 1, 2]));
      });

      test('should handles negative rotation values', () {
        final list = [1, 2, 3, 4, 5];
        list.rotate(-1);
        expect(list, equals([5, 1, 2, 3, 4]));
      });

      test('should handles rotation values larger than list length', () {
        final list = [1, 2, 3, 4, 5];
        list.rotate(7);
        expect(list, equals([3, 4, 5, 1, 2]));
      });

      test('should does not modify an empty list', () {
        final list = <int>[];
        list.rotate(3);
        expect(list, equals(<int>[]));
      });

      test('should does not modify a list when shift is zero', () {
        final list = [1, 2, 3];
        list.rotate(0);
        expect(list, equals([1, 2, 3]));
      });
    });
    group('RubikListExtensions.forElement', () {
      test('should return empty list if the list is empty', () {
        final numbers = <int>[];
        expect(numbers, isEmpty);

        [1, 2, 3, 4, 5].forElement((i, e) => numbers.add(i + e));

        expect(numbers.length, 5);
        expect(numbers, [1, 3, 5, 7, 9]);
      });
    });
  });
}
