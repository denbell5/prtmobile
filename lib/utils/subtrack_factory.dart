import 'package:prtmobile/models/models.dart';

class SubtrackFactory {
  static Subtrack buildSubtrack(
    int index, {
    int? aPointer,
  }) {
    // 1-6-10, 11-16-20, 21-26-30, ...
    final start = index * 10 + 1;
    final end = (index + 1) * 10;
    final pointer = aPointer ?? end - 4;
    return Subtrack(
      id: 'subtrack-$index',
      start: start,
      end: end,
      pointer: pointer,
    );
  }

  static List<Subtrack> buildSubtracks(int count) {
    final values = <Subtrack>[];
    for (var i = 0; i < count; i++) {
      values.add(buildSubtrack(i));
    }
    return values;
  }
}
