import 'package:prtmobile/features/tracking/models/models.dart';
import 'package:test/test.dart';

void main() {
  Trackset exampleTrackset({
    required DateTime endAt,
    required DateTime startAt,
  }) {
    return Trackset(
      id: '',
      name: '',
      startAt: startAt,
      endAt: endAt,
    );
  }

  test('started-today-ends-today', () {
    final today = DateTime(2021, 1, 1);
    final trackset = exampleTrackset(
      startAt: today,
      endAt: today,
    );
    expect(trackset.hasStarted(today), true);
    expect(trackset.hasEnded(today), false);
    expect(trackset.totalDays, 1);
    expect(trackset.daysPassed(today), 0);
    expect(trackset.daysLeft(today), 1);
  });

  test('started-today-ends-tomorrow', () {
    final today1 = DateTime(2021, 1, 1);
    final today2 = DateTime(2021, 1, 2);
    final trackset = exampleTrackset(
      startAt: DateTime(2021, 1, 1),
      endAt: DateTime(2021, 1, 2),
    );
    expect(trackset.totalDays, 2);
    expect(trackset.daysPassed(today1), 0);
    expect(trackset.daysLeft(today1), 2);
    expect(trackset.daysPassed(today2), 1);
    expect(trackset.daysLeft(today2), 1);
  });

  test('started-today-ends-in-a-week', () {
    final today = DateTime(2021, 1, 3);
    final trackset = exampleTrackset(
      startAt: DateTime(2021, 1, 1),
      endAt: DateTime(2021, 1, 7),
    );
    expect(trackset.totalDays, 7);
    expect(trackset.daysPassed(today), 2);
    expect(trackset.daysLeft(today), 5);
  });

  test('starts-in-future', () {
    final today = DateTime(2021, 1, 1);
    final trackset = exampleTrackset(
      startAt: DateTime(2021, 1, 2),
      endAt: DateTime(2021, 1, 8),
    );
    expect(trackset.hasStarted(today), false);
    expect(trackset.hasEnded(today), false);
    expect(trackset.daysPassed(today), 0);
    expect(trackset.daysLeft(today), 7);
  });

  test('ended-in-the-past', () {
    final today = DateTime(2021, 1, 10);
    final trackset = exampleTrackset(
      startAt: DateTime(2021, 1, 1),
      endAt: DateTime(2021, 1, 7),
    );
    expect(trackset.hasStarted(today), true);
    expect(trackset.hasEnded(today), true);
    expect(trackset.daysPassed(today), 7);
    expect(trackset.daysLeft(today), 0);
  });
}
