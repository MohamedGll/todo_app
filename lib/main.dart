import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/views/edit_view.dart';
import 'package:todo_app/views/home_view.dart';
import 'package:todo_app/views/splash_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  TodoApp({super.key});
  late ThemeProvider themeProvider;
  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    getTheme();
    return MaterialApp(
      themeMode: themeProvider.appTheme,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.id,
      routes: {
        HomeView.id: (context) => const HomeView(),
        SplashView.id: (context) => const SplashView(),
        EditView.id: (context) => const EditView(),
      },
    );
  }

  getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDark = prefs.getBool('isDark');
    if (isDark != null) {
      if (isDark) {
        themeProvider.appTheme = ThemeMode.dark;
      } else {
        themeProvider.appTheme = ThemeMode.light;
      }
      themeProvider.notifyListeners();
    }
  }
}
