import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/utils/utils.dart';

extension SubtrackSoMaps on SubtrackSo {
  Subtrack toSubtrack({
    required String trackId,
  }) {
    return Subtrack(
      id: id(),
      trackId: trackId,
      start: start,
      end: end,
      pointer: start,
    );
  }
}

extension TrackSoMaps on TrackSo {
  Track toTrack({
    required String tracksetId,
  }) {
    final trackId = id();
    final subtracks =
        this.subtracks.map((so) => so.toSubtrack(trackId: trackId)).toList();
    return Track(
      id: trackId,
      tracksetId: tracksetId,
      name: name,
      subtracks: normalizeSubtracks(subtracks),
    );
  }
}

extension TracksetSoMaps on TracksetSo {
  Trackset toTrackset({
    required DateRange dateRange,
  }) {
    final tracksetId = id();
    final tracks =
        this.tracks.map((so) => so.toTrack(tracksetId: tracksetId)).toList();
    return Trackset(
      id: tracksetId,
      name: name,
      startAt: dateRange.start,
      endAt: dateRange.end,
      tracks: normalizeTracks(tracks),
    );
  }
}
