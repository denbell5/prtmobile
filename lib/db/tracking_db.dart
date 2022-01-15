import 'package:prtmobile/db/dbo/trackset_dbo.dart';
import 'package:sqflite/sqflite.dart';

class TrackingDb {
  static const int _currentVersion = 1;

  late final Database _db;
  final String dbName;

  Database get db => _db;

  TrackingDb({
    required this.dbName,
  });

  Future<void> open() async {
    _db = await openDatabase(
      '$dbName.db',
      version: _currentVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      TracksetDbo.buildCreateQuery(),
    );
  }
}
