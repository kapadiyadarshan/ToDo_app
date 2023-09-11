import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/dateTime_controller.dart';

import '../../controller/task_controller.dart';
import '../../modal/task_modal.dart';

class iOSAddTaskPage extends StatelessWidget {
  iOSAddTaskPage({super.key});

  late String todo;
  late String d;
  late String t;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Add Task"),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 100, 12, 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: CupertinoColors.extraLightBackgroundGray,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: CupertinoTextFormFieldRow(
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  placeholder: "Input new task here",
                  onChanged: (value) {
                    todo = value;
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              //Select date
              Consumer<DateTimeController>(builder: (context, provider, _) {
                return Card(
                  color: CupertinoColors.white,
                  child: CupertinoListTile(
                    padding: const EdgeInsets.all(12),
                    title: const Text(
                      "Date",
                    ),
                    subtitle: Text(
                      "${provider.date.day}-${provider.date.month}-${provider.date.year}",
                      style: const TextStyle(
                        color: CupertinoColors.activeBlue,
                      ),
                    ),
                    leading: const Icon(
                      CupertinoIcons.calendar_circle_fill,
                      size: 44,
                    ),
                    leadingSize: 44,
                    trailing: CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => Container(
                            height: 240,
                            width: double.infinity,
                            color: CupertinoColors.white,
                            child: CupertinoDatePicker(
                              backgroundColor: CupertinoColors.white,
                              // minimumDate: DateTime.now(),
                              maximumDate: DateTime.now().add(
                                const Duration(
                                  days: 15,
                                ),
                              ),
                              initialDateTime: provider.date,
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (DateTime date) {
                                provider.dateChanged(dateTime: date);
                                d = "${DateFormat("MMMd").format(date)}";
                              },
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Select Date",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 12,
              ),
              //select time
              Consumer<DateTimeController>(builder: (context, provider, _) {
                return Card(
                  color: CupertinoColors.white,
                  child: CupertinoListTile(
                    padding: const EdgeInsets.all(12),
                    title: const Text(
                      "Time",
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "${(provider.time.hour == 0) ? 12 : (provider.time.hour > 12) ? (provider.time.hour % 12).toString().padLeft(2, "0") : provider.time.hour.toString().padLeft(2, "0")}:${provider.time.minute.toString().padLeft(2, "0")}",
                          style: const TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          (provider.time.hour >= 12) ? "PM" : "AM",
                          style: const TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ],
                    ),
                    leading: const Icon(
                      CupertinoIcons.clock_solid,
                      size: 44,
                    ),
                    leadingSize: 44,
                    trailing: CupertinoButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => Container(
                            height: 240,
                            width: double.infinity,
                            color: CupertinoColors.white,
                            child: CupertinoDatePicker(
                              backgroundColor: CupertinoColors.white,
                              initialDateTime: provider.date,
                              mode: CupertinoDatePickerMode.time,
                              onDateTimeChanged: (DateTime time) {
                                provider.timeChanged(
                                  timeOfDay: TimeOfDay.fromDateTime(time),
                                );
                                t = "${(time.hour == 0) ? "12" : time.hour % 12}:${time.minute.toString().padLeft(2, "0")}\t${(time.hour >= 12) ? "PM" : "AM"}";
                              },
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        "Select Time",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 12,
              ),
              CupertinoButton.filled(
                child: const Text("Add Task"),
                onPressed: () {
                  Task task = Task(
                    task: todo,
                    date: d,
                    time: t,
                    isDone: "false",
                  );

                  Provider.of<TaskController>(context, listen: false)
                      .addTask(task: task);

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
