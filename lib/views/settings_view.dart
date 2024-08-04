import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final List<String> langs = [
    'English',
    'Arabic',
  ];
  final List<String> modes = [
    'Light',
    'Dark',
  ];
  String selectedLang = 'English';
  String selectedMode = 'Light';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 70,
          width: double.infinity,
          color: AppColors.primary,
        ),
        const SizedBox(
          height: 32,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 22),
          child: Text(
            'Language',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                dropdownStyleData: const DropdownStyleData(
                  width: 120,
                ),
                isExpanded: true,
                hint: Text(
                  selectedLang,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
                iconStyleData:
                    IconStyleData(iconEnabledColor: AppColors.primary),
                items: langs
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                value: selectedLang,
                onChanged: (String? value) {
                  setState(() {
                    selectedLang = value!;
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 22),
          child: Text(
            'Mode',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                dropdownStyleData: const DropdownStyleData(
                  width: 120,
                ),
                isExpanded: true,
                hint: Text(
                  selectedMode,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
                iconStyleData:
                    IconStyleData(iconEnabledColor: AppColors.primary),
                items: modes
                    .map(
                      (String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                value: selectedMode,
                onChanged: (String? value) {
                  setState(() {
                    selectedMode = value!;
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
