import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/widgets/task_item.dart';

class TasksView extends StatelessWidget {
  const TasksView({super.key});

  @override
  Widget build(BuildContext context) {
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
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) => print(date),
                leftMargin: 20,
                monthColor: Colors.black,
                dayColor: Colors.black,
                activeDayColor: AppColors.primary,
                activeBackgroundDayColor: Colors.white,
                dotColor: Colors.black,
                selectableDayPredicate: (date) => date.day != 23,
                locale: 'ar',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 32,
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
              height: 22,
            ),
            itemBuilder: (context, index) {
              return const TaskItem();
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
