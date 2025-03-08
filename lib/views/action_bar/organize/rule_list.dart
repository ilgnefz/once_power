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
  String imageValue = '';
  String videoValue = '';
  String docValue = '';
  String audioValue = '';
  String folderValue = '';
  String zipValue = '';
  String otherValue = '';

  @override
  void initState() {
    super.initState();
    RuleTypeValue? ruleTypeValue =
        StorageUtil.getRuleTypeValue(AppKeys.ruleTypeValue);
    if (ruleTypeValue != null) {
      imageValue = ruleTypeValue.image;
      videoValue = ruleTypeValue.video;
      docValue = ruleTypeValue.doc;
      audioValue = ruleTypeValue.audio;
      folderValue = ruleTypeValue.folder;
      zipValue = ruleTypeValue.zip;
      otherValue = ruleTypeValue.other;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: S.of(context).classifyType,
      child: Column(children: [
        RuleCard(
          title: FileClassify.image.label,
          value: imageValue,
          onChanged: (value) {
            imageValue = value;
            setState(() {});
          },
        ),
        RuleCard(
          title: FileClassify.video.label,
          value: videoValue,
          onChanged: (value) {
            videoValue = value;
            setState(() {});
          },
        ),
        RuleCard(
          title: FileClassify.doc.label,
          value: docValue,
          onChanged: (value) {
            docValue = value;
            setState(() {});
          },
        ),
        RuleCard(
          title: FileClassify.audio.label,
          value: audioValue,
          onChanged: (value) {
            audioValue = value;
            setState(() {});
          },
        ),
        RuleCard(
          title: FileClassify.folder.label,
          value: folderValue,
          onChanged: (value) {
            folderValue = value;
            setState(() {});
          },
        ),
        RuleCard(
          title: FileClassify.zip.label,
          value: zipValue,
          onChanged: (value) {
            zipValue = value;
            setState(() {});
          },
        ),
        RuleCard(
          title: FileClassify.other.label,
          value: otherValue,
          onChanged: (value) {
            otherValue = value;
            setState(() {});
          },
        ),
      ]),
      onOk: () async {
        RuleTypeValue ruleTypeValue = RuleTypeValue(
          image: imageValue,
          video: videoValue,
          doc: docValue,
          audio: audioValue,
          folder: folderValue,
          zip: zipValue,
          other: otherValue,
        );
        await StorageUtil.setRuleTypeValue(
            AppKeys.ruleTypeValue, ruleTypeValue);
      },
    );
  }
}
