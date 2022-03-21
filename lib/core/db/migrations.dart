import 'package:sqflite/sqflite.dart';

typedef MigrationFunction = Future<void> Function(Transaction db);

abstract class Migration {
  String get name => runtimeType.toString();
  Future<void> execute(Transaction db);
}
