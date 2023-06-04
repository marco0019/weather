import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class LocalStorage {
  static late Database db;

  static Future<Database> initDB() async {
    //String path = await getDatabasesPath();
    return openDatabase('places.db', version: 1,
        onCreate: (database, version) async {
      await database.execute("""CREATE TABLE Recently(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      place TEXT NOT NULL, country TEXT NOT NULL,
      latitude REAL NOT NULL,
      longitude REAL NOT NULL)""");
      await database.execute("""CREATE TABLE PlaceSaved(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      place TEXT NOT NULL, country TEXT NOT NULL,
      latitude REAL NOT NULL,
        longitude REAL NOT NULL)""");
    });
  }

  static Future<void> insertData(String table,
      {required String place,
      required String country,
      required double longitude,
      required double latitude,
      required bool once}) async {
    if ((once && !contains(table, place) || !once)) {
      await db.insert(
          table,
          {
            'place': place,
            'country': country,
            'latitude': latitude,
            'longitude': longitude
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  static bool contains(String table, String place) {
    bool isInserted = true;
    db.query(table,
        where: 'place = ?',
        whereArgs: [place]).then((value) => isInserted = value.isNotEmpty);
    debugPrint('$table:  $isInserted');
    return isInserted;
  }

  static Future<List<Map<String, dynamic>>> getItems(String table) async =>
      await db.query(table);
}
