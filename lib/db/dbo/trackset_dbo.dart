import 'package:prtmobile/core/core.dart';

class _TracksetDboSchema {
  const _TracksetDboSchema();

  final String tableName = 'tracksets';

  final String id = 'id';
  final String userId = 'userId';
  final String name = 'name';
  final String startAt = 'startAt';
  final String endAt = 'endAt';
  final String isDeleted = 'isDeleted';
}

class TracksetDbo {
  static const _TracksetDboSchema schema = _TracksetDboSchema();

  final String id;
  final String userId;
  final String name;
  final String startAt;
  final String endAt;
  final bool isDeleted;
  int get _isDeletedBit => boolToInt(isDeleted);

  TracksetDbo({
    required this.id,
    required this.userId,
    required this.name,
    required this.startAt,
    required this.endAt,
    required this.isDeleted,
  });

  Map<String, dynamic> toRaw() {
    return {
      schema.id: id,
      schema.userId: userId,
      schema.name: name,
      schema.startAt: startAt,
      schema.endAt: endAt,
      schema.isDeleted: _isDeletedBit,
    };
  }

  static TracksetDbo fromRaw(Map<String, dynamic> map) {
    return TracksetDbo(
      id: map[schema.id],
      userId: map[schema.userId],
      name: map[schema.name],
      startAt: map[schema.startAt],
      endAt: map[schema.endAt],
      isDeleted: intToBool(map[schema.isDeleted]),
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
      isDeleted: trackset.isDeleted,
    );
  }

  Trackset toTrackset() {
    return Trackset(
      id: id,
      userId: userId,
      name: name,
      startAt: DateTime.parse(startAt),
      endAt: DateTime.parse(endAt),
      isDeleted: isDeleted,
    );
  }
}
