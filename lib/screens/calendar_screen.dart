import 'package:flutter/material.dart';
import 'package:my_project/app_layout.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/services/event_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/event_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool is_loading = true;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // store the events
  Map<DateTime, List<Event>> events = {};

  late final ValueNotifier<List<Event>> _selectedEvents;

  void initData() {
    EventService.getEventsByDay().then((value) {
      setState(() {
        events = value;
        is_loading = false;
        _selectedEvents.value = _getEventsForDay(_selectedDay);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<Event> _getEventsForDay(DateTime day) {
    print(events);
    // show event in a day
    DateTime formatedDay = DateTime(day.year, day.month, day.day);
    print(formatedDay);
    return events[formatedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    DateTime todayDate = DateTime.now();

    return is_loading
        ? Text("LOADING")
        : AppLayout(
            title: "Calendar",
            child: Column(
              children: [
                TableCalendar(
                  calendarFormat: _calendarFormat,
                  firstDay: DateTime(
                      todayDate.year - 10, todayDate.month, todayDate.day),
                  lastDay: DateTime(
                      todayDate.year + 10, todayDate.month, todayDate.day),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                      _selectedDay = selectedDay;
                      _selectedEvents.value = _getEventsForDay(_selectedDay);
                    });
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  eventLoader: _getEventsForDay,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: ValueListenableBuilder<List<Event>>(
                        valueListenable: _selectedEvents,
                        builder: (context, value, _) {
                          return ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                return EventCard(
                                  event: value[index],
                                  onEventModify: initData,
                                );
                              });
                        }),
                  ),
                ),
              ],
            ),
          );
  }
}
