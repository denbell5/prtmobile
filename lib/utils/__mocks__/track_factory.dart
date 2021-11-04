import 'package:prtmobile/models/models.dart';

import '../utils.dart';

class TrackFactory {
  static Track buildTrack(
    int index, {
    List<Subtrack> subtracks = const [],
  }) {
    final normalizedSubtracks = normalizeSubtracks(subtracks);
    return Track(
      id: '$index',
      name: 'Track $index',
      subtracks: normalizedSubtracks,
    );
  }

  static List<Track> buildTracks(int count) {
    final values = <Track>[];
    for (var i = 0; i < count; i++) {
      values.add(buildTrack(i));
    }
    return values;
  }
}
