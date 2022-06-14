import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/tracking/func/__mocks__/mocks.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

import 'package:sqflite/sqflite.dart';

class TrackingDb {
  late final Database _db;
  final String dbName;

  Database get db => _db;

  TrackingDb({
    required this.dbName,
  });

  Future<void> open() async {
    _db = await openDatabase(
      '$dbName.db',
      version: 1,
      onCreate: _onCreate,
      onOpen: (db) => applyMigrations(db, migrations),
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      MigrationDbo.buildCreateQuery(),
    );
  }

  Future<NormalizedList<Trackset, String>> getEnrichedTracksets() async {
    Future<List<TracksetDbo>> queryTracksets() async {
      const schema = TracksetDbo.schema;
      final raw = await db.query(
        schema.tableName,
        where: '${schema.isDeleted} = 0',
      );
      final dbos = raw.map((r) => TracksetDbo.fromRaw(r)).toList();
      return dbos;
    }

    Future<List<TrackDbo>> queryTracks() async {
      final query = 'select * from ${TrackDbo.schema.tableName}';
      final raw = await db.rawQuery(query);
      final dbos = raw.map((r) => TrackDbo.fromRaw(r)).toList();
      return dbos;
    }

    Future<List<SubtrackDbo>> querySubtracks() async {
      final query = 'select * from ${SubtrackDbo.schema.tableName}';
      final raw = await db.rawQuery(query);
      final dbos = raw.map((r) => SubtrackDbo.fromRaw(r)).toList();
      return dbos;
    }

    final tracksetDbos = await queryTracksets();
    final trackDbos = await queryTracks();
    final subtrackDbos = await querySubtracks();

    final subtracks = subtrackDbos.map((dbo) => dbo.toSubtrack()).toList();

    final tracks = trackDbos.map(
      (dbo) {
        final belongedSubtracks =
            subtracks.where((x) => x.trackId == dbo.id).toList();
        final normalizedSubtracks = normalizeSubtracks(belongedSubtracks);
        final track = dbo.toTrack().copyWith(subtracks: normalizedSubtracks);
        return track;
      },
    ).toList();

    final tracksets = tracksetDbos.map((dbo) {
      final belongedTracks =
          tracks.where((x) => x.tracksetId == dbo.id).toList();
      final normalizedTracks = normalizeTracks(belongedTracks);
      return dbo.toTrackset().copyWith(tracks: normalizedTracks);
    }).toList();

    final normalizedTracksets = normalizeTracksets(tracksets);

    return normalizedTracksets;
  }

  /// For testing purposes only
  Future<void> seedTracksets() async {
    final tracksets = getRealWorldTracksets().entities;
    for (var trackset in tracksets) {
      await insertTracksetEnriched(trackset);
    }
  }

  Future<void> insertTrackset(Trackset trackset) async {
    return _insertTrackset(db, trackset);
  }

  Future<void> _insertTrackset(DatabaseExecutor db, Trackset trackset) async {
    final dbo = TracksetDbo.fromTrackset(trackset);
    final raw = dbo.toRaw();
    await db.insert(TracksetDbo.schema.tableName, raw);
  }

  Future<void> insertTracksetEnriched(Trackset trackset) async {
    await db.transaction((db) async {
      await _insertTrackset(db, trackset);

      final tracks = trackset.tracks.entities;
      await _insertTracks(db, tracks);

      final subtracks = tracks.selectMany((x) => x.subtracks.entities);
      await _insertSubtracks(db, subtracks);
    });
  }

  Future<void> updateTrackset(Trackset trackset) async {
    final dbo = TracksetDbo.fromTrackset(trackset);
    final raw = dbo.toRaw();
    const schema = TracksetDbo.schema;
    await db.update(
      TracksetDbo.schema.tableName,
      raw,
      where: '${schema.id} = ?',
      whereArgs: [dbo.id],
    );
  }

  Future<void> deleteTracksets(List<String> ids) async {
    await db.transaction((db) async {
      const schema = TracksetDbo.schema;
      for (var id in ids) {
        var raw = {schema.isDeleted: 1};
        await db.update(
          schema.tableName,
          raw,
          where: '${schema.id} = ?',
          whereArgs: [id],
        );
      }
    });
  }

  Future<void> insertTrack(Track track) async {
    final dbo = TrackDbo.fromTrack(track);
    final raw = dbo.toRaw();
    await db.insert(TrackDbo.schema.tableName, raw);
  }

  Future<void> _insertTracks(
    Transaction db,
    List<Track> tracks,
  ) async {
    final trackDbos = tracks.mapList(TrackDbo.fromTrack);
    final tracksRaw = trackDbos.mapList((dbo) => dbo.toRaw());
    for (var raw in tracksRaw) {
      await db.insert(TrackDbo.schema.tableName, raw);
    }
  }

  Future<void> updateTrack(Track track) async {
    final dbo = TrackDbo.fromTrack(track);
    final raw = dbo.toRaw();
    const schema = TrackDbo.schema;
    await db.update(
      schema.tableName,
      raw,
      where: '${schema.id} = ?',
      whereArgs: [dbo.id],
    );
  }

  Future<void> deleteTracks(List<String> ids) async {
    await db.transaction((db) async {
      const schema = TrackDbo.schema;
      final script = _buildDeleteInQuery(
        tableName: schema.tableName,
        idName: schema.id,
        ids: ids,
      );
      await db.execute(script);
    });
  }

  Future<void> deleteSubtracks(List<String> ids) async {
    await db.transaction((db) async {
      const schema = SubtrackDbo.schema;
      final script = _buildDeleteInQuery(
        tableName: schema.tableName,
        idName: schema.id,
        ids: ids,
      );
      await db.execute(script);
    });
  }

  String _buildDeleteInQuery({
    required String tableName,
    required String idName,
    required List<String> ids,
  }) {
    final idsCsv = ids.join(',');
    return 'DELETE FROM $tableName WHERE $idName IN ($idsCsv);';
  }

  Future<void> insertSubtrack(Subtrack subtrack) async {
    final dbo = SubtrackDbo.fromSubtrack(subtrack);
    final raw = dbo.toRaw();
    await db.insert(SubtrackDbo.schema.tableName, raw);
  }

  Future<void> _insertSubtracks(
    Transaction db,
    List<Subtrack> subtracks,
  ) async {
    final subtrackDbos = subtracks.mapList(SubtrackDbo.fromSubtrack);
    final subtracksRaw = subtrackDbos.mapList((dbo) => dbo.toRaw());
    for (var raw in subtracksRaw) {
      await db.insert(SubtrackDbo.schema.tableName, raw);
    }
  }

  Future<void> updateSubtrack(Subtrack subtrack) async {
    final dbo = SubtrackDbo.fromSubtrack(subtrack);
    final raw = dbo.toRaw();
    const schema = SubtrackDbo.schema;
    await db.update(
      schema.tableName,
      raw,
      where: '${schema.id} = ?',
      whereArgs: [dbo.id],
    );
  }
}
