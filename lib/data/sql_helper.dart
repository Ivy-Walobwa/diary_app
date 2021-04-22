import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class SQLHelper {
  final String _colId = 'id';
  final String _colName = 'name';
  final String _colDate = 'date';
  final String _colNotes = 'notes';
  final String _colPosition = 'position';
  final String _tableNotes = 'notes';

  static Database _db;
  final int _version = 1;

  static SQLHelper _singleton = SQLHelper._();

  factory SQLHelper() => _singleton;

  SQLHelper._();

  Future<Database> init() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String dbPath = join(dir.path, 'notes.db');
    Database dbNotes =
        await openDatabase(dbPath, version: _version, onCreate: _createDb);
    return dbNotes;
  }

  Future _createDb(Database db, int version) async {
    String query = 'CREATE TABLE $_tableNotes ($_colId INTEGER PRIMARY KEY, ' +
        '$_colName TEXT, $_colDate TEXT, $_colNotes TEXT, $_colPosition INTEGER)';
    await db.execute(query);
  }

  Future<List<Note>> getNotes() async {
    if (_db == null) _db = await init();
    List<Map<String, dynamic>> notesList =
        await _db.query(_tableNotes, orderBy: _colPosition);
    List<Note> notes = [];

    notesList.forEach((element) {
      notes.add(Note.fromJson(element));
    });

    return notes;
  }

  Future<int> newNote(Note note) async {
    note.position = await findPosition();
    int result = await _db.insert(_tableNotes, note.toJson());
    return result;
  }

  Future<int> updateNote(Note note) async {
    int result = await _db.update(_tableNotes, note.toJson(),
        where: '$_colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(Note note) async {
    int result = await _db
        .delete(_tableNotes, where: '$_colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> findPosition() async {
    final String sql = 'select max($_colPosition) from $_tableNotes';
    List<Map> query = await _db.rawQuery(sql);
    int position = query.first.values.first;
    position = position == null ? 0 : ++position;
    return position;
  }

  Future updatePosition(bool increment, int start, int end) async{
    String sql;
    if(increment){
      sql = 'update $_tableNotes set $_colPosition = $_colPosition + 1 '+
          'where $_colPosition >= $start and $_colPosition <=$end';
    }else{
      sql = 'update $_tableNotes set $_colPosition = $_colPosition - 1 '+
          'where $_colPosition >= $start and $_colPosition <=$end';
    }

    await _db.rawUpdate(sql);
  }
}
