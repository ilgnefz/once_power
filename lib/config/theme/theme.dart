import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/const/color.dart';
import 'package:once_power/const/num.dart';

import 'set.dart';

String? get defaultFont => Platform.isWindows ? 'Microsoft YaHei' : null;

class ThemeConfig {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: defaultFont,
    brightness: Brightness.light,
    primaryColor: AppColor.primary,
    scaffoldBackgroundColor: AppColor.background,
    dividerColor: AppColor.divider,
    checkboxTheme: AppCheckboxTheme.light(),
    elevatedButtonTheme: AppElevatedButtonTheme.light(),
    iconTheme: AppIconTheme.light(),
    inputDecorationTheme: AppInputTheme.light(),
    sliderTheme: SliderThemeData(
      overlayShape: .noOverlay,
      padding: .symmetric(horizontal: AppNum.spaceLarge),
    ),
    tabBarTheme: AppTabBarTheme.light(),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(mouseCursor: .all(SystemMouseCursors.click)),
    ),
    textTheme: AppTextTheme.light(),
    extensions: [
      AppBottomTextTheme.light(),
      AppCustomButtonTheme.light(),
      AppOverlayWidgetTheme.light(),
      AppDirectiveTheme.light(),
      AppDropdownTheme.light(),
      AppEasyChipTheme.light(),
      AppIconBoxTheme.light(),
      AppTableTheme.light(),
      AppTitleBarTheme.light(),
    ],
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    fontFamily: defaultFont,
    brightness: Brightness.dark,
    primaryColor: AppColor.primaryDark,
    scaffoldBackgroundColor: AppColor.backgroundDark,
    dividerColor: AppColor.dividerDark,
    checkboxTheme: AppCheckboxTheme.dark(),
    elevatedButtonTheme: AppElevatedButtonTheme.dark(),
    iconTheme: AppIconTheme.dark(),
    inputDecorationTheme: AppInputTheme.dark(),
    sliderTheme: SliderThemeData(
      overlayShape: .noOverlay,
      padding: .symmetric(horizontal: AppNum.spaceLarge),
    ),
    tabBarTheme: AppTabBarTheme.dark(),
    textTheme: AppTextTheme.dark(),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(mouseCursor: .all(SystemMouseCursors.click)),
    ),
    extensions: [
      AppBottomTextTheme.dark(),
      AppCustomButtonTheme.dark(),
      AppOverlayWidgetTheme.dark(),
      AppDirectiveTheme.dark(),
      AppDropdownTheme.dark(),
      AppEasyChipTheme.dark(),
      AppIconBoxTheme.dark(),
      AppTableTheme.dark(),
      AppTitleBarTheme.dark(),
    ],
  );
}
