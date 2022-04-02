import 'package:prtmobile/features/tracking/tracking.dart';

class SubtrackFactory {
  static Subtrack buildSubtrack(
    int index, {
    int? aPointer,
    required String trackId,
    int k = 100,
  }) {
    // 1-6-10, 11-16-20, 21-26-30, ...
    final start = index * k + 1;
    final end = (index + 1) * k;
    final pointer = (aPointer ?? end - (k * 0.4)).toInt();
    return Subtrack(
      id: 'subtrack-$index',
      trackId: trackId,
      start: start,
      end: end,
      pointer: pointer,
    );
  }

  static List<Subtrack> buildSubtracks(
    int count, {
    required String trackId,
  }) {
    final values = <Subtrack>[];
    for (var i = 0; i < count; i++) {
      values.add(
        buildSubtrack(i, trackId: trackId),
      );
    }
    return values;
  }
}
