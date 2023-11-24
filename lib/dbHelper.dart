// database_helper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'my_table';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'my_db.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY, p1 INTEGER, p5 INTEGER, p10 INTEGER, p20 INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertData(Map<String, dynamic> data) async {
    final Database db = await database;
    await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateData(int newData, String peso) async {
    final Database db = await database;
    await db.update(
      tableName,
      {
        if (peso == "p1")
          'p1': newData
        else if (peso == "p5")
          'p5': newData
        else if (peso == "p10")
          'p10': newData
        else if (peso == "p20")
          'p20': newData
      },
      where: 'id = ?',
      whereArgs: ['1'],
    );
    print('data updated');
  }

  Future<List<Map<String, dynamic>>> getData() async {
    final Database db = await database;
    print('data fetched');
    return db.query(tableName);
  }
}
