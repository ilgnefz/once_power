import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/type.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/widget/action/folder_input.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/base/text.dart';

class TypeList extends StatefulWidget {
  const TypeList({super.key});

  @override
  State<TypeList> createState() => _TypeListState();
}

class _TypeListState extends State<TypeList> {
  List<RuleType> list = [
    RuleType(
      name: FileType.image.label,
      key: AppKeys.imageFolder,
      listKey: AppKeys.imageFolderList,
    ),
    RuleType(
      name: FileType.video.label,
      key: AppKeys.videoFolder,
      listKey: AppKeys.videoFolderList,
    ),
    RuleType(
      name: FileType.doc.label,
      key: AppKeys.docFolder,
      listKey: AppKeys.docFolderList,
    ),
    RuleType(
      name: FileType.audio.label,
      key: AppKeys.audioFolder,
      listKey: AppKeys.audioFolderList,
    ),
    RuleType(
      name: FileType.folder.label,
      key: AppKeys.folderFolder,
      listKey: AppKeys.folderFolderList,
    ),
    RuleType(
      name: FileType.archive.label,
      key: AppKeys.zipFolder,
      listKey: AppKeys.zipFolderList,
    ),
    RuleType(
      name: FileType.other.label,
      key: AppKeys.otherFolder,
      listKey: AppKeys.otherFolderList,
    ),
  ];

  List<String> origin = [];
  List<List<String>> originList = [];

  @override
  void initState() {
    super.initState();
    for (RuleType type in list) {
      String cache = StorageUtil.getString(type.key) ?? '';
      List<String> caches = StorageUtil.getStringList(type.listKey);
      origin.add(cache);
      originList.add(caches);
    }
  }

  void cancel() {
    for (var i = 0; i < list.length; i++) {
      StorageUtil.setString(list[i].key, origin[i]);
      StorageUtil.setStringList(list[i].listKey, originList[i]);
    }
  }

  Future<void> ok() async {
    RuleTypeValue ruleTypeValue = RuleTypeValue(
      image: StorageUtil.getString(AppKeys.imageFolder) ?? '',
      video: StorageUtil.getString(AppKeys.videoFolder) ?? '',
      doc: StorageUtil.getString(AppKeys.docFolder) ?? '',
      audio: StorageUtil.getString(AppKeys.audioFolder) ?? '',
      folder: StorageUtil.getString(AppKeys.folderFolder) ?? '',
      archive: StorageUtil.getString(AppKeys.zipFolder) ?? '',
      other: StorageUtil.getString(AppKeys.otherFolder) ?? '',
    );
    await StorageUtil.setRuleTypeValue(AppKeys.ruleTypeValue, ruleTypeValue);
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.organizeTypeFolder),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppNum.spaceSmall,
        children: List.generate(list.length, (index) {
          RuleType type = list[index];
          return Row(
            spacing: AppNum.spaceMedium,
            children: [
              BaseText('${type.name}:'),
              Expanded(
                child: FolderInput(
                  cacheKey: type.key,
                  cacheListKey: type.listKey,
                  controller: TextEditingController(
                    text: StorageUtil.getString(type.key),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
      onCancel: cancel,
      onOk: ok,
    );
  }
}
