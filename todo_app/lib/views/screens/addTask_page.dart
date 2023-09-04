import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/dateTime_controller.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/modal/task_modal.dart';
import 'package:todo_app/utils/color_utils.dart';
import 'package:todo_app/utils/route_utils.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});

  late String todo;
  late DateTime d = DateTime.now();
  late TimeOfDay t = TimeOfDay.now();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: MyColor.theme2,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter task...";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Input new task here",
                        prefixIcon: Icon(
                          Icons.task,
                          size: 24,
                          color: MyColor.theme1,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            width: 2,
                            color: MyColor.theme1,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        todo = value;
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.black38,
                              width: 1.5,
                            ),
                          ),
                          child: Consumer<DateTimeController>(
                              builder: (context, provider, _) {
                            return Column(
                              children: [
                                Text(
                                  "${provider.date.day.toString().padLeft(2, "0")}-${provider.date.month.toString().padLeft(2, "0")}-${provider.date.year}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    DateTime? date = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          provider.date ?? DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(
                                        const Duration(days: 10),
                                      ),
                                    );

                                    if (date != null) {
                                      provider.dateChanged(dateTime: date);
                                      d = date;
                                    }
                                  },
                                  icon: const Icon(Icons.date_range),
                                  label: const Text("Select Date"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColor.theme1,
                                    foregroundColor: Colors.white,
                                    shape: const BeveledRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.black38,
                              width: 1.5,
                            ),
                          ),
                          child: Consumer<DateTimeController>(
                              builder: (context, provider, _) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${(provider.time.hour == 0) ? 12 : (provider.time.hour > 12) ? (provider.time.hour % 12).toString().padLeft(2, "0") : provider.time.hour.toString().padLeft(2, "0")}:${provider.time.minute.toString().padLeft(2, "0")}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      (provider.time.hour >= 12) ? "PM" : "AM",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    TimeOfDay? time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay(
                                        hour: provider.time.hour,
                                        minute: provider.time.minute,
                                      ),
                                    );

                                    if (time != null) {
                                      provider.timeChanged(timeOfDay: time);
                                      t = time;
                                    }
                                  },
                                  icon: const Icon(Icons.timer),
                                  label: const Text("Select Time"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColor.theme1,
                                    foregroundColor: Colors.white,
                                    shape: const BeveledRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                bool isValidated = formKey.currentState!.validate();

                if (isValidated) {
                  Task task = Task(
                    task: todo,
                    date: d,
                    time: t,
                    isDone: false,
                  );

                  Provider.of<TaskController>(context, listen: false)
                      .addTask(task: task);

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Task Add Successfully"),
                      backgroundColor: MyColor.theme1,
                    ),
                  );
                }
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: MyColor.theme1,
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Add Task",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
