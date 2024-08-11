import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hintStyle,
      required this.hintText,
      required this.style,
      this.controller});
  final TextStyle hintStyle;
  final String hintText;
  final TextStyle style;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: style,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            width: 2,
            color: AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            width: 2,
            color: AppColors.grey,
          ),
        ),
        hintText: hintText,
        hintStyle: hintStyle,
      ),
    );
  }
}
