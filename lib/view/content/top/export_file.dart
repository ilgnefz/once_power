import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/enum/export.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/checkbox.dart';
import 'package:once_power/widget/common/input_field.dart';

class ExportFileView extends ConsumerStatefulWidget {
  const ExportFileView({super.key});

  @override
  ConsumerState<ExportFileView> createState() => _ExportMenuState();
}

class _ExportMenuState extends ConsumerState<ExportFileView> {
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
    return EasyDialog(
      title: tr(AppL10n.contentExportTitle),
      content: Column(
        spacing: 8,
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          InputField(
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
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(height: 1.5),
                    ),
                    const SizedBox(width: 4),
                    ...ExportType.values.map(
                      (e) => Row(
                        children: [
                          Radio(value: e),
                          Text(
                            e.label,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(height: 1.5),
                          ),
                          SizedBox(width: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
            ),
          ],
          suggestedName: fileName,
        );
        if (filePath == null) return;
        String content = '';
        for (var file in files) {
          String a = file.name;
          String b = file.newName == a ? '' : file.newName;
          if (includeExt) {
            a = getFullName(a, file.extension);
            b = b.isEmpty ? '' : getFullName(b, file.newExtension);
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
