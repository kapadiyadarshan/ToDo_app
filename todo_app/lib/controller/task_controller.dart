import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/modal/task_modal.dart';

class TaskController extends ChangeNotifier {
  List<Task> _allTask = [];

  late SharedPreferences preferences;

  TaskController({required this.preferences});

  List<String> allTasks = [];
  List<String> allIsDone = [];

  String sfTask = "task";
  String sfIsDone = "isDone";

  get getAllTask {
    return _allTask;
  }

  init() {
    allTasks = preferences.getStringList(sfTask) ?? [];
    allIsDone = preferences.getStringList(sfIsDone) ?? [];
  }

  setDate() {
    preferences
      ..setStringList(sfTask, allTasks)
      ..setStringList(sfIsDone, allIsDone);

    notifyListeners();
  }

  addTask({required Task task}) {
    _allTask.add(task);

    allTasks.add(task.task);
    allIsDone.add(task.isDone.toString());

    setDate();
    notifyListeners();
  }

  removeTask({required int index}) {
    _allTask.removeAt(index);
    notifyListeners();
  }

  doneTask({required int index}) {
    _allTask[index].isDone = !_allTask[index].isDone;
    notifyListeners();
  }
}
