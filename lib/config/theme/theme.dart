import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/config/theme/button.dart';

import 'bottom_text.dart';
import 'chip.dart';
import 'icon_box.dart';
import 'title_bar.dart';

String? get defaultFont => Platform.isWindows ? 'Microsoft YaHei' : null;

class ThemeConfig {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: defaultFont,
    brightness: Brightness.light,
    primaryColor: Color(0xFF6952A5),
    scaffoldBackgroundColor: Colors.white,
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
    // dropdownMenuTheme: DropdownMenuThemeData(
    //   textStyle: TextStyle(
    //     fontSize: 14,
    //     color: Colors.black,
    //     fontFamily: defaultFont,
    //   ),
    // ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? Color(0xFF6952A5) : null,
      ),
      side: BorderSide(width: 1, color: Colors.black),
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
        iconColor: Color(0xFFC4C4C4),
      ),
      EasyChipTheme(
        textStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF6952A5),
          fontFamily: defaultFont,
        ),
        selectTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: defaultFont,
        ),
        diableTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontFamily: defaultFont,
        ),
        backgroundColor: Color(0xFFF3ECF4),
        selectBackgroundColor: Color(0xFF6952A5),
        disableBackgroundColor: Color(0xFFE4E3E4),
      ),
      BottomTextTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF9E9E9E),
          fontFamily: defaultFont,
        ),
      ),
    ],
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: defaultFont,
    brightness: Brightness.dark,
    primaryColor: Color(0xFF9679E4),
    scaffoldBackgroundColor: Color(0xFF212121),
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
    // dropdownMenuTheme: DropdownMenuThemeData(
    //   textStyle: TextStyle(
    //     fontSize: 14,
    //     color: Colors.white,
    //     fontFamily: defaultFont,
    //   ),
    // ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? Color(0xFF9679E4) : null,
      ),
      side: BorderSide(width: 1, color: Colors.white),
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
          color: Color(0xFF9679E4),
          fontFamily: defaultFont,
        ),
        selectTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontFamily: defaultFont,
        ),
        diableTextStyle: TextStyle(
          fontSize: 14,
          color: Colors.grey,
          fontFamily: defaultFont,
        ),
        backgroundColor: Color(0xFF483E5D),
        selectBackgroundColor: Color(0xFF9679E4),
        disableBackgroundColor: Color(0xFF323232),
      ),
      BottomTextTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF9E9E9E),
          fontFamily: defaultFont,
        ),
      ),
    ],
  );
}
