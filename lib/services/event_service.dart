import 'package:intl/intl.dart';
import 'package:my_project/models/database.dart';
import 'package:my_project/models/event.dart';
import 'package:sqflite/sqflite.dart';

class EventService {
  static Map<DateTime, List<Event>> events = {};

  static Future<Map<DateTime, List<Event>>> getEventsByDay() async {
    Map<DateTime, List<Event>> eventsByDay = {};

    var events = await EventService.getAll();
    for (Event event in events) {
      DateTime key = event.date_debut;
      if (eventsByDay[key] != null) {
        eventsByDay[key]!.add(event);
      }
      eventsByDay[key] = [event];
    }

    return eventsByDay;
  }

  static List<Event> getEventsForDay(DateTime day) {
    String currentday = DateFormat('yyyy-MM-dd').format(day);

    Map<String, List<Event>> eventsByDay = {};

    EventService.getAll().then(
      (events) {
        for (Event event in events) {
          String key = DateFormat('yyyy-MM-dd').format(event.date_debut);
          if (eventsByDay[key] != null) {
            eventsByDay[key]!.add(event);
          }
          eventsByDay[key] = [event];
        }
        var result = eventsByDay[currentday] ?? [];

        print("events by day:");
        print(eventsByDay);
        print("day:");
        print(currentday);
        print("result:");
        print(result);
        return result;
      },
    );

    return [];
  }

  static Future<Event> create(Event entity) async {
    print("CREATIONHERE");
    final db = await AppDatabase.instance.database;
    final id = await db.insert(
      "events",
      entity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // Mettez à jour l'ID de l'événement avec la valeur générée par la base de données.
    entity.id = id;
    return entity;
  }

  static Future<List<Event>> getAll() async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(Event.tablename, orderBy: "id");
    return result.map((json) => Event.fromJson(json)).toList();
  }
}
