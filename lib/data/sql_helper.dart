import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper{
  final String colId = 'id';
  final String colName = 'name';
  final String colDate = 'date';
  final String colNotes = 'notes';
  final String colPosition = 'position';
  final String tableNotes = 'notes';

  static Database _db;
  final int version = 1;

  Future<Database> init()async{
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, 'notes.db');
    Database dbNotes = await openDatabase(dbPath, version: version,onCreate: _createDb);
    return dbNotes;
  }

  Future _createDb(Database db, int version) async{
    String query = 'CREATE TABLE $tableNotes ($colId INTEGER PRIMARY KEY, '+
        '$colName TEXT, $colDate TEXT, $colNotes TEXT, $colPosition INTEGER)';
    await db.execute(query);
  }
}