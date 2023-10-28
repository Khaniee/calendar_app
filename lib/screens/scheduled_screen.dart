import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/app_layout.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/services/event_service.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';
import 'package:my_project/widgets/event_card.dart';
import 'package:my_project/widgets/text.dart';

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

    EventService.getEventsByDay().then(
      (value) => setState(
        () {
          events = value;
          isLoading = false;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "Scheduled Events",
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
              children: events.entries
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
                                      onEventModify: () {},
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

class TodayEventCard extends StatelessWidget {
  const TodayEventCard({
    super.key,
  });

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
                "Event for today",
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

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: AppColor.divider, offset: Offset(0, 1), blurRadius: 1)
        ],
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: false,
                onChanged: (value) {},
              ),
              AppText(
                "Task 2",
                isBold: true,
              ),
              const Expanded(child: SizedBox()),
              AppText("09:00"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
