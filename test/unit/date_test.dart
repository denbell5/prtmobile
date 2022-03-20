import 'package:prtmobile/core/core.dart';
import 'package:test/test.dart';

void main() {
  group('formatRange tests', () {
    test('jan-apr same year', () {
      final start = DateTime(2021, 1, 13);
      final end = DateTime(2021, 4, 13);
      final formatted = formatDateRange(start, end);
      expect(formatted, '2021 M1 - M4 (Jan - Apr)');
    });

    test('jan-apr different years', () {
      final start = DateTime(2021, 1, 13);
      final end = DateTime(2022, 4, 13);
      final formatted = formatDateRange(start, end);
      expect(formatted, '2021 M1 - 2022 M4 (Jan - Apr)');
    });
  });
}
