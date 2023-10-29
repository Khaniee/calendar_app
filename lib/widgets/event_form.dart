import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/services/event_service.dart';
import 'package:my_project/utils/color.dart';

List<String> eventCategories = [
  "Fête",
  "Anniversaire",
  "Repas",
  "Professionnel",
  "Autre",
];

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
  TimeOfDay heureDebut = TimeOfDay.now();
  TextEditingController heureFinInput = TextEditingController();
  TimeOfDay heureFin = TimeOfDay.now();
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
      debutDate = widget.event!.dateDebut;
      debutdateinput.text = DateFormat('yyyy-MM-dd').format(debutDate);
      finDate = widget.event!.dateFin;
      findateinput.text = DateFormat('yyyy-MM-dd').format(finDate);
      lieuInput.text = widget.event!.lieu;
      chosesAEmporterInput.text = widget.event!.chosesApporter ?? "";
      heureDebut = TimeOfDay.fromDateTime(widget.event!.dateDebut);
      heureDebutInput.text = DateFormat('HH:mm').format(debutDate);
      heureFin = TimeOfDay.fromDateTime(widget.event!.dateFin);
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
    bool isModification = widget.event != null && widget.event!.id != null;
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
                      isModification
                          ? "Modifier évènement"
                          : "Ajouter évènement",
                      style: const TextStyle(
                        color: AppColor.darkPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                  initialDate: debutDate,
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
                        const SizedBox(
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
                                initialTime: heureDebut,
                              );
                              if (pickedTime != null) {
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
                                  initialDate: finDate,
                                  firstDate: DateTime(
                                      2000), //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  finDate = pickedDate;
                                  findateinput.text = formattedDate;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
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
                                initialTime: heureFin,
                              );
                              if (pickedTime != null) {
                                String formattedData =
                                    pickedTime.format(context);
                                setState(() {
                                  heureFinInput.text = formattedData;
                                  heureFin = pickedTime;
                                });
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
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintText: 'Entrez la catégorie',
                        ),
                        isEmpty: typeInput == "",
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                typeInput = newValue!;
                              });
                            },
                            value: typeInput,
                            items: eventCategories.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: chosesAEmporterInput,
                      decoration: const InputDecoration(
                        labelText: 'Les choses à apporter?',
                      ),
                      // The validator receives the text that the user has entered.
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_eventFormKey.currentState!.validate()) {
                            if (isModification) {
                              EventService.updateEvent(
                                Event(
                                  id: widget.event!.id,
                                  title: titleInput.value.text,
                                  dateDebut: DateTime(
                                    debutDate.year,
                                    debutDate.month,
                                    debutDate.day,
                                    heureDebut.hour,
                                    heureDebut.minute,
                                  ),
                                  dateFin: DateTime(
                                    finDate.year,
                                    finDate.month,
                                    finDate.day,
                                    heureFin.hour,
                                    heureFin.minute,
                                  ),
                                  type: typeInput,
                                  lieu: lieuInput.value.text,
                                  chosesApporter:
                                      chosesAEmporterInput.value.text,
                                ),
                              );
                            } else {
                              EventService.create(
                                Event(
                                  title: titleInput.value.text,
                                  dateDebut: DateTime(
                                    debutDate.year,
                                    debutDate.month,
                                    debutDate.day,
                                    heureDebut.hour,
                                    heureDebut.minute,
                                  ),
                                  dateFin: DateTime(
                                    finDate.year,
                                    finDate.month,
                                    finDate.day,
                                    heureFin.hour,
                                    heureFin.minute,
                                  ),
                                  type: typeInput,
                                  lieu: lieuInput.value.text,
                                  chosesApporter:
                                      chosesAEmporterInput.value.text,
                                ),
                              );
                            }
                            widget.callback!();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(isModification ? "Modifier" : "Ajouter")),
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
