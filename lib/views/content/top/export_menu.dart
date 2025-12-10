import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/enums/export.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/views/action/advance/dialog/common_dialog.dart';
import 'package:once_power/views/action/advance/dialog/dialog_base_input.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

class ExportMenu extends ConsumerStatefulWidget {
  const ExportMenu({super.key});

  @override
  ConsumerState<ExportMenu> createState() => _ExportMenuState();
}

class _ExportMenuState extends ConsumerState<ExportMenu> {
  late TextEditingController controller;
  String fileName = tr(AppL10n.contentExportDefault);
  ExportType type = ExportType.csv;
  bool includeExt = false;
  List<FileInfo> files = [];

  @override
  void initState() {
    super.initState();
    files = ref.read(fileListProvider);
    controller = TextEditingController(text: fileName);
    controller.addListener(() {
      fileName = controller.value.text;
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: tr(AppL10n.contentExportTitle),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DialogBaseInput(
            controller: controller,
            hintText: tr(AppL10n.contentExportHint),
            onChanged: (v) {},
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RadioGroup<ExportType>(
                  groupValue: type,
                  onChanged: (ExportType? v) => setState(() => type = v!),
                  child: Row(
                    children: [
                      Text(
                        '${tr(AppL10n.contentExportType)}:',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(height: 1.5),
                      ),
                      const SizedBox(width: 4),
                      ...ExportType.values.map(
                        (e) => Row(
                          children: [
                            Radio(value: e),
                            Text(
                              e.label,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(height: 1.5),
                            ),
                            SizedBox(width: 12)
                          ],
                        ),
                      ),
                    ],
                  )),
              EasyCheckbox(
                checked: includeExt,
                onChanged: (v) => setState(() => includeExt = v!),
                label: tr(AppL10n.contentExportExt),
              ),
            ],
          ),
        ],
      ),
      onOk: () async {
        fileName = '$fileName.${type.extension}';
        final FileSaveLocation? filePath = await getSaveLocation(
          acceptedTypeGroups: [
            XTypeGroup(
              label: type.label,
              extensions: [type.extension],
              mimeTypes: [type.mimeType],
            )
          ],
          suggestedName: fileName,
        );
        if (filePath == null) return;
        String content = '';
        for (var file in files) {
          String a = file.name;
          String b = file.newName == a ? '' : file.newName;
          if (includeExt) {
            a = getFullName(a, file.ext);
            b = b.isEmpty ? '' : getFullName(b, file.newExt);
          }
          content += '$a, $b\n';
        }
        final XFile xFile = XFile.fromData(
          utf8.encode(content),
          mimeType: type.mimeType,
        );
        await xFile.saveTo(filePath.path);
      },
    );
  }
}
