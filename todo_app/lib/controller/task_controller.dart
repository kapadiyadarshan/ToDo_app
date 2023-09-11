import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/modal/task_modal.dart';

class TaskController extends ChangeNotifier {
  List<Task> _allTaskDataList = [];

  List<String> allTask = [];
  List<String> allDate = [];
  List<String> allTime = [];

  late SharedPreferences preferences;

  TaskController({required this.preferences});

  String taskKey = "taskKey";
  String dateKey = "dateKey";
  String timeKey = "timeKey";

  initData() {
    allTask = preferences.getStringList(taskKey) ?? [];
    allDate = preferences.getStringList(dateKey) ?? [];
    allTime = preferences.getStringList(timeKey) ?? [];

    _allTaskDataList = List.generate(
      allTask.length,
      (index) => Task(
        task: allTask[index],
        date: allDate[index],
        time: allTime[index],
        isDone: "false",
      ),
    );
  }

  setData() {
    preferences
      ..setStringList(taskKey, allTask)
      ..setStringList(dateKey, allDate)
      ..setStringList(timeKey, allTime);

    notifyListeners();
  }

  get getAllTask {
    initData();
    return _allTaskDataList;
  }

  addTask({required Task task}) {
    initData();

    _allTaskDataList.add(task);

    allTask.add(task.task);
    allDate.add(task.date);
    allTime.add(task.time);

    setData();
  }

  removeTask({required int index}) {
    initData();
    _allTaskDataList.removeAt(index);

    allTask.removeAt(index);
    allDate.removeAt(index);
    allTime.removeAt(index);

    setData();
  }

  editTask({required Task task, required int index}) {
    initData();
    _allTaskDataList[index] = task;

    allTask[index] = task.task;
    allDate[index] = task.date;
    allTime[index] = task.time;

    setData();
  }

  doneTask({required int index}) {
    if (_allTaskDataList[index].isDone == "true") {
      _allTaskDataList[index].isDone = "false";
      notifyListeners();
    }

    if (_allTaskDataList[index].isDone == "false") {
      _allTaskDataList[index].isDone = "true";
      notifyListeners();
    }
  }
}
