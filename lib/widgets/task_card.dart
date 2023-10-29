import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/models/task.dart';
import 'package:my_project/services/task_service.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/widgets/task_form.dart';
import 'package:my_project/widgets/text.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onTaskUpdate,
    this.onDoneStatusChanged,
  });

  final Function onTaskUpdate;
  final Function(bool? value)? onDoneStatusChanged;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
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
                value: task.isDone,
                onChanged: onDoneStatusChanged,
              ),
              AppText(
                task.title,
                isBold: true,
              ),
              const Expanded(child: SizedBox()),
              AppText(DateFormat("HH:mm").format(task.hour)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (BuildContext context) {
                      return TaskForm(
                        task: task,
                        callback: onTaskUpdate,
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.edit_note,
                  color: AppColor.divider,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("Avertissement"),
                      content: const AppText(
                          "Vous êtes sur de supprimer cette tache?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Annuler")),
                        TextButton(
                            onPressed: () {
                              if (task.id != null) {
                                TaskService.delete(task.id!);
                                onTaskUpdate();
                              }
                              Navigator.pop(context);
                            },
                            child: const Text("Supprimer")),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete_sweep,
                  color: AppColor.divider,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
