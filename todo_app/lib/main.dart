import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/controller/dateTime_controller.dart';
import 'package:todo_app/controller/platform_converter.dart';
import 'package:todo_app/controller/task_controller.dart';
import 'package:todo_app/controller/theme_controller.dart';
import 'package:todo_app/utils/color_utils.dart';
import 'package:todo_app/utils/route_utils.dart';
import 'package:todo_app/views/screens/addTask_page.dart';
import 'package:todo_app/views/screens/home_page.dart';
import 'package:todo_app/views/screens/iOS_addTask_page.dart';
import 'package:todo_app/views/screens/iOS_home_page.dart';
import 'package:todo_app/views/screens/iOS_setting_page.dart';
import 'package:todo_app/views/screens/setting_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  SharedPreferences preferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlatformController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => DateTimeController(),
        ),
        ChangeNotifierProvider(
          create: (context) => TaskController(preferences: preferences),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<PlatformController>(context).isiOS
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: CupertinoThemeData(
              brightness: Provider.of<ThemeController>(context).isDark
                  ? Brightness.dark
                  : Brightness.light,
            ),
            initialRoute: iOSRoute.iOSHomePage,
            routes: {
              iOSRoute.iOSHomePage: (p0) => const iOSHomePage(),
              iOSRoute.iOSSettingPage: (p0) => const iOSSettingPage(),
              iOSRoute.iOSAddTaskPage: (p0) => iOSAddTaskPage(),
            },
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: MyColor.theme1,
                foregroundColor: Colors.white,
              ),
              appBarTheme: AppBarTheme(
                foregroundColor: Colors.white,
                backgroundColor: MyColor.theme1,
                centerTitle: true,
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: MyColor.theme1,
                foregroundColor: Colors.white,
              ),
              appBarTheme: AppBarTheme(
                foregroundColor: Colors.white,
                backgroundColor: MyColor.theme1,
                centerTitle: true,
                titleTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            themeMode: Provider.of<ThemeController>(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: MyRoute.HomePage,
            routes: {
              MyRoute.HomePage: (context) => HomePage(),
              MyRoute.SettingPage: (context) => const SettingPage(),
              MyRoute.AddTaskPage: (context) => AddTaskPage(),
            },
          );
  }
}
