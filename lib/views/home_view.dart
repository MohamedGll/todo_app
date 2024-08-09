import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/views/settings_view.dart';
import 'package:todo_app/views/tasks_view.dart';
import 'package:todo_app/widgets/add_task_bottom_sheet.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const String id = 'HomeView';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  List<Widget> views = [
    const TasksView(),
    SettingsView(),
  ];
  List<String> labels = [
    'todo_list',
    'settings',
  ];

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          labels[selectedIndex].tr(),
        ),
      ),
      body: views.elementAt(selectedIndex),
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        notchMargin: 6,
        // padding: EdgeInsets.zero,
        // shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          // backgroundColor: Colors.transparent,
          // elevation: 0,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey,
          currentIndex: selectedIndex,
          showUnselectedLabels: false,
          iconSize: 28,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
              ),
              label: 'tasks'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.settings,
              ),
              label: 'settings'.tr(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: const AddTaskBottomSheet(),
              );
            },
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(42),
          side: BorderSide(
            color: themeProvider.appTheme == ThemeMode.dark
                ? AppColors.primaryDark
                : Colors.white,
            width: 3,
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
