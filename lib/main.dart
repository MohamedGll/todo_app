import 'package:flutter/material.dart';
import 'package:todo_app/views/home_view.dart';
import 'package:todo_app/views/splash_view.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeView.id,
      routes: {
        HomeView.id: (context) => const HomeView(),
        SplashView.id: (context) => const SplashView(),
      },
    );
  }
}
