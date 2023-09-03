import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/platform_converter.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/modal/task_modal.dart';
import 'package:todo_app/utils/route_utils.dart';

class iOSHomePage extends StatelessWidget {
  const iOSHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("To Do List"),
        trailing: Consumer<PlatformController>(
          builder: (context, provider, child) => IconButton(
            onPressed: () {
              Navigator.pushNamed(context, iOSRoute.iOSSettingPage);
            },
            icon: const Icon(
              CupertinoIcons.settings,
              size: 28,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 112, 12, 12),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Consumer<TaskController>(builder: (context, provider, _) {
              return (provider.getAllTask.length == 0)
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "asset/images/iOS_todo.png",
                            scale: 8,
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
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ToDos",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          child: SingleChildScrollView(
                            child: Column(
                              // backgroundColor: Colors.white,
                              children: List.generate(
                                  provider.getAllTask.length, (index) {
                                Task task = provider.getAllTask[index];

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: CupertinoListTile(
                                    backgroundColor: CupertinoColors
                                        .extraLightBackgroundGray,
                                    padding: const EdgeInsets.all(6),
                                    title: Text(
                                      task.task,
                                      style: TextStyle(
                                          fontSize: 20,
                                          decoration: (task.isDone)
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          "${task.date.day}-${task.date.month}-${task.date.year}",
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "${(task.time.hour == 0) ? 12 : (task.time.hour > 12) ? (task.time.hour % 12).toString().padLeft(2, "0") : task.time.hour.toString().padLeft(2, "0")}:${task.time.minute.toString().padLeft(2, "0")}",
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
                                    leading: CupertinoCheckbox(
                                      onChanged: (value) {
                                        provider.doneTask(index: index);
                                      },
                                      value: task.isDone,
                                    ),
                                    trailing: CupertinoButton(
                                      onPressed: () {
                                        provider.removeTask(index: index);
                                      },
                                      child: const Icon(CupertinoIcons.delete),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    );
            }),
            CupertinoButton.filled(
              child: const Text("Add Task"),
              onPressed: () {
                // Provider.of<DateTimeController>(context, listen: false).init();
                Navigator.pushNamed(context, iOSRoute.iOSAddTaskPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
