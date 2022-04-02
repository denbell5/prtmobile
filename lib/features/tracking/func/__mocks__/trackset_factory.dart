import 'package:prtmobile/features/tracking/func/__mocks__/mocks.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

class TracksetFactory {
  static Trackset buildTrackset(
    int index, {
    List<Track> tracks = const [],
    String? name,
    int? trackCount,
    int? subtrackCount,
  }) {
    var _tracks = tracks;
    if (trackCount != null) {
      _tracks = TrackFactory.buildTracks(
        trackCount,
        tracksetId: '$index',
        subtrackCount: subtrackCount,
      );
    }
    final normalizedTracks = normalizeTracks(_tracks);
    final now = DateTime.now();
    return Trackset(
      id: '$index',
      name: name ?? 'Trackset-$index',
      startAt: now,
      endAt: now.add(const Duration(days: 7)),
      tracks: normalizedTracks,
    );
  }

  static List<Trackset> buildTracksets({
    int count = 0,
    int? trackCount,
    int? subtrackCount,
  }) {
    final values = <Trackset>[];
    for (var i = 0; i < count; i++) {
      values.add(
        buildTrackset(
          i,
          trackCount: trackCount,
          subtrackCount: subtrackCount,
        ),
      );
    }
    return values;
  }
}
