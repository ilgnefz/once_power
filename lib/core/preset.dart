import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/util/encryptor.dart';
import 'package:once_power/util/notification.dart';

Future<void> importPreset(WidgetRef ref) async {
  List<AdvancePreset> list = ref.watch(advancePresetListProvider);
  try {
    final result = await openFile(
      acceptedTypeGroups: [
        XTypeGroup(
          label: 'OncePower${tr(AppL10n.advancePreset)}',
          extensions: [PresetEncryptor.extension],
        ),
      ],
    );
    if (result == null) return;
    final file = File(result.path);
    final fileContent = await file.readAsString();

    // 检测文件是否为空
    if (fileContent.trim().isEmpty) {
      showPresetImportNotification(err: tr(AppL10n.errImportError1));
      return;
    }

    // 调用工具类解密方法
    List<AdvancePreset> value = PresetEncryptor.decryptPresets(fileContent);

    // 检测解密结果是否为空
    if (value.isEmpty) return;

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
        newPresets.add(preset.copyWith(id: generateId()));
      }
    }
    if (newPresets.isNotEmpty) {
      ref.read(advancePresetListProvider.notifier).addAll(newPresets);
    }
    showPresetImportNotification(num: value.length);
    debugPrint(value.toString());
  } catch (e) {
    // 根据错误类型显示不同的提示
    String errorMsg = e.toString();
    if (errorMsg.contains('Invalid or corrupted pad block') ||
        errorMsg.contains('Bad state') ||
        errorMsg.contains('Invalid character')) {
      showPresetImportNotification(
        err: '${tr(AppL10n.errImportError2)}: 文件可能已被修改或损坏',
      );
    } else if (errorMsg.contains('FormatException')) {
      showPresetImportNotification(
        err: '${tr(AppL10n.errImportError2)}: 文件格式不正确',
      );
    } else {
      showPresetImportNotification(
        err: '${tr(AppL10n.errImportError3)}: $errorMsg',
      );
    }
  }
}

Future<void> exportPreset(WidgetRef ref, List<AdvancePreset> items) async {
  if (items.isEmpty) return;
  String extension = PresetEncryptor.extension;
  final FileSaveLocation? savePath = await getSaveLocation(
    acceptedTypeGroups: [
      XTypeGroup(
        label: 'OncePower${tr(AppL10n.advancePreset)}',
        extensions: [extension],
      ),
    ],
    suggestedName: 'OncePower${tr(AppL10n.advancePreset)}.$extension',
  );
  if (savePath != null) {
    try {
      // 调用工具类加密方法
      final fileData = PresetEncryptor.encryptPresets(items);
      final mimeType = PresetEncryptor.mimeType;
      final XFile xFile = XFile.fromData(
        utf8.encode(fileData),
        mimeType: mimeType,
      );
      await xFile.saveTo(savePath.path);
      showPresetExportNotification(num: items.length);
    } catch (e) {
      showPresetExportNotification(err: e.toString());
    }
  }
}
