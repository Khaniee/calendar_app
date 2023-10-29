import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/app_layout.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/models/task.dart';
import 'package:my_project/providers/event_provider.dart';
import 'package:my_project/providers/task_provider.dart';
import 'package:my_project/services/task_event_service.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';
import 'package:my_project/widgets/event_card.dart';
import 'package:my_project/widgets/text.dart';
import 'package:provider/provider.dart';

import '../widgets/task_card.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  int currentBody = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<EventProvider>().fetchEvents();
      context.read<TaskProvider>().fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);

    final today = DateTime.now();

    var mergedList = TaskAndEventService.orderByHour(
      taskProvider.tasks.where((element) => !element.isDone).toList(),
      eventProvider.getEventsForDay(today),
    );

    var sortedList = TaskAndEventService.divideListByTime(mergedList);

    List listBody = [
      {
        "label": "My Task & Events (${mergedList.length})",
        "icons": Icons.calendar_today,
        "body": TodayTaskAndEvent(
          taskProvider: taskProvider,
          eventProvider: eventProvider,
          morningList: sortedList[0],
          eveningList: sortedList[1],
        ),
      },
      {
        "label":
            "Done (${taskProvider.tasks.where((element) => element.isDone).length})",
        "icons": Icons.done,
        "body": DoneTask(
          tasks: taskProvider.tasks.where((element) => element.isDone).toList(),
          taskProvider: taskProvider,
        ),
      },
    ];

    return AppLayout(
      title: "",
      appBarColor: AppColor.primary,
      child: (taskProvider.isLoading || eventProvider.isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  color: AppColor.primary,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const AppText(
                            "Today",
                            color: AppColor.white,
                            fontSize: AppFontSize.extraExtraLarge,
                            isBold: true,
                          ),
                          const Expanded(child: SizedBox()),
                          AppText(
                            DateFormat('d MMMM, yyyy').format(today),
                            fontSize: AppFontSize.large,
                            color: AppColor.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          AppText(
                            "${taskProvider.tasks.length} Tasks",
                            color: AppColor.white,
                          ),
                          const SizedBox(width: 10),
                          const AppText("|", color: AppColor.white),
                          const SizedBox(width: 10),
                          AppText(
                            "${eventProvider.events.length} Events",
                            color: AppColor.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    listBody.length,
                    (index) => Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: currentBody == index
                              ? AppColor.darkPrimary
                              : AppColor.lightPrimary,
                          foregroundColor: currentBody == index
                              ? AppColor.white
                              : AppColor.darkPrimary,
                        ),
                        icon: Icon(listBody[index]["icons"]),
                        onPressed: () {
                          setState(() {
                            currentBody = index;
                          });
                        },
                        label: AppText(
                          listBody[index]["label"],
                          color: currentBody == index
                              ? AppColor.white
                              : AppColor.darkPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: listBody[currentBody]["body"]),
                )
              ],
            ),
    );
  }
}

class DoneTask extends StatelessWidget {
  const DoneTask({super.key, required this.tasks, required this.taskProvider});

  final TaskProvider taskProvider;
  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: tasks.isEmpty
          ? const AppText("Vos taches finis s'affichent ici!")
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                tasks.length,
                (index) => TaskCard(
                  task: tasks[index],
                  onTaskUpdate: taskProvider.fetchTasks,
                  onDoneStatusChanged: (value) {
                    tasks[index].isDone = value!;
                    taskProvider.updateTask(tasks[index]);
                  },
                ),
              ),
            ),
    );
  }
}

class TodayTaskAndEvent extends StatelessWidget {
  const TodayTaskAndEvent({
    super.key,
    required this.taskProvider,
    required this.eventProvider,
    required this.morningList,
    required this.eveningList,
  });

  final List<dynamic> morningList;
  final List<dynamic> eveningList;
  final TaskProvider taskProvider;
  final EventProvider eventProvider;

  Widget buildCard(dynamic element) {
    if (element is Task) {
      return TaskCard(
        task: element,
        onTaskUpdate: taskProvider.fetchTasks,
        onDoneStatusChanged: (value) {
          element.isDone = value!;
          taskProvider.updateTask(element);
        },
      );
    } else if (element is Event) {
      return EventCard(
          event: element, onEventModify: eventProvider.fetchEvents);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppText(
            "Morning",
            fontSize: AppFontSize.extraLarge,
            isBold: true,
          ),
        ),
        if (morningList.isEmpty)
          const SizedBox(
            height: 50,
            width: double.maxFinite,
            child: Center(
              child: AppText("Vous etes libre"),
            ),
          )
        else
          ...morningList.map((e) => buildCard(e)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppText(
            "Evening",
            fontSize: AppFontSize.extraLarge,
            isBold: true,
          ),
        ),
        if (eveningList.isEmpty)
          const SizedBox(
            height: 50,
            width: double.maxFinite,
            child: Center(
              child: AppText("Vous etes libre"),
            ),
          )
        else
          ...eveningList.map((e) => buildCard(e)),
      ]),
    );
  }
}
