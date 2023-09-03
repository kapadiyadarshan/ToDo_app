import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/utils/color_utils.dart';
import 'package:todo_app/utils/route_utils.dart';

import '../../modal/task_modal.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  String dropDownValue = "No Category";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoute.SettingPage);
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Consumer<TaskController>(builder: (context, provider, _) {
          return (provider.getAllTask.length == 0)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "asset/images/task.png",
                        scale: 7,
                      ),
                      const Text(
                        "No tasks\nClick + to create your task.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: provider.getAllTask.length,
                  itemBuilder: (context, index) {
                    Task task = provider.getAllTask[index];

                    return Card(
                      child: ListTile(
                        onTap: () {
                          provider.doneTask(
                            index: index,
                          );
                        },
                        leading: Icon(
                          provider.getAllTask[index].isDone
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: MyColor.theme1,
                        ),
                        title: Text(
                          task.task,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${task.date.day}-${task.date.month}-${task.date.year}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              "${(task.time.hour == 0) ? 12 : (task.time.hour > 12) ? (task.time.hour % 12).toString().padLeft(2, "0") : task.time.hour.toString().padLeft(2, "0")}:${task.time.minute.toString().padLeft(2, "0")}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              (task.time.hour >= 12) ? "PM" : "AM",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        trailing: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: MyColor.theme2,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            onPressed: () {
                              provider.removeTask(index: index);
                            },
                            icon: const Icon(Icons.delete_forever_rounded),
                          ),
                        ),
                      ),
                    );
                  });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MyRoute.AddTaskPage);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
