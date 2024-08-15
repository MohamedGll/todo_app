import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/my_theme_data.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/views/Auth/login_view.dart';
import 'package:todo_app/views/Auth/register_view.dart';
import 'package:todo_app/views/edit_view.dart';
import 'package:todo_app/views/home_view.dart';
import 'package:todo_app/views/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        startLocale: const Locale('en'),
        saveLocale: true,
        child: TodoApp(),
      ),
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      themeMode: themeProvider.appTheme,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: LoginView.id,
      routes: {
        HomeView.id: (context) => const HomeView(),
        SplashView.id: (context) => const SplashView(),
        EditView.id: (context) => const EditView(),
        LoginView.id: (context) => LoginView(),
        RegisterView.id: (context) => RegisterView(),
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
