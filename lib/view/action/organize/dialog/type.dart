import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/type.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/input_field.dart';

class TypeList extends StatefulWidget {
  const TypeList({super.key});

  @override
  State<TypeList> createState() => _TypeListState();
}

class _TypeListState extends State<TypeList> {
  Map<FileType, String> typeMap = {
    FileType.image: '',
    FileType.video: '',
    FileType.doc: '',
    FileType.audio: '',
    FileType.folder: '',
    FileType.archive: '',
    FileType.other: '',
  };

  @override
  void initState() {
    super.initState();
    RuleTypeValue? ruleTypeValue = StorageUtil.getRuleTypeValue(
      AppKeys.ruleTypeValue,
    );
    if (ruleTypeValue != null) {
      typeMap[FileType.image] = ruleTypeValue.image;
      typeMap[FileType.video] = ruleTypeValue.video;
      typeMap[FileType.doc] = ruleTypeValue.doc;
      typeMap[FileType.audio] = ruleTypeValue.audio;
      typeMap[FileType.folder] = ruleTypeValue.folder;
      typeMap[FileType.archive] = ruleTypeValue.archive;
      typeMap[FileType.other] = ruleTypeValue.other;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.organizeTypeFolder),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppNum.spaceSmall,
        children: List.generate(typeMap.keys.length, (index) {
          FileType type = typeMap.keys.toList()[index];
          return Row(
            spacing: AppNum.spaceMedium,
            children: [
              BaseText('${type.label}:'),
              Expanded(
                child: InputField(
                  key: ValueKey(type.label),
                  text: typeMap[type] ?? '',
                  hintText: tr(AppL10n.organizeTarget),
                  onClear: () => setState(() => typeMap[type] = ''),
                  onChanged: (value) => setState(() => typeMap[type] = value),
                  action: ClickIcon(
                    icon: Icons.folder_open_rounded,
                    onPressed: () async {
                      final String? folder = await getDirectoryPath();
                      if (folder == null || folder.isEmpty) return;
                      setState(() => typeMap[type] = folder);
                    },
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
      onOk: () async {
        RuleTypeValue ruleTypeValue = RuleTypeValue(
          image: typeMap[FileType.image] ?? '',
          video: typeMap[FileType.video] ?? '',
          doc: typeMap[FileType.doc] ?? '',
          audio: typeMap[FileType.audio] ?? '',
          folder: typeMap[FileType.folder] ?? '',
          archive: typeMap[FileType.archive] ?? '',
          other: typeMap[FileType.other] ?? '',
        );
        await StorageUtil.setRuleTypeValue(
          AppKeys.ruleTypeValue,
          ruleTypeValue,
        );
      },
    );
  }
}
