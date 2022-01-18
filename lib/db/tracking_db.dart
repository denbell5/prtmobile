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
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      MigrationDbo.buildCreateQuery(),
    );
  }

  Future<NormalizedList<Trackset, String>> getTracksets() async {
    final query = 'select * from ${TracksetDbo.schema.tableName}';
    final maps = await db.rawQuery(query);
    final dbos = maps.map((map) => TracksetDbo.fromRaw(map)).toList();
    final tracksets = dbos.map((dbo) => dbo.toTrackset()).toList();
    final normalized = normalizeTracksets(tracksets);
    return normalized;
  }

  /// For testing purposes only
  Future<void> seedTracksets() async {
    final tracksets = getRealWorldTracksets();
    final dbos = tracksets.entities.map((el) => TracksetDbo.fromTrackset(el));
    final maps = dbos.map((e) => e.toRaw());
    for (var map in maps) {
      await db.insert(TracksetDbo.schema.tableName, map);
    }
  }
}