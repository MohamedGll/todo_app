import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/widgets/task_item.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 70,
              width: double.infinity,
              color: AppColors.primary,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: CalendarTimeline(
                fontSize: 28,
                initialDate: date,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (dateTime) {
                  date = dateTime;
                  setState(() {});
                },
                leftMargin: 20,
                monthColor: themeProvider.appTheme == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                dayColor: themeProvider.appTheme == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                activeDayColor: AppColors.primary,
                activeBackgroundDayColor:
                    themeProvider.appTheme == ThemeMode.dark
                        ? AppColors.primaryDark
                        : Colors.white,
                dotColor: themeProvider.appTheme == ThemeMode.dark
                    ? Colors.white
                    : Colors.black,
                selectableDayPredicate: (date) => date.day != 23,
                locale: currentLocale == const Locale('en') ? 'en' : 'ar',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        StreamBuilder(
          stream: FirebaseFunctions.getTasks(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppColors.primary,
              ));
            }
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    const Text('Something went wrong'),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }
            var tasks = snapshot.data?.docs
                    .map(
                      (doc) => doc.data(),
                    )
                    .toList() ??
                [];
            if (tasks.isEmpty) {
              return const Center(
                child: Text(
                  'No Tasks',
                ),
              );
            }
            return Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 22,
                ),
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: tasks[index],
                  );
                },
                itemCount: tasks.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
