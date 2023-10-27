import 'package:flutter/material.dart';
import 'package:my_project/app_layout.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';
import 'package:my_project/widgets/text.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  int currentBody = 0;

  List listBody = [
    {
      "label": "My Task & Events",
      "icons": Icons.calendar_today,
      "body": TodayTaskAndEvent(),
    },
    {
      "label": "Done",
      "icons": Icons.done,
      "body": DoneTask(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "",
      appBarColor: AppColor.primary,
      child: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              color: AppColor.primary,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppText(
                        "Today",
                        color: AppColor.white,
                        fontSize: AppFontSize.extraExtraLarge,
                        isBold: true,
                      ),
                      const Expanded(child: SizedBox()),
                      AppText(
                        "11 January, 2019",
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
                        "2 Tasks",
                        color: AppColor.white,
                      ),
                      const SizedBox(width: 10),
                      AppText("|", color: AppColor.white),
                      const SizedBox(width: 10),
                      AppText(
                        "1 Events",
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
              child:
                  SingleChildScrollView(child: listBody[currentBody]["body"]),
            )
          ],
        ),
      ),
    );
  }
}

class DoneTask extends StatelessWidget {
  const DoneTask({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TaskCard(),
        TaskCard(),
      ]),
    );
  }
}

class TodayTaskAndEvent extends StatelessWidget {
  const TodayTaskAndEvent({
    super.key,
  });

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
        TaskCard(),
        TaskCard(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: AppText(
            "Evening",
            fontSize: AppFontSize.extraLarge,
            isBold: true,
          ),
        ),
        TodayEventCard(),
        TodayEventCard(),
      ]),
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
