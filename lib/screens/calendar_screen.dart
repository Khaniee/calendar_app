import 'package:flutter/material.dart';
import 'package:my_project/app_layout.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/providers/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/event_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // store the events
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<EventProvider>().fetchEvents();
    });
  }

  List<Event> _getEventsForDay(DateTime day) {
    DateTime formatedDay = DateTime(day.year, day.month, day.day);
    return context.read<EventProvider>().events[formatedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    DateTime todayDate = DateTime.now();
    final eventProvider = Provider.of<EventProvider>(context);

    return AppLayout(
      title: "Calendar",
      child: eventProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                TableCalendar(
                  calendarFormat: eventProvider.calendarFormat,
                  firstDay: DateTime(
                      todayDate.year - 10, todayDate.month, todayDate.day),
                  lastDay: DateTime(
                      todayDate.year + 10, todayDate.month, todayDate.day),
                  focusedDay: eventProvider.focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(eventProvider.selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    eventProvider.setSelectedDay(selectedDay);
                  },
                  onFormatChanged: (format) {
                    if (eventProvider.calendarFormat != format) {
                      setState(() {
                        eventProvider.calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    eventProvider.focusedDay = focusedDay;
                  },
                  eventLoader: _getEventsForDay,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: eventProvider.selectedEvents.length,
                      itemBuilder: (context, index) {
                        return EventCard(
                            onEventModify: eventProvider.fetchEvents,
                            event: eventProvider.selectedEvents[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
