import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/rubik_utils.dart';

class _TestValidation extends RubikValidatorType {}

void main() {
  group('RubikValidations', () {
    test('should return null if value is optional or ', () {
      final validate = _TestValidation();

      expect(validate.validate(null), null);
      expect(validate.optional().validate(null), null);
      expect(validate.optional().validate('teste'), null);
    });

    test('should return null if is type valid', () {
      final validate = _TestValidation();

      expect(validate.types([String, num]).validate('teste'), isNull);
      expect(validate.types([String, num]).validate([]), isA<String>());
    });

    test('should return null if value required', () {
      final validate = _TestValidation();

      expect(validate.required().validate('teste'), isNull);
      expect(validate.required().validate(null), isA<String>());
    });

    test('should transform value', () {
      var schema = _TestValidation().types([int]);
      expect(schema.validate(1), isNull);

      schema = schema.types([int]).transform<int, String>((e) {
        return (e.pow(2)).toString();
      }).types([String]);

      expect(schema.validate(1), isNull);
    });

    test('should return transformad value', () {
      var schema = _TestValidation().required().types([String]);
      expect(schema.parse(1), isNull);

      schema = schema.transform<String, List<int>>((e) {
        return e.toList(',').map((e) => int.parse(e)).toList();
      });

      expect(schema.parse(1), isNull);

      final parsed = schema.parse<String, List<int>>('1,2,3');
      expect(parsed, isNotNull);
      expect(parsed, isA<List<int>>());
      expect(parsed, [1, 2, 3]);
    });
  });
}
