import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:news_feed/models/db/dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class ArticleRecords extends Table{
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get url => text()();
  TextColumn get urlToImage => text()();
  TextColumn get publishDate => text()();
  TextColumn get content => text()();

}

@UseMoor(tables: [ArticleRecords], daos: [NewsDao])
class MyDatabase extends _$MyDatabase{
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    // アプリでユーザーが置くためにアクセスできるフォルダを作ってる。
    // iOS, AndroidのフォルダをWrapして作ってくれてる。
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'news.db'));
    return VmDatabase(file);
  });
}
