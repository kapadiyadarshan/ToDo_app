import 'package:flutter/material.dart';

class Task {
  String task;
  DateTime date;
  TimeOfDay time;
  bool isDone;

  Task({
    required this.task,
    required this.date,
    required this.time,
    required this.isDone,
  });
}
