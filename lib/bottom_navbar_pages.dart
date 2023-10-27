import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/screens/calendar_screen.dart';
import 'package:my_project/screens/scheduled_screen.dart';
import 'package:my_project/screens/setting_screen.dart';
import 'package:my_project/screens/today_screen.dart';
import 'package:my_project/services/event_service.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/widgets/text.dart';

import 'widgets/event_form.dart';

class BottomNavBarPages extends StatefulWidget {
  const BottomNavBarPages({super.key});

  @override
  State<BottomNavBarPages> createState() => _BottomNavBarPagesState();
}

class _BottomNavBarPagesState extends State<BottomNavBarPages> {
  int currentTab = 1;
  final List<Widget> screens = [
    CalendarScreen(),
    TodayScreen(),
    ScheduledScreen(),
    SettingScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = TodayScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddEventBottomSheet(context);
        },
        child: Icon(Icons.add),
        backgroundColor: AppColor.primary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 0;
                        currentScreen = screens[currentTab];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color:
                              currentTab == 0 ? AppColor.primary : Colors.grey,
                        ),
                        AppText(
                          "Calendar",
                          color:
                              currentTab == 0 ? AppColor.primary : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 1;
                        currentScreen = screens[currentTab];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wb_sunny,
                          color:
                              currentTab == 1 ? AppColor.primary : Colors.grey,
                        ),
                        AppText(
                          "Today",
                          color:
                              currentTab == 1 ? AppColor.primary : Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 2;
                        currentScreen = screens[currentTab];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time,
                          color:
                              currentTab == 2 ? AppColor.primary : Colors.grey,
                        ),
                        AppText(
                          "Scheduled",
                          color:
                              currentTab == 2 ? AppColor.primary : Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentTab = 3;
                        currentScreen = screens[currentTab];
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color:
                              currentTab == 3 ? AppColor.primary : Colors.grey,
                        ),
                        AppText(
                          "Setting",
                          color:
                              currentTab == 3 ? AppColor.primary : Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showAddEventBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return const EventForm();
      },
    );
  }
}
