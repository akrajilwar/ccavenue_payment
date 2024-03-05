import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

final MaterialColor kPrimaryColor = MaterialColor(
  AppColors.primary.value,
  const <int, Color>{
    50: AppColors.primary,
    100: AppColors.primary,
    200: AppColors.primary,
    300: AppColors.primary,
    400: AppColors.primary,
    500: AppColors.primary,
    600: AppColors.primary,
    700: AppColors.primary,
    800: AppColors.primary,
    900: AppColors.primary,
  },
);

class Themes {
  static ThemeData appThemeLight() {
    return ThemeData(
        primarySwatch: kPrimaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.primary)),
        dividerColor: Colors.transparent,
        appBarTheme:
            AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light));
  }
}
