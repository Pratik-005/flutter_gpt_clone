import 'package:flutter/material.dart';
import 'package:gpt_clone/design/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldBgColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.scaffoldBgColor,
      elevation: 0,
    ),
  );
}
