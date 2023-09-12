import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/modal/task_modal.dart';

class TaskController extends ChangeNotifier {
  List<Task> _allTaskDataList = [];

  List<String> allTask = [];
  List<String> allDate = [];
  List<String> allTime = [];
  List<String> allIsDone = [];

  late SharedPreferences preferences;

  TaskController({required this.preferences});

  String taskKey = "taskKey";
  String dateKey = "dateKey";
  String timeKey = "timeKey";
  String isDoneKey = "isDoneKey";

  initData() {
    allTask = preferences.getStringList(taskKey) ?? [];
    allDate = preferences.getStringList(dateKey) ?? [];
    allTime = preferences.getStringList(timeKey) ?? [];
    allIsDone = preferences.getStringList(isDoneKey) ?? [];

    _allTaskDataList = List.generate(
      allTask.length,
      (index) => Task(
        task: allTask[index],
        date: allDate[index],
        time: allTime[index],
        isDone: (allIsDone[index] == "true") ? true : false,
      ),
    );
  }

  setData() {
    preferences
      ..setStringList(taskKey, allTask)
      ..setStringList(dateKey, allDate)
      ..setStringList(timeKey, allTime)
      ..setStringList(isDoneKey, allIsDone);

    notifyListeners();
  }

  get getAllTask {
    initData();
    return _allTaskDataList;
  }

  addTask({required Task task}) {
    initData();

    // _allTaskDataList.add(task);

    allTask.add(task.task);
    allDate.add(task.date);
    allTime.add(task.time);
    allIsDone.add((task.isDone) ? "true" : "false");

    setData();
  }

  removeTask({required int index}) {
    initData();
    // _allTaskDataList.removeAt(index);

    allTask.removeAt(index);
    allDate.removeAt(index);
    allTime.removeAt(index);

    setData();
  }

  editTask({required Task task, required int index}) {
    initData();
    // _allTaskDataList[index] = task;

    allTask[index] = task.task;
    allDate[index] = task.date;
    allTime[index] = task.time;

    setData();
  }

  doneTask({required int index}) {
    initData();
    _allTaskDataList[index].isDone = !_allTaskDataList[index].isDone;

    // allIsDone[index] = "true";
    if (allIsDone[index] == "true") {
      allIsDone[index] = "false";
    } else {
      allIsDone[index] = "true";
    }
    // if (allIsDone[index] == "false") {
    //   allIsDone[index] = "true";
    // }

    setData();
    // notifyListeners();
  }
}
