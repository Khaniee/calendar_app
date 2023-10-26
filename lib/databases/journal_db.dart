import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class JournalDB {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      title TEXT,
      description TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);
  }

  static Future<sql.Database> getDatabase() async {
    return sql.openDatabase(
      'database.db',
      version: 1,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  static Future<int> createItem(String title, String? description) async {
    final db = await JournalDB.getDatabase();

    final data = {"title": title, "description": description};

    final id = await db.insert(
      "items",
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await JournalDB.getDatabase();
    return db.query("items", orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await JournalDB.getDatabase();
    return db.query("items", where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String title, String? description) async {
    final db = await JournalDB.getDatabase();

    final data = {
      "title": title,
      "description": description,
      "createdAt": DateTime.now().toString()
    };

    final result = await db.update(
      "items",
      data,
      where: "id = ?",
      whereArgs: [id],
    );

    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await JournalDB.getDatabase();

    try {
      await db.delete(
        "items",
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (err) {
      debugPrint("Erreur: $err");
    }
  }
}
