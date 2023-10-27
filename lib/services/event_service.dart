import 'package:my_project/event.dart';
import 'package:my_project/models/database.dart';

class AppEventService {
  static Future<int> deleteEvent(int eventId) async {
    final db = await AppDatabase.instance.database;
    return await db.delete(
      Event.tablename,
      where: 'id = ?',
      whereArgs: [eventId],
    );
  }

  Future<int> updateEvent(Event event) async {
    final db = await AppDatabase.instance.database;
    return await db.update(
      Event.tablename,
      event.toJson(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }
}
