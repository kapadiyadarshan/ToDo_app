import 'dart:io';

import 'package:flutter/material.dart';

class PlatformController extends ChangeNotifier {
  bool isiOS = Platform.isIOS;

  changeAndroid() {
    isiOS = false;
    notifyListeners();
  }

  changeiOS() {
    isiOS = true;
    notifyListeners();
  }

  changePlatform() {
    isiOS = !isiOS;
    notifyListeners();
  }
}
