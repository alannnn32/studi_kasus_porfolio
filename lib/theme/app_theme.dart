import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData buildTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    ),
    scaffoldBackgroundColor:
        dark ? AppColors.darkBackground : AppColors.background,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: dark ? AppColors.darkCard : Colors.white,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: dark ? AppColors.darkCard : Colors.white,
    ),
  );
}