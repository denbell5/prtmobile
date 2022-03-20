import 'package:prtmobile/features/tracking/tracking.dart';

class _SubtrackDboSchema {
  const _SubtrackDboSchema();

  final String tableName = 'subtracks';

  final String id = 'id';
  final String trackId = 'trackId';
  final String start = 'start';
  final String end = 'end';
  final String pointer = 'pointer';
}

class SubtrackDbo {
  static const _SubtrackDboSchema schema = _SubtrackDboSchema();

  final String id;
  final String trackId;
  final int start;
  final int end;
  final int pointer;

  SubtrackDbo({
    required this.id,
    required this.trackId,
    required this.start,
    required this.end,
    required this.pointer,
  });

  Map<String, dynamic> toRaw() {
    return {
      schema.id: id,
      schema.trackId: trackId,
      schema.start: start,
      schema.end: end,
      schema.pointer: pointer,
    };
  }

  static SubtrackDbo fromRaw(Map<String, dynamic> map) {
    return SubtrackDbo(
      id: map[schema.id],
      trackId: map[schema.trackId],
      start: map[schema.start],
      end: map[schema.end],
      pointer: map[schema.pointer],
    );
  }

  static String buildCreateQuery() {
    return 'CREATE TABLE ${schema.tableName} ('
        '${schema.id} TEXT PRIMARY KEY,'
        '${schema.trackId} TEXT,'
        '${schema.start} INTEGER,'
        '${schema.end} INTEGER,'
        '${schema.pointer} INTEGER'
        ')';
  }

  static SubtrackDbo fromSubtrack(Subtrack track) {
    return SubtrackDbo(
      id: track.id,
      trackId: track.trackId,
      start: track.start,
      end: track.end,
      pointer: track.pointer,
    );
  }

  Subtrack toSubtrack() {
    return Subtrack(
      id: id,
      trackId: trackId,
      start: start,
      end: end,
      pointer: pointer,
    );
  }
}
