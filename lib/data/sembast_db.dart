import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/password.dart';

class SembastDb {
  // databaseFactoryIo allows to open sembast database
  // sembast database is single file
  DatabaseFactory databaseFactory = databaseFactoryIo;

  Database _db;

  final store = intMapStoreFactory.store('password');

  static SembastDb _singletone = SembastDb._internal();

  SembastDb._internal();

  factory SembastDb() {
    return _singletone;
  }

  Future<Database> init() async {
    if (_db == null) {
      _db = await _openDb();
    }
    return _db;
  }

  Future _openDb() async {
    // retrieve apps doc dir to save sembast db
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docsDir.path, 'pass.db');

    // always open sembast db before use
    final db = await databaseFactory.openDatabase(dbPath);
    return db;
  }

  Future<int> addPassword(Password pwd) async {
    int id = await store.add(_db, pwd.toJson());
    return id;
  }

  Future getPasswords() async {
    await init();
    final finder = Finder(sortOrders: [SortOrder('name')]);
    final snapshot = await store.find(_db, finder: finder);
    return snapshot.map((item) {
      final pwd = Password.fromJson(item.value);
      pwd.id = item.key;
      return pwd;
    }).toList();
  }

  Future updatePassword(Password pwd) async {
    final finder = Finder(filter: Filter.byKey(pwd.id));
    await store.update(_db, pwd.toJson(), finder: finder);
  }

  Future deletePassword(Password pwd) async {
    final finder = Finder(filter: Filter.byKey(pwd.id));
    await store.delete(_db, finder: finder);
  }

  Future deleteAll() async {
    await store.delete(_db);
  }
}
