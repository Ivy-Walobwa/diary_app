import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class SQLHelper {
  final String colId = 'id';
  final String colName = 'name';
  final String colDate = 'date';
  final String colNotes = 'notes';
  final String colPosition = 'position';
  final String tableNotes = 'notes';

  static Database _db;
  final int version = 1;

  static SQLHelper _singleton = SQLHelper._();

  factory SQLHelper() => _singleton;

  SQLHelper._();

  Future<Database> init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, 'notes.db');
    Database dbNotes =
        await openDatabase(dbPath, version: version, onCreate: _createDb);
    return dbNotes;
  }

  Future _createDb(Database db, int version) async {
    String query = 'CREATE TABLE $tableNotes ($colId INTEGER PRIMARY KEY, ' +
        '$colName TEXT, $colDate TEXT, $colNotes TEXT, $colPosition INTEGER)';
    await db.execute(query);
  }

  Future<List<Note>> getNotes() async {
    if (_db == null) _db = await init();
    List<Map<String, dynamic>> notesList =
        await _db.query(tableNotes, orderBy: colPosition);
    List<Note> notes = [];

    notesList.forEach((element) {
      notes.add(Note.fromJson(element));
    });

    return notes;
  }

  Future<int> newNote(Note note) async {
    int result = await _db.insert(tableNotes, note.toJson());
    return result;
  }

  Future<int> updateNote(Note note) async {
    int result = await _db.update(tableNotes, note.toJson(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(Note note) async {
    int result =
        await _db.delete(tableNotes, where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }
}
