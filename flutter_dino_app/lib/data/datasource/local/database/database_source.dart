import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSource {
  Database? _db;

  Future<Database> db() async {
    _db ??= await _openDb();
    return _db!;
  }

  Future<Database> _openDb() async {
    String databasesPath = await getDatabasesPath();
    print("Databases path: $databasesPath");
    String path = join(databasesPath, "pomodoro.db");
    print("Database path: $path");

    final database = await openDatabase(
      path,
      onCreate: (db, version) async {
        print("Creating database");
        await db.execute('''
          CREATE TABLE user_auth(
            id TEXT PRIMARY KEY,
            json TEXT
          );
          
          CREATE TABLE friendship(
            id TEXT PRIMARY KEY,
            json TEXT
          );
        ''');
      },
      version: 1,
    );
    return database;
  }
}
