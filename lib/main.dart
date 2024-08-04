import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/views/home_view.dart';
import 'package:todo_app/views/splash_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      themeMode: themeProvider.appTheme,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.id,
      routes: {
        HomeView.id: (context) => const HomeView(),
        SplashView.id: (context) => const SplashView(),
      },
    );
  }
}
