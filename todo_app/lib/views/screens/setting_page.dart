import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/platform_converter.dart';
import 'package:todo_app/controller/theme_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Consumer<PlatformController>(builder: (context, provider, _) {
              return ListTile(
                title: const Text(
                  "Platform",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("Change Platform"),
                leading: const Icon(Icons.android),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: provider.isiOS ? null : Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          provider.changeAndroid();
                        },
                        icon: const Icon(Icons.android),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: provider.isiOS ? Colors.grey.shade300 : null,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          provider.changeiOS();
                        },
                        icon: const Icon(Icons.apple),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Divider(),
            Consumer<ThemeController>(builder: (context, provider, _) {
              return ListTile(
                title: const Text(
                  "Theme",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text("Change Theme"),
                leading: const Icon(Icons.light_mode),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: provider.isDark ? null : Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          provider.changeLightTheme();
                        },
                        icon: const Icon(Icons.light_mode),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: provider.isDark ? Colors.grey.shade300 : null,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          provider.changeDarkTheme();
                        },
                        icon: const Icon(Icons.dark_mode_rounded),
                      ),
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
