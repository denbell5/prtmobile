// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:prtmobile/components/buttons/buttons.dart';
import 'package:prtmobile/db/tracking_db.dart';
import 'package:sqflite/sqflite.dart';

import '../storybook.dart';

class DbExample extends StatefulWidget {
  const DbExample({
    Key? key,
  }) : super(key: key);

  @override
  _DbExampleState createState() => _DbExampleState();
}

class _DbExampleState extends State<DbExample> {
  late TrackingDb _db;

  @override
  void initState() {
    super.initState();
    _db = TrackingDb(dbName: 'prt_test');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 18,
        height: 2,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 100,
        ),
        child: Column(
          children: [
            TouchableOpacity(
              child: Text('path'),
              onPressed: () async {
                final path = await getDatabasesPath();
                print(path);
              },
            ),
            TouchableOpacity(
              child: Text('open'),
              onPressed: () {
                _db.open();
              },
            ),
            TouchableOpacity(
              child: Text('list dbs'),
              onPressed: () async {
                final dbs = await _db.db.query('sqlite_master');
                print(dbs);
              },
            ),
            TouchableOpacity(
              child: Text('delete db'),
              onPressed: () async {
                var databasesPath = await getDatabasesPath();
                var path = join(databasesPath, '${_db.dbName}.db');
                await _db.db.close();
                await deleteDatabase(path);
                print('deleted');
              },
            ),
            TouchableOpacity(
              child: Text('list files'),
              onPressed: () async {
                var databasesPath = await getDatabasesPath();
                var directory = Directory(databasesPath);
                var files = directory.listSync();
                print(files);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DbStories implements StorybookStory {
  @override
  String title = 'Db';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const DbExample();
        },
      ),
    ];
  }
}
