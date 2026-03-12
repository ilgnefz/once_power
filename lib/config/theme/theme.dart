import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/config/theme/button.dart';

import 'bottom_text.dart';
import 'chip.dart';
import 'directive.dart';
import 'icon_box.dart';
import 'table.dart';
import 'title_bar.dart';

String? get defaultFont => Platform.isWindows ? 'Microsoft YaHei' : null;

class ThemeConfig {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: defaultFont,
    brightness: Brightness.light,
    primaryColor: Color(0xFF6952A5),
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,
    dividerColor: Color(0xFFF5F5F5),
    iconTheme: IconThemeData(color: Color(0xFF9E9E9E)),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      hintStyle: TextStyle(
        color: Color(0xFF9E9E9E),
        fontSize: 14,
        fontFamily: defaultFont,
      ),
      iconColor: Color(0xFFCFCFCF),
      outlineBorder: BorderSide(color: Color(0xFFF1F1F1)),
    ),
    tabBarTheme: TabBarThemeData(
      labelStyle: TextStyle(
        fontSize: 14,
        fontFamily: defaultFont,
        fontWeight: FontWeight.bold,
        color: Color(0xFF6952A5),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontFamily: defaultFont,
        color: Colors.black,
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: defaultFont,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? Color(0xFF6952A5) : null,
      ),
      side: BorderSide(width: 1, color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(mouseCursor: .all(SystemMouseCursors.click)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(mouseCursor: .all(SystemMouseCursors.click)),
    ),
    extensions: [
      TitleBarTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF6952A5),
          fontWeight: FontWeight.w600,
          fontFamily: defaultFont,
        ),
        iconColor: Color(0xFF9E9E9E),
      ),
      CustomButtonTheme(
        textStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF6952A5),
          fontFamily: defaultFont,
        ),
        backgroundColor: Color(0xFFFEF7FF),
      ),
      IconBoxTheme(
        backgroundColor: Color(0xFFF5F5F5),
        iconColor: Color(0xFFA8A8A8),
      ),
      EasyChipTheme(
        textStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFFA8A8A8),
          fontFamily: defaultFont,
        ),
        selectTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: defaultFont,
        ),
        backgroundColor: Color(0xFFF5F5F5),
        selectBackgroundColor: Color(0xFF6952A5),
      ),
      BottomTextTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF9E9E9E),
          fontFamily: defaultFont,
        ),
      ),
      TableTheme(
        backgroundColor1: Colors.white,
        backgroundColor2: Color(0xFFF5F5F5),
        textColor: Colors.black,
      ),
      // TODO: hoverColor 没有被使用
      DirectiveTheme(
        hoverColor: Color(0xFF2F2F32),
        defaultColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.black;
          return Colors.grey;
        }),
        heightLight: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Color(0xFF6952A5);
          return Colors.grey;
        }),
      ),
    ],
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: defaultFont,
    brightness: Brightness.dark,
    primaryColor: Color(0xFF9679E4),
    scaffoldBackgroundColor: Color(0xFF212121),
    canvasColor: Color(0xFF25292D),
    dividerColor: Color(0xFF2E2D2D),
    iconTheme: IconThemeData(color: Color(0xFF9E9E9E)),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Color(0xFF393838),
      hintStyle: TextStyle(
        color: Color(0xFF757575),
        fontSize: 14,
        fontFamily: defaultFont,
      ),
      iconColor: Color(0xFF888787),
      outlineBorder: BorderSide(color: Color(0xFF393838)),
    ),
    tabBarTheme: TabBarThemeData(
      labelStyle: TextStyle(
        fontSize: 14,
        fontFamily: defaultFont,
        fontWeight: FontWeight.bold,
        color: Color(0xFF9679E4),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontFamily: defaultFont,
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: defaultFont,
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? Color(0xFF9679E4) : null,
      ),
      side: BorderSide(width: 1, color: Colors.white),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(mouseCursor: .all(SystemMouseCursors.click)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(mouseCursor: .all(SystemMouseCursors.click)),
    ),
    extensions: [
      TitleBarTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF9679E4),
          fontWeight: FontWeight.w600,
          fontFamily: defaultFont,
        ),
        iconColor: Color(0xFF9E9E9E),
      ),
      CustomButtonTheme(
        textStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF9679E4),
          fontFamily: defaultFont,
        ),
        backgroundColor: Color(0xFF483E5D),
      ),
      IconBoxTheme(
        backgroundColor: Color(0xFF363535),
        iconColor: Color(0xFF888787),
      ),
      EasyChipTheme(
        textStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF888787),
          fontFamily: defaultFont,
        ),
        selectTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: defaultFont,
        ),
        backgroundColor: Color(0xFF363535),
        selectBackgroundColor: Color(0xFF9679E4),
      ),
      BottomTextTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF9E9E9E),
          fontFamily: defaultFont,
        ),
      ),
      TableTheme(
        backgroundColor1: Color(0xFF1E1F22),
        backgroundColor2: Color(0xFF333333),
        textColor: Colors.white,
      ),
      DirectiveTheme(
        hoverColor: Color(0xFF2F2F32),
        defaultColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Colors.white;
          return Colors.grey;
        }),
        heightLight: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return Color(0xFF9679E4);
          return Colors.grey;
        }),
      ),
    ],
  );
}
