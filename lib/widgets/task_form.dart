import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/models/task.dart';
import 'package:my_project/services/task_service.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';
import 'package:my_project/widgets/text.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key, this.task, this.callback});

  final Function? callback;
  final Task? task;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleInputController = TextEditingController();
  TextEditingController heureInputController = TextEditingController();
  TimeOfDay heureInput = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      var task = widget.task!;
      titleInputController.text = task.title;
      heureInput = TimeOfDay.fromDateTime(task.hour);
      heureInputController.text = DateFormat("HH:mm").format(task.hour);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isModification = widget.task != null && widget.task!.id != null;
    return StatefulBuilder(
      builder: (context, setState) => Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 15,
          ),
          width: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                "Create Task & Event",
                color: AppColor.darkPrimary,
                fontSize: AppFontSize.large,
              ),
              TextFormField(
                controller: titleInputController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Titre obligatoire";
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Titre du tache",
                  labelStyle: TextStyle(
                    color: AppColor.textColor,
                    fontSize: AppFontSize.medium,
                  ),
                ),
              ),
              TextFormField(
                controller: heureInputController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Heure",
                  labelStyle: TextStyle(
                    color: AppColor.textColor,
                    fontSize: AppFontSize.medium,
                  ),
                ),
                onTap: () async {
                  TimeOfDay? pickedData = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedData != null) {
                    String formatedData = pickedData.format(context);
                    setState(() {
                      heureInput = pickedData;
                      heureInputController.text = formatedData;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var now = DateTime.now();
                      if (isModification) {
                        TaskService.update(
                          Task(
                            id: widget.task!.id!,
                            isDone: widget.task!.isDone,
                            title: titleInputController.text,
                            hour: DateTime(
                              now.year,
                              now.month,
                              now.day,
                              heureInput.hour,
                              heureInput.minute,
                            ),
                          ),
                        );
                      } else {
                        TaskService.create(
                          Task(
                            title: titleInputController.text,
                            hour: DateTime(
                              now.year,
                              now.month,
                              now.day,
                              heureInput.hour,
                              heureInput.minute,
                            ),
                          ),
                        );
                        titleInputController.text = "";
                        heureInput = TimeOfDay.fromDateTime(now);
                        heureInputController.text =
                            DateFormat("HH:mm").format(now);
                      }
                      widget.callback!();
                      Navigator.pop(context);
                    }
                  },
                  child:
                      Text(isModification ? "Modifier Tache" : "Créer Tache"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
