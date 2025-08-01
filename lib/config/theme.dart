import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/config/custom_theme.dart';
import 'package:once_power/constants/colors.dart';
import 'package:once_power/constants/constants.dart';

class ThemeConfig {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      surface: AppColors.surface,
      onSurface: AppColors.onSurface,
      surfaceDim: Colors.black,
      surfaceContainerLow: Color(0xFF666666),
      outline: Colors.black,
      onErrorContainer: Color(0xFF454545),
    ),
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    dividerColor: AppColors.line,
    disabledColor: AppColors.btnDisabled,
    unselectedWidgetColor: Colors.black26,
    extensions: [
      IconBoxTheme(background: AppColors.primary, icon: Colors.white),
      TableTheme(
        background1: Colors.white,
        background2: Color(0xfff5f5f5),
        textColor: Colors.black,
      ),
    ],
    iconTheme: IconThemeData(color: AppColors.icon),
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
      labelSmall: TextStyle(fontSize: 12, color: Colors.black),
    ).useSystemChineseFont(Brightness.light),
    inputDecorationTheme: InputDecorationTheme(
      iconColor: AppColors.unselectIcon,
      fillColor: AppColors.input,
      hintStyle: TextStyle(color: AppColors.hintText),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? AppColors.primary : null,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : Colors.black,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.black.withValues(alpha: .5),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.grey[100],
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? Colors.white : Colors.grey,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : Colors.grey.withValues(alpha: .3),
      ),
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primary
            : Colors.grey.withValues(alpha: .3),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? AppColors.btnDisabled
              : AppColors.surface,
        ),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
      surfaceDim: Colors.white,
      surfaceContainerLow: Color(0xFFDDDDDD),
      outline: Colors.grey,
      onErrorContainer: Color(0xFFD2C8C8),
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    primaryColor: AppColors.primaryDark,
    dividerColor: AppColors.lineDark,
    disabledColor: AppColors.btnDisabledDark,
    unselectedWidgetColor: Color(0xFF56535B),
    extensions: [
      IconBoxTheme(background: AppColors.primaryDark, icon: AppColors.textDark),
      TableTheme(
        background1: AppColors.backgroundDark,
        background2: Color(0xFF333333),
        textColor: Colors.white,
      ),
    ],
    iconTheme: IconThemeData(color: AppColors.iconDark),
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 14, color: Colors.white),
      titleSmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryDark,
      ),
      bodyLarge: TextStyle(fontSize: 14, color: AppColors.textDark),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textDark),
      labelMedium: TextStyle(fontSize: 13, color: AppColors.textDark),
      labelSmall: TextStyle(fontSize: 12, color: AppColors.textDark),
    ).useSystemChineseFont(Brightness.dark),
    inputDecorationTheme: InputDecorationTheme(
      iconColor: AppColors.unselectIconDark,
      fillColor: AppColors.inputDark,
      hintStyle: TextStyle(color: AppColors.hintTextDark),
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primaryDark
            : null,
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primaryDark
            : AppColors.unselectIconDark,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Color(0xFF484749).withValues(alpha: .5),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: Color(0xFF232125),
      surfaceTintColor: Color(0xFF262626),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primaryDark
            : Colors.grey,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primaryDark.withValues(alpha: .3)
            : Colors.grey.withValues(alpha: .3),
      ),
      trackOutlineColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected)
            ? AppColors.primaryDark.withValues(alpha: .3)
            : Colors.grey.withValues(alpha: .3),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.disabled)
              ? AppColors.btnDisabledDark
              : AppColors.surfaceDark,
        ),
      ),
    ),
  );
}
