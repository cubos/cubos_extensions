import 'package:flutter_test/flutter_test.dart';

import 'package:rubik_utils/src/types/rubik_duration_types.dart';

void main() {
  group('RubikTimeUnit', () {
    test('should create a RubikTimeUnit from a string', () {
      expect(RubikTimeUnit.fromString('days'), RubikTimeUnit.days);
      expect(RubikTimeUnit.fromString('hours'), RubikTimeUnit.hours);
      expect(RubikTimeUnit.fromString('minutes'), RubikTimeUnit.minutes);
      expect(RubikTimeUnit.fromString('seconds'), RubikTimeUnit.seconds);

      final microseconds = RubikTimeUnit.fromString('microseconds');
      expect(microseconds, RubikTimeUnit.microseconds);

      final milliseconds = RubikTimeUnit.fromString('milliseconds');
      expect(milliseconds, RubikTimeUnit.milliseconds);
      expect(RubikTimeUnit.fromString(''), RubikTimeUnit.milliseconds);
    });

    test('should return true if the current value is days', () {
      expect(RubikTimeUnit.days.isDays, true);
      expect(RubikTimeUnit.hours.isDays, false);

      expect(RubikTimeUnit.hours.isHours, true);
      expect(RubikTimeUnit.minutes.isMinutes, true);
      expect(RubikTimeUnit.seconds.isSeconds, true);
      expect(RubikTimeUnit.milliseconds.isMilliseconds, true);
      expect(RubikTimeUnit.microseconds.isMicroseconds, true);
    });
  });
}
