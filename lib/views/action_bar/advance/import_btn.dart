import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/utils/preset_encryptor.dart';
import 'package:once_power/widgets/action_bar/easy_text_btn.dart';

class ImportBtn extends StatelessWidget {
  const ImportBtn({super.key, required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return EasyTextBtn(
      S.current.importPreset,
      width: AppNum.presetMenuW / 2,
      onTap: () async {
        List<AdvancePreset> list = ref.watch(advancePresetListProvider);
        try {
          final result = await openFile(acceptedTypeGroups: [
            XTypeGroup(
              label: 'OncePower${S.current.preset}',
              extensions: [PresetEncryptor.extension],
            )
          ]);
          if (result == null) return;
          final file = File(result.path);
          final fileBytes = await file.readAsBytes();
          // 调用工具类解密方法
          List<AdvancePreset> value = PresetEncryptor.decryptPresets(fileBytes);
          // 过滤和list中相同的值
          List<AdvancePreset> newPresets = [];
          // 先快速过滤id重复的
          List<String> ids = list.map((e) => e.id).toList();
          for (var preset in value) {
            if (!ids.contains(preset.id)) {
              newPresets.add(preset);
              continue;
            }
            // id重复时才比较整个对象
            var existing = list.firstWhere((p) => p.id == preset.id);
            if (existing.toString() != preset.toString()) {
              newPresets.add(preset.copyWith(id: nanoid(10)));
            }
          }
          if (newPresets.isNotEmpty) {
            ref.read(advancePresetListProvider.notifier).addAll(newPresets);
          }
          showPresetImportNotification(num: value.length);
          debugPrint(value.toString());
        } catch (e) {
          showPresetImportNotification(err: e.toString());
        }
      },
    );
  }
}
