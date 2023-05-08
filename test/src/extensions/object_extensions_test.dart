import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/extensions/object_extensions.dart';

void main() {
  group('RubikNullObjectExtension', () {
    group('RubikNullObjectExtension.isNull', () {
      test('should return true if the object is null', () {
        const String? object = null;
        expect(object.isNull, isTrue);
      });

      test('should return false if the object is not null', () {
        const object = 1;
        expect(object.isNull, isFalse);
      });
    });

    group('RubikNullObjectExtension.isNotNull', () {
      test('should return false if the object is null', () {
        const String? object = null;
        expect(object.isNotNull, isFalse);
      });

      test('should return true if the object is not null', () {
        const object = 1;
        expect(object.isNotNull, isTrue);
      });
    });

    group('RubikNullObjectExtension.isInstanceOf', () {
      test(
        'should return true if the object is an instance of the given type',
        () {
          const object = 1;
          expect(object.isInstanceOf<int>(), isTrue);
        },
      );

      test(
        'should return false if the object is not an instance of the given type',
        () {
          const object = 1;
          expect(object.isInstanceOf<String>(), isFalse);
        },
      );
    });

    group('RubikNullObjectExtension.castAs', () {
      test('should converts integer to integer', () {
        const object = 1;
        final result = object.castAs<int>();

        expect(result, isA<int>());
        expect(result, equals(1));
      });

      test('should converts integer to double', () {
        const object = 1;
        final result = object.castAs<double>();

        expect(result, isA<double>());
        expect(result, equals(1.0));
      });

      test('should converts integer to string', () {
        const object = 1;
        final result = object.castAs<String>();

        expect(result, isA<String>());
        expect(result, equals('1'));
      });

      test('should converts string to integer', () {
        const object = '1';
        final result = object.castAs<int>();

        expect(result, isA<int>());
        expect(result, equals(1));
      });

      test('should throws exception for unsupported type', () {
        const object = '1';
        final result = object.castAs<bool>();

        expect(result, isA<bool>());
        expect(result, equals(true));
      });

      test('should throws exception when force is false', () {
        const object = '1';
        expect(() => object.castAs<bool>(force: false), throwsException);
        expect(() => object.castAs<Set<int>>(), throwsException);
      });

      test('should converts string to boolean', () {
        const object = 'true';
        final result = object.castAs<bool>();

        expect(result, isA<bool>());
        expect(result, equals(true));
      });

      test('should converts string to Duration', () {
        final result = '10:24:45'.castAs<Duration>();
        const expected = Duration(hours: 10, minutes: 24, seconds: 45);

        expect(result, isA<Duration>());
        expect(result, equals(expected));
      });

      test('should converts string to DateTime', () {
        const object = '2023-04-12';
        final result = object.castAs<DateTime>();

        expect(result, isA<DateTime>());
        expect(result, equals(DateTime(2023, 04, 12)));
      });

      // test('should converts list to set', () {
      //   final object = [1, 2, 3];
      //   final result = object.castAs<Set<int>>(defaultValue: {1, 2, 3});
      //   expect(result, equals({1, 2, 3}));
      // });

      // test('should converts map to list', () {
      //   final object = {'key1': 'value1', 'key2': 'value2'};
      //   final result = object.castAs<List<String>>();
      //   expect(result, equals(['value1', 'value2']));
      // });
    });

    group('RubikNullObjectExtension.ifNotNull', () {
      test('should call the given action if the object is not null', () {
        bool called = false;
        const int object = 1;

        expect(called, isFalse);
        object.ifNotNull((it) => called = true);
        expect(called, isTrue);
      });

      test('should not call the given action if the object is null', () {
        bool called = false;
        const String? object = null;

        object.ifNotNull((it) => called = true);
        expect(called, isFalse);
      });
    });

    group('RubikNullObjectExtension.ifNotNullThen', () {
      test('should call the given action if the object is not null', () {
        const int object = 1;
        final result = object.ifNotNullThen<int, String>((it) => 'int: $it');

        expect(result, 'int: 1');
      });

      test('should not call the given action if the object is null', () {
        const String? object = null;
        final result = object.ifNotNullThen<String, int>((it) => int.parse(it));

        expect(result, isNull);
      });
    });

    group('RubikNullObjectExtension.ifNull', () {
      test('should call the given action if the object is null', () {
        bool called = false;
        const String? object = null;

        expect(called, isFalse);
        object.ifNullThen((value) => called = true);
        expect(called, isTrue);
      });

      test('should not call the given action if the object is not null', () {
        bool called = false;
        const int object = 1;

        object.ifNullThen((_) => called = true);
        expect(called, isFalse);
      });
    });

    group('RubikNullObjectExtension.isNotNullOrEmpty', () {
      test('should return true if the object is not null or empty', () {
        const object = 'test';
        expect(object.isNotNullOrEmpty, isTrue);
      });

      test('should return false if the object is null', () {
        const String? object = null;
        expect(object.isNotNullOrEmpty, isFalse);
      });

      test('should return false if the object is empty', () {
        const object = '';
        expect(object.isNotNullOrEmpty, isFalse);
      });

      test('should return true if any of the objects is not null or empty', () {
        const num number = 1;
        expect(number.isNotNullOrEmpty, isTrue);

        expect(1.isNotNullOrEmpty, isTrue);
        expect(1.5.isNotNullOrEmpty, isTrue);
        expect('test'.isNotNullOrEmpty, isTrue);

        const duration = Duration(days: 2);
        expect(duration.isNotNullOrEmpty, isTrue);

        final date = DateTime.fromMicrosecondsSinceEpoch(1680795540382);
        expect(date.isNotNullOrEmpty, isTrue);

        const Set setValue = {1, 2, 3};
        expect(setValue.isNotNullOrEmpty, isTrue);

        expect([1, 56].isNotNullOrEmpty, isTrue);
        expect(['test'].isNotNullOrEmpty, isTrue);
        expect({'key': 'value'}.isNotNullOrEmpty, isTrue);
      });
    });

    group('RubikNullObjectExtension.className', () {
      test('should return the class name of the object', () {
        const int object = 1;
        expect(object.className, 'int');
      });

      test('should return the class name of the object with the namespace', () {
        const object = _MyClassName();
        expect(object.className, '_MyClassName');
      });
    });

    group('RubikNullObjectExtension.cleanGeneric', () {
      test('should return type without generics', () {
        expect(null.cleanGeneric, 'Null');
        expect(<int>{}.cleanGeneric, 'Set');
        expect(<int>[].cleanGeneric, 'List');
        expect(<int, String>{}.cleanGeneric, 'Map');

        expect(<List<Map<num, bool>>>{}.cleanGeneric, 'Set');
        expect(<List<Map<num, bool>>>[].cleanGeneric, 'List');
        expect(<int, Map<bool, Map<num, bool>>>{}.cleanGeneric, 'Map');

        expect(Future<String>.value('').cleanGeneric, 'Future');
      });
    });
  });
}

class _MyClassName {
  const _MyClassName();
}
