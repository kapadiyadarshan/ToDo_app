import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool isDark = false;

  changeLightTheme() {
    isDark = false;
    notifyListeners();
  }

  changeDarkTheme() {
    isDark = true;
    notifyListeners();
  }

  changeTheme() {
    isDark = !isDark;
    notifyListeners();
  }
}
