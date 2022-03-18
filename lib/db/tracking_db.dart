import 'package:prtmobile/db/db.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/utils/__mocks__/real_world.dart';
import 'package:prtmobile/utils/utils.dart';
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
      onOpen: applyMigrations,
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
    Future<void> insertTracksets(
      Transaction db,
      List<Trackset> tracksets,
    ) async {
      final tracksetDbos = tracksets.mapList(TracksetDbo.fromTrackset);
      final tracksetsRaw = tracksetDbos.mapList((dbo) => dbo.toRaw());
      for (var raw in tracksetsRaw) {
        await db.insert(TracksetDbo.schema.tableName, raw);
      }
    }

    Future<void> insertTracks(
      Transaction db,
      List<Track> tracks,
    ) async {
      final trackDbos = tracks.mapList(TrackDbo.fromTrack);
      final tracksRaw = trackDbos.mapList((dbo) => dbo.toRaw());
      for (var raw in tracksRaw) {
        await db.insert(TrackDbo.schema.tableName, raw);
      }
    }

    Future<void> insertSubtracks(
      Transaction db,
      List<Subtrack> subtracks,
    ) async {
      final subtrackDbos = subtracks.mapList(SubtrackDbo.fromSubtrack);
      final subtracksRaw = subtrackDbos.mapList((dbo) => dbo.toRaw());
      for (var raw in subtracksRaw) {
        await db.insert(SubtrackDbo.schema.tableName, raw);
      }
    }

    final tracksets = getRealWorldTracksets().entities;
    final tracks = tracksets.selectMany((e) => e.tracks.entities);
    final subtracks = tracks.selectMany((x) => x.subtracks.entities);

    await db.transaction((db) async {
      await insertTracksets(db, tracksets);
      await insertTracks(db, tracks);
      await insertSubtracks(db, subtracks);
    });
  }

  Future<void> insertTrackset(Trackset trackset) async {
    final dbo = TracksetDbo.fromTrackset(trackset);
    final raw = dbo.toRaw();
    await db.insert(TracksetDbo.schema.tableName, raw);
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
