import 'package:prtmobile/models/models.dart';

import '../utils.dart';

class TrackFactory {
  static Track buildTrack(
    int index, {
    required String tracksetId,
    List<Subtrack> subtracks = const [],
  }) {
    final normalizedSubtracks = normalizeSubtracks(subtracks);
    return Track(
      id: '$index',
      tracksetId: tracksetId,
      name: 'Track $index',
      subtracks: normalizedSubtracks,
    );
  }

  static List<Track> buildTracks(
    int count, {
    required String tracksetId,
  }) {
    final values = <Track>[];
    for (var i = 0; i < count; i++) {
      values.add(
        buildTrack(i, tracksetId: tracksetId),
      );
    }
    return values;
  }
}
