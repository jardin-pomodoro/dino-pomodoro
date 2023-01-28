import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseSource {
  Future<Database> openDb() async {
    return openDatabase(
      p.join(await getDatabasesPath(), "dino.db"),
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE DINO(
            dino_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            color varchar(255) NOT NULL,
            form INTEGER NOT NULL,
          )
        ''');
      },
      version: 1,
    );
  }
}
