// database_helper.dart
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String coinTable = 'my_coin_table';
  static const String historyTable = 'my_history_table';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'my_dataBase.db'),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $coinTable (
          id INTEGER PRIMARY KEY,
          p1 INTEGER,
          p5 INTEGER,
          p10 INTEGER,
          p20 INTEGER
        )
      ''');

        await db.execute('''
        CREATE TABLE $historyTable (
          id INTEGER PRIMARY KEY,
          totalCoins INTEGER,
          date TEXT
        )
      ''');
      },
      version: 1,
    );
  }

  // Future<void> deleteDB() async {
  //   String databasePath = join(await getDatabasesPath(), 'my_db3.db');
  //   await deleteDatabase(databasePath);
  //   print('Database deleted.');
  // }

  Future<void> insertCoinData(Map<String, dynamic> data) async {
    final Database db = await database;
    await db.insert(coinTable, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertHistoryData(Map<String, dynamic> data) async {
    final Database db = await database;
    await db.insert(historyTable, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateData(
      int onePeso, int fivePeso, int tenPeso, int twentyPeso) async {
    final Database db = await database;

    // Get the current values of 'p1', 'p5', 'p10', and 'p20' from the database
    final Map<String, dynamic> currentData = (await db.query(
      coinTable,
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
      coinTable,
      {'p1': updatedP1, 'p5': updatedP5, 'p10': updatedP10, 'p20': updatedP20},
      where: 'id = ?',
      whereArgs: ['1'],
    );
    print('data updated');
  }

  Future<List<Map<String, dynamic>>> getCoinData() async {
    final Database db = await database;
    print('coin data fetched');
    return db.query(coinTable);
  }

  Future<List<Map<String, dynamic>>> getHistoryData() async {
    final Database db = await database;
    print('history data fetched');
    return db.query(historyTable);
  }
}

Future<List<String>> getTablesList(String databaseName) async {
  Database database = await openDatabase(
    join(await getDatabasesPath(), databaseName),
  );

  // Query to get the list of tables in the database
  List<Map<String, dynamic>> tables = await database.rawQuery(
    "SELECT name FROM sqlite_master WHERE type='table';",
  );

  // Extract table names from the result
  List<String> tableNames =
      tables.map((table) => table['name'] as String).toList();

  // Close the database
  await database.close();

  return tableNames;
}
