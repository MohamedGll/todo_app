import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/providers/theme_provider.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  List<String> langs = [
    'english'.tr(),
    'arabic'.tr(),
  ];
  List<String> modes = [
    'light'.tr(),
    'dark'.tr(),
  ];
  String selectedLang = 'English';
  String selectedMode = 'Light';

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

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
        Padding(
          padding: const EdgeInsets.only(left: 22, right: 22),
          child: Text(
            'lang'.tr(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: themeProvider.appTheme == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
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
              color: themeProvider.appTheme == ThemeMode.dark
                  ? AppColors.primaryDark
                  : Colors.white,
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
                  selectedLang.tr(),
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
                  selectedLang = value!.tr();
                  value == langs[0]
                      ? context.setLocale(const Locale('en'))
                      : context.setLocale(const Locale('ar'));
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
        Padding(
          padding: const EdgeInsets.only(left: 22, right: 22),
          child: Text(
            'mode'.tr(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: themeProvider.appTheme == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
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
              color: themeProvider.appTheme == ThemeMode.dark
                  ? AppColors.primaryDark
                  : Colors.white,
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
                  selectedMode.tr(),
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
                  selectedMode = value!.tr();
                  value == 'dark'.tr()
                      ? themeProvider.changeTheme(ThemeMode.dark)
                      : themeProvider.changeTheme(ThemeMode.light);
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
