import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/key.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/service/storage.dart';
import 'package:once_power/widget/setting/card.dart';
import 'package:once_power/widget/setting/menu.dart';

class RuleView extends StatefulWidget {
  const RuleView({super.key});

  @override
  State<RuleView> createState() => _RuleViewState();
}

class _RuleViewState extends State<RuleView> {
  /// 「用时读一次」就够的开关：只落盘，不通知别处。
  /// swapLabel 不放这里——它要驱动 action 区，状态统一由 isSwapLabelProvider 持有。
  static const List<String> _storageKeys = [
    AppKeys.addSelf,
    AppKeys.cancelRename,
    AppKeys.autoRename,
  ];

  late final Map<String, bool> _values;

  @override
  void initState() {
    super.initState();
    _values = {
      for (final String key in _storageKeys)
        key: StorageService.getBoolDefault(key),
    };
  }

  void _setBool(String key, bool value) {
    setState(() => _values[key] = value);
    unawaited(StorageService.setBool(key, value));
  }

  /// 本地 state + Storage 的开关，摆放顺序由 build 里的调用顺序决定。
  Widget _storageToggle(String key, String label) => SettingMenu.toggle(
    label: context.tr(label),
    value: _values[key]!,
    onChanged: (bool value) => _setBool(key, value),
  );

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      title: context.tr(AppL10n.rule),
      children: [
        _storageToggle(AppKeys.addSelf, AppL10n.addSelf),
        Consumer(
          builder: (context, ref, _) {
            return SettingMenu.toggle(
              label: context.tr(AppL10n.swapLabel),
              value: ref.watch(isSwapLabelProvider),
              onChanged: (_) => ref.read(isSwapLabelProvider.notifier).toggle(),
            );
          },
        ),
        Consumer(
          builder: (context, ref, _) {
            return SettingMenu.toggle(
              label: context.tr(AppL10n.hiddenUnit),
              value: ref.watch(isHiddenUnitProvider),
              onChanged: (_) =>
                  ref.read(isHiddenUnitProvider.notifier).toggle(),
            );
          },
        ),
        _storageToggle(AppKeys.cancelRename, AppL10n.cancelRename),
        _storageToggle(AppKeys.autoRename, AppL10n.autoRename),
        SettingMenu.toggle(
          label: context.tr(AppL10n.renameFormat),
          value: true,
          onChanged: (bool value) {
            // setState(() => renameFormat = value);
            // unawaited(StorageService.setBool(AppKeys.renameFormat, value));
          },
        ),
      ],
    );
  }
}
