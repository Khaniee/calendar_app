import 'package:flutter/material.dart';
import 'package:my_project/app_layout.dart';
import 'package:my_project/event.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';
import 'package:my_project/widgets/text.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  // store the events
  Map<DateTime, List<Event>> events = {};

  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<Event> _getEventsForDay(DateTime day) {
    // show event in a day
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    DateTime todayDate = DateTime.now();

    return AppLayout(
      title: "Calendar",
      child: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            firstDay:
                DateTime(todayDate.year - 10, todayDate.month, todayDate.day),
            lastDay:
                DateTime(todayDate.year + 10, todayDate.month, todayDate.day),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay; // update `_focusedDay` here as well
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
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              ElevatedButton(
                onPressed: () {
                  events.addAll({
                    _selectedDay: [Event("titre event", "lieu event")]
                  });
                  _selectedEvents.value = _getEventsForDay(_selectedDay);
                },
                child: Text("NEW EVENT"),
              ),
            ]),
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
                          return TodayEventCard(event: value[index]);
                        });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class TodayEventCard extends StatelessWidget {
  const TodayEventCard({
    super.key,
    required this.event,
  });
  final Event event;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: AppColor.divider, offset: Offset(0, 2), blurRadius: 3)
        ],
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppText(
                event.title,
                isBold: true,
              ),
              const Expanded(child: SizedBox()),
              AppText("22:00 - 21:30"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColor.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: AppText(
                  "Party",
                  color: AppColor.primary,
                  fontSize: AppFontSize.small,
                  isBold: true,
                )),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                "526 Nader Port",
              ),
              Row(
                children: [
                  Icon(
                    Icons.edit_note,
                    color: AppColor.divider,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.delete_sweep,
                    color: AppColor.divider,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
