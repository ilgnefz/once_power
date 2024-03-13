import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 14, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 14, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
    ).useSystemChineseFont(Brightness.light),
  );
}
