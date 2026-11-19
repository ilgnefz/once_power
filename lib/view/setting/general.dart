import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/language.dart';
import 'package:once_power/constant/key.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/service/storage.dart';
import 'package:once_power/widget/setting/card.dart';
import 'package:once_power/widget/setting/menu.dart';

class GeneralView extends StatefulWidget {
  const GeneralView({super.key});

  @override
  State<GeneralView> createState() => _GeneralViewState();
}

class _GeneralViewState extends State<GeneralView> {
  /// 通用页的布尔开关：key 是落盘用的键，label 是 l10n 键。
  /// 新增开关只在这里加一行，读初值、渲染、落盘都由下面的循环统一处理。
  static const List<({String key, String label})> _toggles = [
    (key: AppKeys.size, label: AppL10n.size),
    (key: AppKeys.position, label: AppL10n.position),
    (key: AppKeys.maximize, label: AppL10n.maximize),
    (key: AppKeys.autoRun, label: AppL10n.autoRun),
    (key: AppKeys.contextMenu, label: AppL10n.contextMenu),
    (key: AppKeys.sendNotification, label: AppL10n.notification),
  ];

  LanguageType language = .english;
  late final Map<String, bool> _values;

  @override
  void initState() {
    super.initState();
    // 与启动时 EasyLocalization.startLocale 用同一份配置，避免下拉选中项
    // 和界面实际语言不一致（没设置过时下拉跟随系统语言）。
    final String code = LanguageConfig.initialLocale.languageCode;
    language = LanguageType.values.firstWhere(
      (LanguageType e) => e.locale.languageCode == code,
      orElse: () => LanguageType.english,
    );
    _values = {
      for (final ({String key, String label}) item in _toggles)
        item.key: StorageService.getBoolDefault(item.key),
    };
  }

  void _setBool(String key, bool value) {
    setState(() => _values[key] = value);
    unawaited(StorageService.setBool(key, value));
  }

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      title: context.tr(AppL10n.general),
      children: [
        SettingMenu<LanguageType>.dropdown(
          label: context.tr(AppL10n.language),
          value: language,
          items: LanguageType.values.map((LanguageType value) {
            return TextDropdownItem<LanguageType>(value, label: value.label);
          }).toList(),
          onChanged: (LanguageType value) {
            setState(() => language = value);
            context.setLocale(value.locale);
            int index = LanguageType.values.indexOf(value);
            unawaited(StorageService.setInt(AppKeys.language, index));
          },
        ),
        for (final ({String key, String label}) item in _toggles)
          SettingMenu.toggle(
            label: context.tr(item.label),
            value: _values[item.key]!,
            onChanged: (bool value) => _setBool(item.key, value),
          ),
      ],
    );
  }
}
