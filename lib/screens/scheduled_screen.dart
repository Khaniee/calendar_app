import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/app_layout.dart';
import 'package:my_project/providers/event_provider.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/widgets/event_card.dart';
import 'package:my_project/widgets/text.dart';
import 'package:provider/provider.dart';

class ScheduledScreen extends StatefulWidget {
  const ScheduledScreen({super.key});

  @override
  State<ScheduledScreen> createState() => _ScheduledScreenState();
}

class _ScheduledScreenState extends State<ScheduledScreen> {
  Map<DateTime, List<Event>> events = {};

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<EventProvider>().fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return AppLayout(
      title: "Scheduled Events",
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: double.maxFinite,
        child: eventProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                    children: eventProvider.events.entries
                        .map(
                          (entry) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(DateFormat('dd MMM').format(entry.key)),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  children: entry.value
                                      .map((e) => EventCard(
                                            event: e,
                                            onEventModify:
                                                eventProvider.fetchEvents,
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList()),
              ),
      ),
    );
  }
}
