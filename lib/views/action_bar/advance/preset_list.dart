import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/utils/preset_encryptor.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_dialog.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class PresetListView extends StatefulWidget {
  const PresetListView({super.key});

  @override
  State<PresetListView> createState() => _PresetListViewState();
}

class _PresetListViewState extends State<PresetListView> {
  List<AdvancePreset> items = [];

  Future<void> exportData() async {
    String extension = PresetEncryptor.extension;
    final FileSaveLocation? savePath = await getSaveLocation(
      acceptedTypeGroups: [
        XTypeGroup(
          label: 'OncePower${S.current.preset}',
          extensions: [extension],
        ),
      ],
      suggestedName: 'OncePower${S.current.preset}.$extension',
    );
    if (savePath != null) {
      try {
        // 调用工具类加密方法
        final fileData = PresetEncryptor.encryptPresets(items);
        final mimeType = PresetEncryptor.mimeType;
        final XFile xFile = XFile.fromData(fileData, mimeType: mimeType);
        await xFile.saveTo(savePath.path);
        showPresetExportNotification(num: items.length);
      } catch (e) {
        showPresetExportNotification(err: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: S.current.exportPresetTitle,
      onOk: items.isEmpty ? null : exportData,
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          List<AdvancePreset> list = ref.watch(advancePresetListProvider);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return EasyCheckbox(
                label: list[index].name,
                checked: items.contains(list[index]),
                onChanged: (v) {
                  setState(() {
                    if (v!) {
                      items.add(list[index]);
                    } else {
                      items.remove(list[index]);
                    }
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
