import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 18,
          ),
          Text(
            'Add new Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeProvider.appTheme == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          CustomTextFormField(
            style: TextStyle(
              color: themeProvider.appTheme == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
            hintText: 'Title',
            hintStyle: TextStyle(
              color: themeProvider.appTheme == ThemeMode.dark
                  ? AppColors.grey
                  : Colors.black,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          CustomTextFormField(
            style: TextStyle(
              color: themeProvider.appTheme == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
            ),
            hintText: 'Description',
            hintStyle: TextStyle(
              color: themeProvider.appTheme == ThemeMode.dark
                  ? AppColors.grey
                  : Colors.black,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Text(
            'Select Time',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: themeProvider.appTheme == ThemeMode.dark
                  ? AppColors.grey
                  : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          InkWell(
            onTap: () {
              selectDateFun();
            },
            child: Text(
              selectedDate.toString().substring(0, 10),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            onPressed: () {},
            child: const Text(
              'Add',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }

  selectDateFun() async {
    DateTime? chosenDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primary,
                onPrimary: Colors.white,
              ),
            ),
            child: child!);
      },
    );
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }
}
