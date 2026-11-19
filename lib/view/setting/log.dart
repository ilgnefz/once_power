import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/key.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/service/storage.dart';
import 'package:once_power/widget/setting/card.dart';
import 'package:once_power/widget/setting/menu.dart';

class LogView extends ConsumerStatefulWidget {
  const LogView({super.key});

  @override
  ConsumerState<LogView> createState() => _LogViewState();
}

class _LogViewState extends ConsumerState<LogView> {
  bool save = false;

  @override
  void initState() {
    super.initState();
    save = StorageService.getBoolDefault(AppKeys.saveLog);
  }

  @override
  Widget build(BuildContext context) {
    return SettingCard(
      title: context.tr(AppL10n.log),
      children: [
        SettingMenu.toggle(
          label: context.tr(AppL10n.saveLog),
          value: save,
          onChanged: (bool value) {
            setState(() => save = value);
            unawaited(StorageService.setBool(AppKeys.saveLog, value));
          },
        ),
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
      ],
    );
  }
}
