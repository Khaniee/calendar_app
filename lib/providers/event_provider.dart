import 'package:flutter/material.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/services/event_service.dart';
import 'package:table_calendar/table_calendar.dart';

class EventProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Event> eventList = [];
  Map<DateTime, List<Event>> events = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  List<Event> selectedEvents = [];

  Future<void> fetchEvents() async {
    eventList = await EventService.getAll();
    events = await EventService.getEventsByDay(eventList);
    isLoading = false;
    selectedEvents = getEventsForDay(selectedDay);
    notifyListeners();
  }

  void setSelectedDay(value) {
    selectedDay = value;
    selectedEvents = getEventsForDay(selectedDay);
    notifyListeners();
  }

  List<Event> getEventsForDay(DateTime day) {
    DateTime formatedDay = DateTime(day.year, day.month, day.day);
    return events[formatedDay] ?? [];
  }
}
