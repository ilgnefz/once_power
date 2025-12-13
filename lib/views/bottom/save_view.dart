import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/views/action/advance/dialog/common_dialog.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

class SaveView extends StatefulWidget {
  const SaveView({super.key});

  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  bool saveSize = false;
  bool savePosition = false;

  @override
  void initState() {
    super.initState();
    saveSize = StorageUtil.getBool(AppKeys.saveSize);
    savePosition = StorageUtil.getBool(AppKeys.savePosition);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: tr(AppL10n.bottomSave),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyCheckbox(
            checked: saveSize,
            onChanged: (v) => setState(() => saveSize = v!),
            label: tr(AppL10n.bottomSaveSize),
          ),
          EasyCheckbox(
            checked: savePosition,
            onChanged: (v) => setState(() => savePosition = v!),
            label: tr(AppL10n.bottomSavePosition),
          )
        ],
      ),
      onOk: () async {
        await StorageUtil.setBool(AppKeys.saveSize, saveSize);
        await StorageUtil.setBool(AppKeys.savePosition, savePosition);
      },
    );
  }
}
