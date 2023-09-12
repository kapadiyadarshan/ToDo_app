import 'package:flutter/material.dart';

class Task {
  String task;
  String date;
  String time;
  bool isDone;

  Task({
    required this.task,
    required this.date,
    required this.time,
    required this.isDone,
  });
}
