import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/password.dart';

class SembastDb{
  // databaseFactoryIo allows to open sembast database
  // sembast database is single file
  DatabaseFactory databaseFactory = databaseFactoryIo;

  Database _db;

  final store = intMapStoreFactory.store('password');

  static SembastDb _singletone = SembastDb._internal();

  SembastDb._internal();

  factory SembastDb(){
    return _singletone;
  }


  Future<Database> init()async{
    if(_db == null){
      _db = await _openDb();
    }
    return _db;
  }

  Future _openDb()async{
    // retrieve apps doc dir to save sembast db
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docsDir.path, 'pass.db');

    // always open sembast db before use
    final db = await databaseFactory.openDatabase(dbPath);
    return db;
  }

}