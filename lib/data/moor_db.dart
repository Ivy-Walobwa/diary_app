import 'package:moor_flutter/moor_flutter.dart';

part 'moor_db.g.dart';

class BlogPost extends Table{
  // also written as :
  // IntColumn get id => integer().autoIncrement().call();
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  TextColumn get content => text().nullable()();
  DateTimeColumn get date => dateTime().nullable()();
}

@UseMoor(tables: [BlogPost])
class MoorDb extends _$MoorDb{
  MoorDb():super(FlutterQueryExecutor.inDatabaseFolder(path: 'blog.db'));
  @override
  int get schemaVersion => 1;

}