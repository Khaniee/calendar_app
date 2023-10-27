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

class BottomNavBarPages extends StatefulWidget {
  const BottomNavBarPages({super.key});

  @override
  State<BottomNavBarPages> createState() => _BottomNavBarPagesState();
}

class _BottomNavBarPagesState extends State<BottomNavBarPages> {
  TextEditingController titleInput = TextEditingController();
  DateTime debutDate = DateTime.now();
  DateTime finDate = DateTime.now();
  TextEditingController debutdateinput = TextEditingController();
  TextEditingController findateinput = TextEditingController();
  TextEditingController lieuInput = TextEditingController();
  TextEditingController chosesAEmporterInput = TextEditingController();

  final _eventFormKey = GlobalKey<FormState>();

  int currentTab = 1;
  final List<Widget> screens = [
    CalendarScreen(),
    TodayScreen(),
    ScheduledScreen(),
    SettingScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = TodayScreen();
  String typeInput = "";
  @override
  void initState() {
    typeInput = "Fête";
    debutdateinput.text = ""; //set the initial value of text field
    findateinput.text = ""; //set the initial value of text field
    super.initState();
  }

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
    List<String> categories = [
      "Fête",
      "Anniversaire",
      "Repas",
      "Professionnel",
      "Autre",
    ];
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _eventFormKey,
          child: StatefulBuilder(
            builder: (BuildContext context,
                StateSetter setState /*You can rename this!*/) {
              return FractionallySizedBox(
                heightFactor: 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Ajouter évenement",
                          style: TextStyle(
                            color: AppColor.darkPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: titleInput,
                          decoration: const InputDecoration(
                            labelText: 'Entrez le titre',
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: debutdateinput,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: 'date de début',
                                ),
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(
                                          2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      debutDate = pickedDate;
                                      debutdateinput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                // controller: debutdateinput,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  labelText: 'heure de début',
                                  //
                                ),
                                onTap: () async {
                                  TimeOfDay? pickedDate = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        pickedDate.format(context);

                                    // setState(() {
                                    //   debutDate = pickedDate;
                                    //   debutdateinput.text =
                                    //       formattedDate; //set output date to TextField value.
                                    // });
                                  } else {
                                    print("Date is not selected");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: findateinput,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Entrez la date de fin',
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                findateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: lieuInput,
                          decoration: const InputDecoration(
                            labelText: 'Entrez le lieu',
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: InputDecorator(
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 16.0),
                                hintText: 'Entrez la catégorie',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            isEmpty: typeInput == "",
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isDense: true,
                                onChanged: (newValue) {
                                  print("change");
                                  print(newValue);
                                  setState(() {
                                    typeInput = newValue!;
                                  });
                                  print(typeInput);
                                },
                                value: typeInput,
                                items: categories.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: chosesAEmporterInput,
                          decoration: InputDecoration(
                            labelText: 'Les choses à apporter?',
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              if (_eventFormKey.currentState!.validate()) {
                                EventService.create(
                                  Event(
                                      null,
                                      titleInput.value.text,
                                      debutDate,
                                      finDate,
                                      typeInput,
                                      lieuInput.value.text,
                                      chosesAEmporterInput.value.text),
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: const Text("Ajouter")),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
