import 'package:prtmobile/models/models.dart';

class _TracksetDboSchema {
  const _TracksetDboSchema();

  final String tableName = 'tracksets';

  final String id = 'id';
  final String userId = 'userId';
  final String name = 'name';
  final String startAt = 'startAt';
  final String endAt = 'endAt';
}

class TracksetDbo {
  static const _TracksetDboSchema schema = _TracksetDboSchema();

  final String id;
  final String userId;
  final String name;
  final String startAt;
  final String endAt;

  TracksetDbo({
    required this.id,
    required this.userId,
    required this.name,
    required this.startAt,
    required this.endAt,
  });

  Map<String, dynamic> toRaw() {
    return {
      schema.id: id,
      schema.userId: userId,
      schema.name: name,
      schema.startAt: startAt,
      schema.endAt: endAt,
    };
  }

  static TracksetDbo fromRaw(Map<String, dynamic> map) {
    return TracksetDbo(
      id: map[schema.id],
      userId: map[schema.userId],
      name: map[schema.name],
      startAt: map[schema.startAt],
      endAt: map[schema.endAt],
    );
  }

  static String buildCreateQuery() {
    return 'CREATE TABLE ${schema.tableName} ('
        '${schema.id} TEXT PRIMARY KEY,'
        '${schema.userId} TEXT,'
        '${schema.name} TEXT,'
        '${schema.startAt} TEXT,'
        '${schema.endAt} TEXT'
        ')';
  }

  static TracksetDbo fromTrackset(Trackset trackset) {
    return TracksetDbo(
      id: trackset.id,
      userId: trackset.userId,
      name: trackset.name,
      startAt: trackset.startAt.toIso8601String(),
      endAt: trackset.endAt.toIso8601String(),
    );
  }

  Trackset toTrackset() {
    return Trackset(
      id: id,
      userId: userId,
      name: name,
      startAt: DateTime.parse(startAt),
      endAt: DateTime.parse(endAt),
    );
  }
}
