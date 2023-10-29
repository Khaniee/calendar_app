import 'package:flutter/material.dart';
import 'package:my_project/models/task.dart';
import 'package:my_project/services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Task> tasks = [];

  Future<void> fetchTasks() async {
    var value = await TaskService.getAll();
    tasks = value;
    isLoading = false;
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    TaskService.update(task);
    notifyListeners();
  }
}
