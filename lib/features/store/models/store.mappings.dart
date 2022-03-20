import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/core/core.dart';

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

  static SubtrackSo fromRaw(Map<String, dynamic> raw) {
    return SubtrackSo(
      start: raw['start'],
      end: raw['end'],
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

  static TrackSo fromRaw(Map<String, dynamic> raw) {
    final subtracksRaw = raw['subtracks'] as List<dynamic>?;
    final subtracks = subtracksRaw == null
        ? <SubtrackSo>[]
        : subtracksRaw
            .map((x) => SubtrackSoMaps.fromRaw(x as Map<String, dynamic>))
            .toList();
    return TrackSo(
      name: raw['name'],
      subtracks: subtracks,
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

  static TracksetSo fromRaw(Map<String, dynamic> raw) {
    final tracksRaw = raw['tracks'] as List<dynamic>?;
    final tracks = tracksRaw == null
        ? <TrackSo>[]
        : tracksRaw
            .map((x) => TrackSoMaps.fromRaw(x as Map<String, dynamic>))
            .toList();
    return TracksetSo(
      name: raw['name'],
      recommendedDays: raw['recommendedDays'],
      tracks: tracks,
    );
  }
}
