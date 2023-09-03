import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/modal/task_modal.dart';

class TaskController extends ChangeNotifier {
  List<Task> _allTask = [];

  late SharedPreferences preferences;

  TaskController({required this.preferences});

  List<String> allTasks = [];
  List<String> allDates = [];
  List<String> allTimes = [];
  List<String> allIsDone = [];

  String sfTask = "task";
  String sfDate = "date";
  String sfTime = "time";
  String sfIsDone = "isDone";

  init() {
    allTasks = preferences.getStringList(sfTask) ?? [];
    allDates = preferences.getStringList(sfDate) ?? [];
    allTimes = preferences.getStringList(sfTime) ?? [];
    allIsDone = preferences.getStringList(sfIsDone) ?? [];
  }

  get getAllTask {
    return _allTask;
  }

  addTask({required Task task}) {
    _allTask.add(task);
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
