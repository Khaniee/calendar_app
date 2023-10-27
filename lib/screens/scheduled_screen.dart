import 'package:flutter/material.dart';
import 'package:my_project/app_layout.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';
import 'package:my_project/widgets/text.dart';

class ScheduledScreen extends StatelessWidget {
  const ScheduledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "Scheduled Events",
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("28 Jan"),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TodayEventCard(),
                        TodayEventCard(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("14 Fev"),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TodayEventCard(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText("26 Fev"),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      TodayEventCard(),
                      TodayEventCard(),
                      TodayEventCard(),
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
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
