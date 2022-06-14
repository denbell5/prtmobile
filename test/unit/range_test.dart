// ignore_for_file: constant_identifier_names

import 'package:prtmobile/core/core.dart';

import 'package:test/test.dart';

void main() {
  group('hasIntersection tests', () {
    test('intersects on the edges', () {
      const _10To20 = Range(10, 20);
      const _20To30 = Range(20, 30);
      expect(hasIntersection(_10To20, _20To30), true);
      expect(hasIntersection(_20To30, _10To20), true);
    });

    test('intersects on the side', () {
      const _10To20 = Range(10, 20);
      const _15To25 = Range(15, 25);
      expect(hasIntersection(_10To20, _15To25), true);
      expect(hasIntersection(_15To25, _10To20), true);
    });

    test('one inside another', () {
      const _10To40 = Range(10, 40);
      const _20To30 = Range(20, 30);
      expect(hasIntersection(_10To40, _20To30), true);
      expect(hasIntersection(_20To30, _10To40), true);
    });

    test('does not intersect', () {
      const _10To20 = Range(10, 20);
      const _30To40 = Range(30, 40);
      expect(hasIntersection(_10To20, _30To40), false);
      expect(hasIntersection(_30To40, _10To20), false);
    });
  });
}
