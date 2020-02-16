import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbHelper {
static const String placesTableName = 'places';

static Future<Database> _database() async {
  final dbPath = await sql.getDatabasesPath();

  return sql.openDatabase(
    path.join(dbPath, 'great_places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE $placesTableName(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    },
    version: 1,
  );
}

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await _database();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper._database();
    return await db.query(table);
  }
}
