import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  static late Database db;

  static Future<Database> initDB() async {
    //String path = await getDatabasesPath();
    return openDatabase('storage.db', version: 1,
        onCreate: (database, version) async {
          await database.execute("""CREATE TABLE Recently(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      place TEXT NOT NULL, country TEXT NOT NULL,
      latitude REAL NOT NULL,
      longitude REAL NOT NULL,
      date TEXT DEFAULT (STRFTIME('%Y-%m-%d', 'now', 'localtime')),
      UNIQUE (latitude, longitude))""");
          await database.execute("""CREATE TABLE PlaceSaved(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      place TEXT NOT NULL, country TEXT NOT NULL,
      latitude REAL NOT NULL,
      longitude REAL NOT NULL,
      date TEXT DEFAULT (STRFTIME('%Y-%m-%d', 'now', 'localtime')),
      UNIQUE (latitude, longitude))""");
        });
  }

  static Future<void> initTabla() async {

  }

  static Future<void> insertData(String table,
      {required String place,
        required String country,
        required double longitude,
        required double latitude,
        required bool once}) async {
    //if ((once && !contains(table, place)) || !once) {
    await db.insert(
        table,
        {
          'place': place,
          'country': country,
          'latitude': latitude,
          'longitude': longitude,
          'date': DateTime.now().toIso8601String()
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
    //}
  }

  static Future<bool> contains(String table,
      {required double latitude, required double longitude}) async {
    final result = await db.query(
      table,
      where: 'latitude = ? AND longitude = ?',
      whereArgs: [latitude, longitude],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  static Future<List<Map<String, dynamic>>> getItems(String table) async =>
      await db.query(table, orderBy: 'date DESC');

  static Future<void> delete({required String table, required int id}) async =>
      await db.delete(table, where: "id = $id");

  static Future<void> updateDate(String table, int id) async {
    await db.update(table, {'date': DateTime.now().toIso8601String()},
        where: 'id = ?', whereArgs: [id]);
  }
}
