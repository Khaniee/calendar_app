import 'package:my_project/models/database.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/models/task.dart';
import 'package:sqflite/sqflite.dart';

class TaskService {
  static Map<DateTime, List<Event>> events = {};

  static Future<int> delete(int id) async {
    final db = await AppDatabase.instance.database;
    return await db.delete(
      Task.tablename,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> update(Task e) async {
    final db = await AppDatabase.instance.database;
    return await db.update(
      Task.tablename,
      e.toJson(),
      where: 'id = ?',
      whereArgs: [e.id],
    );
  }

  static Future<Task> create(Task e) async {
    final db = await AppDatabase.instance.database;
    final id = await db.insert(
      Task.tablename,
      e.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // Mettez à jour l'ID de l'événement avec la valeur générée par la base de données.
    e.id = id;
    return e;
  }

  static Future<List<Task>> getAll() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(Task.tablename, orderBy: "id");
    return result.map((json) => Task.fromJson(json)).toList();
  }
}
