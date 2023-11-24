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

  Future<void> updateData(
      int onePeso, int fivePeso, int tenPeso, int twentyPeso) async {
    final Database db = await database;

    // Get the current values of 'p1', 'p5', 'p10', and 'p20' from the database
    final Map<String, dynamic> currentData = (await db.query(
      tableName,
      columns: ['p1', 'p5', 'p10', 'p20'],
      where: 'id = ?',
      whereArgs: ['1'],
    ))
        .first;

    final int updatedP1 = currentData['p1'] + onePeso;
    final int updatedP5 = currentData['p5'] + fivePeso;
    final int updatedP10 = currentData['p10'] + tenPeso;
    final int updatedP20 = currentData['p20'] + twentyPeso;

    await db.update(
      tableName,
      {'p1': updatedP1, 'p5': updatedP5, 'p10': updatedP10, 'p20': updatedP20},
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
