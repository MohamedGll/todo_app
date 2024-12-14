import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/views/edit_view.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: .44,
        children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(task.id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            icon: Icons.delete,
            label: 'delete'.tr(),
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(
                context,
                EditView.id,
                arguments: task,
              );
            },
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(16),
            icon: Icons.edit,
            label: 'edit'.tr(),
          ),
        ],
      ),
      child: Container(
        height: 115,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: themeProvider.appTheme == ThemeMode.dark
              ? AppColors.primaryDark
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            task.isDone == true
                ? Container(
                    height: 70,
                    width: 4,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  )
                : Container(
                    height: 70,
                    width: 4,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
            const Spacer(
              flex: 1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color:
                        task.isDone == true ? Colors.green : AppColors.primary,
                  ),
                ),
                Text(
                  task.subTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: task.isDone == true ? Colors.green : AppColors.grey,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                // Text(
                //   '10:30 AM',
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w400,
                //     color: themeProvider.appTheme == ThemeMode.dark
                //         ? Colors.white
                //         : Colors.black,
                //   ),
                // ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
            task.isDone == true
                ? const Text(
                    'Done!',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      task.isDone = true;
                      FirebaseFunctions.updateTask(task);
                    },
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
