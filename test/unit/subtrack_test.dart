import 'package:test/test.dart';
import 'package:prtmobile/models/models.dart';

void main() {
  test('one-value-range', () {
    const subtrack = SubtrackRange(
      start: 1,
      end: 1,
      pointer: 1,
    );
    expect(subtrack.length, 1);
  });

  test('two-value-range', () {
    const subtrack = SubtrackRange(
      start: 1,
      end: 2,
      pointer: 1,
    );
    expect(subtrack.length, 2);
  });

  test('ten-value-range', () {
    const subtrack = SubtrackRange(
      start: 1,
      end: 10,
      pointer: 1,
    );
    expect(subtrack.length, 10);
  });

  test('pointer-equals-start-then-0-done', () {
    const subtrack = SubtrackRange(
      start: 3,
      end: 10,
      pointer: 3,
    );
    expect(subtrack.done, 0);
    expect(subtrack.left, 8);
  });

  test('pointer-equals-end-then-0-left', () {
    const subtrack = SubtrackRange(
      start: 3,
      end: 10,
      pointer: 10,
    );
    expect(subtrack.done, 8);
    expect(subtrack.left, 0);
  });

  test('pointer-is-between-start-and-end', () {
    const subtrack = SubtrackRange(
      start: 3,
      end: 10,
      pointer: 6,
    );
    expect(subtrack.done, 3);
    expect(subtrack.left, 5);
  });
}
