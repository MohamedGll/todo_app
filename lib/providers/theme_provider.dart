import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  changeTheme(ThemeMode themeMode) {
    appTheme = themeMode;
    notifyListeners();
  }
}
