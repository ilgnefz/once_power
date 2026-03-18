import 'package:flutter/material.dart';
import 'package:once_power/config/theme/button.dart';
import 'package:once_power/config/theme/dropdown.dart';
import 'package:once_power/const/color.dart';

import 'bottom_text.dart';
import 'chip.dart';
import 'context_menu.dart';
import 'directive.dart';
import 'icon_box.dart';
import 'table.dart';
import 'theme.dart';
import 'title_bar.dart';

TextStyle _textStyle = TextStyle(fontSize: 14, fontFamily: defaultFont);

// Office Widget Theme
class AppCheckboxTheme {
  static CheckboxThemeData light() => CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? AppColor.primary : null,
    ),
    side: BorderSide(width: 1, color: Colors.black),
  );

  static CheckboxThemeData dark() => CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? AppColor.primaryDark : null,
    ),
    side: BorderSide(width: 1, color: Colors.white),
  );
}

class AppElevatedButtonTheme {
  static ElevatedButtonThemeData light() => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.button,
      textStyle: _textStyle.copyWith(color: AppColor.primary),
      enabledMouseCursor: SystemMouseCursors.click,
      padding: .symmetric(horizontal: 23),
    ),
  );

  static ElevatedButtonThemeData dark() => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.buttonDark,
      textStyle: _textStyle.copyWith(color: AppColor.primaryDark),
      enabledMouseCursor: SystemMouseCursors.click,
      padding: .symmetric(horizontal: 23),
    ),
  );
}

class AppIconTheme {
  static IconThemeData light() => IconThemeData(color: AppColor.icon);

  static IconThemeData dark() => IconThemeData(color: AppColor.iconDark);
}

class AppInputTheme {
  static InputDecorationTheme light() => InputDecorationTheme(
    fillColor: AppColor.input,
    hintStyle: _textStyle.copyWith(color: AppColor.inputHint),
    outlineBorder: BorderSide(color: AppColor.inputBorder, width: 1),
  );

  static InputDecorationTheme dark() => InputDecorationTheme(
    fillColor: AppColor.inputDark,
    hintStyle: _textStyle.copyWith(color: AppColor.inputHintDark),
    outlineBorder: BorderSide(color: AppColor.inputBorderDark, width: 0),
  );
}

class AppTabBarTheme {
  static TabBarThemeData light() => TabBarThemeData(
    labelStyle: _textStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: AppColor.primary,
    ),
    unselectedLabelStyle: _textStyle.copyWith(color: AppColor.text),
  );

  static TabBarThemeData dark() => TabBarThemeData(
    labelStyle: _textStyle.copyWith(
      fontWeight: FontWeight.bold,
      color: AppColor.primaryDark,
    ),
    unselectedLabelStyle: _textStyle.copyWith(color: AppColor.textDark),
  );
}

class AppTextTheme {
  static TextTheme light() =>
      TextTheme(bodyMedium: _textStyle.copyWith(color: AppColor.text));

  static TextTheme dark() =>
      TextTheme(bodyMedium: _textStyle.copyWith(color: AppColor.textDark));
}

// Custom Widget Theme
class AppBottomTextTheme {
  static BottomTextTheme light() => BottomTextTheme(
    textStyle: _textStyle.copyWith(fontSize: 13, color: AppColor.bottomText),
  );

  static BottomTextTheme dark() => BottomTextTheme(
    textStyle: _textStyle.copyWith(fontSize: 13, color: AppColor.bottomText),
  );
}

class AppCustomButtonTheme {
  static CustomButtonTheme light() => CustomButtonTheme(
    textStyle: _textStyle.copyWith(color: AppColor.primary),
    backgroundColor: AppColor.button,
  );

  static CustomButtonTheme dark() => CustomButtonTheme(
    textStyle: _textStyle.copyWith(color: AppColor.primaryDark),
    backgroundColor: AppColor.buttonDark,
  );
}

class AppContextMenuTheme {
  static ContextMenuTheme light() =>
      ContextMenuTheme(backgroundColor: AppColor.contextMenu);

  static ContextMenuTheme dark() =>
      ContextMenuTheme(backgroundColor: AppColor.contextMenuDark);
}

class AppDirectiveTheme {
  static DirectiveTheme light() => DirectiveTheme(
    defaultColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColor.text;
      return Colors.grey;
    }),
    heightLight: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColor.primary;
      return Colors.grey;
    }),
  );

  static DirectiveTheme dark() => DirectiveTheme(
    defaultColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColor.textDark;
      return Colors.grey;
    }),
    heightLight: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) return AppColor.primaryDark;
      return Colors.grey;
    }),
  );
}

class AppDropdownTheme {
  static DropdownTheme light() => DropdownTheme(
    textStyle: _textStyle.copyWith(color: AppColor.text),
    menuBackgroundColor: AppColor.dropdown,
    backgroundColor: AppColor.dropdownBackground,
  );

  static DropdownTheme dark() => DropdownTheme(
    textStyle: _textStyle.copyWith(color: AppColor.textDark),
    menuBackgroundColor: AppColor.dropdownDark,
    backgroundColor: AppColor.dropdownBackgroundDark,
  );
}

class AppIconBoxTheme {
  static IconBoxTheme light() => IconBoxTheme(
    backgroundColor: AppColor.iconBox,
    iconColor: AppColor.iconBoxIcon,
  );

  static IconBoxTheme dark() => IconBoxTheme(
    backgroundColor: AppColor.iconBoxDark,
    iconColor: AppColor.iconBoxIconDark,
  );
}

class AppEasyChipTheme {
  static EasyChipTheme light() => EasyChipTheme(
    textStyle: _textStyle.copyWith(color: AppColor.easyChipText),
    selectTextStyle: _textStyle.copyWith(color: AppColor.background),
    backgroundColor: AppColor.easyChip,
    selectBackgroundColor: AppColor.primary,
  );

  static EasyChipTheme dark() => EasyChipTheme(
    textStyle: _textStyle.copyWith(color: AppColor.easyChipTextDark),
    selectTextStyle: _textStyle.copyWith(color: AppColor.textDark),
    backgroundColor: AppColor.easyChipDark,
    selectBackgroundColor: AppColor.primaryDark,
  );
}

class AppTableTheme {
  static TableTheme light() => TableTheme(
    backgroundColor1: AppColor.background,
    backgroundColor2: AppColor.table,
    textColor: AppColor.text,
  );

  static TableTheme dark() => TableTheme(
    backgroundColor1: AppColor.backgroundDark,
    backgroundColor2: AppColor.tableDark,
    textColor: AppColor.textDark,
  );
}

class AppTitleBarTheme {
  static TitleBarTheme light() => TitleBarTheme(
    textStyle: _textStyle.copyWith(
      fontSize: 13,
      color: AppColor.primary,
      fontWeight: FontWeight.w600,
    ),
    iconColor: AppColor.titleBar,
  );

  static TitleBarTheme dark() => TitleBarTheme(
    textStyle: _textStyle.copyWith(
      fontSize: 13,
      color: AppColor.primaryDark,
      fontWeight: FontWeight.w600,
      fontFamily: defaultFont,
    ),
    iconColor: AppColor.titleBarDark,
  );
}
