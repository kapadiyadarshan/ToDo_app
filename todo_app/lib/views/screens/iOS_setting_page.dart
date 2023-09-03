import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/platform_converter.dart';
import 'package:todo_app/controller/theme_controller.dart';

class iOSSettingPage extends StatelessWidget {
  const iOSSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Settings"),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 100,
          bottom: 12,
          right: 12,
          left: 12,
        ),
        child: Column(
          children: [
            CupertinoListTile(
                title: const Text("Platform"),
                subtitle: const Text("Change Platform"),
                leading: const Icon(Icons.apple),
                trailing: Consumer<PlatformController>(
                    builder: (context, provider, _) {
                  return CupertinoSlidingSegmentedControl(
                    padding: const EdgeInsets.all(4),
                    onValueChanged: (value) {
                      provider.changePlatform();
                    },
                    groupValue: provider.isiOS.toString(),
                    children: const {
                      "false": Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.android),
                      ),
                      "true": Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.apple),
                      ),
                    },
                  );
                })),
            const Divider(
              color: Colors.black12,
            ),
            CupertinoListTile(
              title: const Text("Theme"),
              subtitle: const Text("Change Theme"),
              leading: const Icon(Icons.light_mode),
              trailing:
                  Consumer<ThemeController>(builder: (context, provider, _) {
                return CupertinoSlidingSegmentedControl(
                  padding: const EdgeInsets.all(4),
                  onValueChanged: (value) {
                    provider.changeTheme();
                  },
                  groupValue: provider.isDark.toString(),
                  children: const {
                    "false": Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.light_mode),
                    ),
                    "true": Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.dark_mode),
                    ),
                  },
                );
              }),
            ),
            //     Consumer<ThemeContoller>(builder: (context, provider, _) {
            //   return CupertinoSwitch(
            //     value: provider.isDark,
            //     onChanged: (value) {
            //       provider.changeTheme();
            //     },
            //   );
            // })),
          ],
        ),
      ),
    );
  }
}
