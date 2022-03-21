import 'package:prtmobile/features/tracking/tracking.dart';

class _TrackDboSchema {
  const _TrackDboSchema();

  final String tableName = 'tracks';

  final String id = 'id';
  final String tracksetId = 'tracksetId';
  final String name = 'name';
}

class TrackDbo {
  static const _TrackDboSchema schema = _TrackDboSchema();

  final String id;
  final String tracksetId;
  final String name;

  TrackDbo({
    required this.id,
    required this.tracksetId,
    required this.name,
  });

  Map<String, dynamic> toRaw() {
    return {
      schema.id: id,
      schema.tracksetId: tracksetId,
      schema.name: name,
    };
  }

  static TrackDbo fromRaw(Map<String, dynamic> map) {
    return TrackDbo(
      id: map[schema.id],
      tracksetId: map[schema.tracksetId],
      name: map[schema.name],
    );
  }

  static String buildCreateQuery() {
    return 'CREATE TABLE ${schema.tableName} ('
        '${schema.id} TEXT PRIMARY KEY,'
        '${schema.tracksetId} TEXT,'
        '${schema.name} TEXT'
        ')';
  }

  static TrackDbo fromTrack(Track track) {
    return TrackDbo(
      id: track.id,
      tracksetId: track.tracksetId,
      name: track.name,
    );
  }

  Track toTrack() {
    return Track(
      id: id,
      tracksetId: tracksetId,
      name: name,
    );
  }
}
