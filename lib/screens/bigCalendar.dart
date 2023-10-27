import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BigCalendar extends StatefulWidget {
  const BigCalendar({super.key});

  @override
  State<BigCalendar> createState() => _BigCalendarState();
}

class _BigCalendarState extends State<BigCalendar> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime todayDate = DateTime.now();
    return TableCalendar(
      calendarFormat: CalendarFormat.month,
      firstDay: DateTime(todayDate.year - 10, todayDate.month, todayDate.day),
      lastDay: DateTime(todayDate.year + 10, todayDate.month, todayDate.day),
      focusedDay: todayDate,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay; // update `_focusedDay` here as well
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}
