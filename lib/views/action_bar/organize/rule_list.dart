import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/rule_type.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/views/action_bar/advance/dialog/common_dialog.dart';

import '../../../models/file_enum.dart';
import 'rule_card.dart';

class RuleList extends StatefulWidget {
  const RuleList({super.key});

  @override
  State<RuleList> createState() => _RuleListState();
}

class _RuleListState extends State<RuleList> {
  List<RuleType> list = [
    RuleType(
      name: FileClassify.image.label,
      key: AppKeys.imageFolder,
      listKey: AppKeys.imageFolderList,
    ),
    RuleType(
      name: FileClassify.video.label,
      key: AppKeys.videoFolder,
      listKey: AppKeys.videoFolderList,
    ),
    RuleType(
      name: FileClassify.doc.label,
      key: AppKeys.docFolder,
      listKey: AppKeys.docFolderList,
    ),
    RuleType(
      name: FileClassify.audio.label,
      key: AppKeys.audioFolder,
      listKey: AppKeys.audioFolderList,
    ),
    RuleType(
      name: FileClassify.folder.label,
      key: AppKeys.folderFolder,
      listKey: AppKeys.folderFolderList,
    ),
    RuleType(
      name: FileClassify.zip.label,
      key: AppKeys.zipFolder,
      listKey: AppKeys.zipFolderList,
    ),
    RuleType(
      name: FileClassify.other.label,
      key: AppKeys.otherFolder,
      listKey: AppKeys.otherFolderList,
    )
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
    setState(() {});
  }

  void cancel() {
    for (var i = 0; i < list.length; i++) {
      StorageUtil.setString(list[i].key, origin[i]);
      StorageUtil.setStringList(list[i].listKey, originList[i]);
    }
    setState(() {});
  }

  void ok() async {
    RuleTypeValue ruleTypeValue = RuleTypeValue(
      image: StorageUtil.getString(AppKeys.imageFolder) ?? '',
      video: StorageUtil.getString(AppKeys.videoFolder) ?? '',
      doc: StorageUtil.getString(AppKeys.docFolder) ?? '',
      audio: StorageUtil.getString(AppKeys.audioFolder) ?? '',
      folder: StorageUtil.getString(AppKeys.folderFolder) ?? '',
      zip: StorageUtil.getString(AppKeys.zipFolder) ?? '',
      other: StorageUtil.getString(AppKeys.otherFolder) ?? '',
    );
    await StorageUtil.setRuleTypeValue(AppKeys.ruleTypeValue, ruleTypeValue);
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: S.of(context).classifyType,
      onModelTap: cancel,
      onCancel: cancel,
      onOk: ok,
      child: Column(
        children: List.generate(
          list.length,
          (int index) => RuleCard(
            title: list[index].name,
            cacheKey: list[index].key,
            cacheListKey: list[index].listKey,
          ),
        ),
      ),
    );
  }
}
