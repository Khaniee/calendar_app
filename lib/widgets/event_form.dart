import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/bottom_navbar_pages.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/services/event_service.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/widgets/text.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key, this.event, this.callback});

  final Event? event;
  final Function? callback;

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _eventFormKey = GlobalKey<FormState>();

  TextEditingController heureDebutInput = TextEditingController();
  TimeOfDay heureDebut = const TimeOfDay(hour: 00, minute: 00);
  TextEditingController heureFinInput = TextEditingController();
  TimeOfDay heureFin = const TimeOfDay(hour: 00, minute: 00);
  TextEditingController titleInput = TextEditingController();
  DateTime debutDate = DateTime.now();
  DateTime finDate = DateTime.now();
  TextEditingController debutdateinput = TextEditingController();
  TextEditingController findateinput = TextEditingController();
  TextEditingController lieuInput = TextEditingController();
  TextEditingController chosesAEmporterInput = TextEditingController();
  String typeInput = "";
  @override
  void initState() {
    if (widget.event != null) {
      typeInput = widget.event!.type;
      titleInput.text = widget.event!.title;
      debutDate = widget.event!.date_debut;
      debutdateinput.text = DateFormat('yyyy-MM-dd').format(debutDate);
      finDate = widget.event!.date_fin;
      findateinput.text = DateFormat('yyyy-MM-dd').format(finDate);
      lieuInput.text = widget.event!.lieu;
      chosesAEmporterInput.text = widget.event!.choses_apporter;
      heureDebut = TimeOfDay.fromDateTime(widget.event!.date_debut);
      heureDebutInput.text = DateFormat('HH:mm').format(debutDate);
      heureFin = TimeOfDay.fromDateTime(widget.event!.date_fin);
      heureFinInput.text = DateFormat('HH:mm').format(finDate);
    } else {
      typeInput = "Fête";
      debutdateinput.text = ""; //set the initial value of text field
      findateinput.text = ""; //set the initial value of text field
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Fête",
      "Anniversaire",
      "Repas",
      "Professionnel",
      "Autre",
    ];
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      widget.event == null
                          ? "Ajouter évènement"
                          : "Modifier évènement",
                      style: const TextStyle(
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
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
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
                            controller: heureDebutInput,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'heure de début',
                              //
                            ),
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                print(
                                    pickedTime); //pickedTime output format => 2021-03-10 00:00:00.000
                                String formattedData =
                                    pickedTime.format(context);
                                setState(() {
                                  heureDebutInput.text = formattedData;
                                  heureDebut = pickedTime;
                                });
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: findateinput,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'date de fin',
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
                                setState(() {
                                  finDate = pickedDate;
                                  findateinput.text = formattedDate;
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
                            controller: heureFinInput,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'heure de fin',
                              //
                            ),
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedTime != null) {
                                print(
                                    pickedTime); //pickedTime output format => 2021-03-10 00:00:00.000
                                String formattedData =
                                    pickedTime.format(context);
                                setState(() {
                                  heureFinInput.text = formattedData;
                                  heureFin = pickedTime;
                                });
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
                      decoration: const InputDecoration(
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
                            if (widget.event == null) {
                              EventService.create(
                                Event(
                                    null,
                                    titleInput.value.text,
                                    DateTime(
                                      debutDate.year,
                                      debutDate.month,
                                      debutDate.day,
                                      heureDebut.hour,
                                      heureDebut.minute,
                                    ),
                                    finDate,
                                    typeInput,
                                    lieuInput.value.text,
                                    chosesAEmporterInput.value.text),
                              );
                            } else {
                              EventService.updateEvent(
                                Event(
                                  widget.event!.id,
                                  titleInput.value.text,
                                  DateTime(
                                    debutDate.year,
                                    debutDate.month,
                                    debutDate.day,
                                    heureDebut.hour,
                                    heureDebut.minute,
                                  ),
                                  finDate,
                                  typeInput,
                                  lieuInput.value.text,
                                  chosesAEmporterInput.value.text,
                                ),
                              );
                            }
                            widget.callback!();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                            widget.event == null ? "Ajouter" : "Modifier")),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
