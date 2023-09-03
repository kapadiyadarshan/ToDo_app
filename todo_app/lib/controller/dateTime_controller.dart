import 'package:flutter/material.dart';

class DateTimeController extends ChangeNotifier {
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  init() {
    DateTime date = DateTime.now();
    TimeOfDay time = TimeOfDay.now();
  }

  dateChanged({required DateTime dateTime}) {
    date = dateTime;
    notifyListeners();
  }

  timeChanged({required TimeOfDay timeOfDay}) {
    time = timeOfDay;
    notifyListeners();
  }
}
