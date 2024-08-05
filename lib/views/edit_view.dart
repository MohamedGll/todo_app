import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/widgets/custom_text_form_field.dart';

class EditView extends StatefulWidget {
  const EditView({super.key});
  static const String id = 'EditView';

  @override
  State<EditView> createState() => _EditViewState();
}

class _EditViewState extends State<EditView> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: themeProvider.appTheme == ThemeMode.dark
              ? Colors.black
              : Colors.white,
        ),
        title: const Text(
          'To Do List',
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            color: AppColors.primary,
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  top: 28,
                ),
                child: Container(
                  height: 560,
                  width: 300,
                  decoration: BoxDecoration(
                    color: themeProvider.appTheme == ThemeMode.dark
                        ? AppColors.primaryDark
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Edit Task',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: themeProvider.appTheme == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomTextFormField(
                          style: TextStyle(
                            color: themeProvider.appTheme == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                          hintStyle: TextStyle(
                            color: themeProvider.appTheme == ThemeMode.dark
                                ? AppColors.grey
                                : Colors.black,
                          ),
                          hintText: 'Title',
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CustomTextFormField(
                          style: TextStyle(
                            color: themeProvider.appTheme == ThemeMode.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                          hintStyle: TextStyle(
                            color: themeProvider.appTheme == ThemeMode.dark
                                ? AppColors.grey
                                : Colors.black,
                          ),
                          hintText: 'Description',
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
                        const SizedBox(
                          height: 18,
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
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              fixedSize: const Size(100, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Save Changes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
