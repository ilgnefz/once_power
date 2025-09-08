import 'dart:io';

import 'package:flutter/material.dart';

import 'theme/custom.dart';

String? get defaultFont => Platform.isWindows ? 'Microsoft YaHei' : null;

class ThemeConfig {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: defaultFont,
    brightness: Brightness.light,
    primaryColor: Color(0xFF6952A5),
    scaffoldBackgroundColor: Colors.white,
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? Color(0xFF6952A5) : null,
      ),
      side: BorderSide(width: 1, color: Colors.black),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.black.withValues(alpha: .5),
    ),
    disabledColor: Color(0xFFE4E3E4),
    dividerColor: Color(0xFFF5F5F5),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontFamily: defaultFont,
      ),
    ),
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
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      surfaceTintColor: Color(0xFFF5F5F5),
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
    extensions: [
      BtnTheme(
        textStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF6952A5),
          fontFamily: defaultFont,
        ),
        backgroundColor: Color(0xFFF3ECF4),
      ),
      BottomTextTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF9E9E9E),
          fontFamily: defaultFont,
        ),
      ),
      DigitTheme(backgroundColor: Color(0xFFF5F5F5)),
      DirectiveTheme(hoverColor: Color(0xFFF2F2F2)),
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
      IconBoxTheme(
        backgroundColor: Color(0xFFF5F5F5),
        iconColor: Color(0xFFC4C4C4),
      ),
      TableTheme(
        backgroundColor1: Colors.white,
        backgroundColor2: Color(0xFFF5F5F5),
        textColor: Colors.black,
      ),
      TitleBarTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF6952A5),
          fontWeight: FontWeight.bold,
          fontFamily: defaultFont,
        ),
        iconColor: Color(0xFF9E9E9E),
      ),
    ],
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: defaultFont,
    brightness: Brightness.dark,
    primaryColor: Color(0xFF9679E4),
    scaffoldBackgroundColor: Color(0xFF212121),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? Color(0xFF9679E4) : null,
      ),
      side: BorderSide(width: 1, color: Colors.white),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.black.withValues(alpha: .5),
    ),
    disabledColor: Color(0xFF323232),
    dividerColor: Color(0xFF2E2D2D),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: defaultFont,
      ),
    ),
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
    popupMenuTheme: PopupMenuThemeData(
      color: Color(0xFF232125),
      surfaceTintColor: Color(0xFF262626),
      textStyle: TextStyle(fontSize: 14, fontFamily: defaultFont),
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
    extensions: [
      BtnTheme(
        textStyle: TextStyle(
          fontSize: 14,
          color: Color(0xFF9679E4),
          fontFamily: defaultFont,
        ),
        backgroundColor: Color(0xFF483E5D),
      ),
      BottomTextTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF9E9E9E),
          fontFamily: defaultFont,
        ),
      ),
      DigitTheme(backgroundColor: Color(0xFF333131)),
      DirectiveTheme(hoverColor: Color(0xFF2F2F32)),
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
      IconBoxTheme(
        backgroundColor: Color(0xFF363535),
        iconColor: Color(0xFF888787),
      ),
      TableTheme(
        backgroundColor1: Color(0xFF1E1F22),
        backgroundColor2: Color(0xFF333333),
        textColor: Colors.white,
      ),
      TitleBarTheme(
        textStyle: TextStyle(
          fontSize: 13,
          color: Color(0xFF9679E4),
          fontWeight: FontWeight.bold,
          fontFamily: defaultFont,
        ),
        iconColor: Color(0xFF9E9E9E),
      ),
    ],
  );
}
