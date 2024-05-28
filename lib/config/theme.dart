import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/colors.dart';

class ThemeConfig {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 14, color: Colors.black),
      titleSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
      bodyLarge: TextStyle(fontSize: 14, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
      labelMedium: TextStyle(fontSize: 13),
    ).useSystemChineseFont(Brightness.light),
  );
}
