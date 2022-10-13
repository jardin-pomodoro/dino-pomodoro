import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseSource {
  Future<Database> openDb() async {
    return openDatabase(
      p.join(await getDatabasesPath(), "dino.db"),
      onCreate: (db, _) {
        db.execute('''
          CREATE TABLE DINO(
            dino_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name varchar(255) NOT NULL,
            step varchar(50) NOT NULL,
            color varchar(255) NOT NULL,
            openning_time datetime NOT NULL
          )
        ''');
      },
      version: 1,
    );
  }
}
