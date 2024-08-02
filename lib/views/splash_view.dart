import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/views/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const String id = 'SplashView';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        Navigator.pushReplacementNamed(context, HomeView.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
        ),
      ),
    );
  }
}
