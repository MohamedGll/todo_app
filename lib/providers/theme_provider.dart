import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  changeTheme(ThemeMode themeMode) async {
    appTheme = themeMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', appTheme == ThemeMode.dark);
    notifyListeners();
  }
}
