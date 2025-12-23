import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/views/action/advance/dialog/common_dialog.dart';
import 'package:once_power/views/action/advance/dialog/dialog_base_input.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';
import 'package:once_power/widgets/common/digit_input.dart';

class SaveView extends StatefulWidget {
  const SaveView({super.key});

  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  bool saveSize = false;
  bool savePosition = false;
  bool autoRename = false;
  bool cancelRename = false;
  String prefix = '_';
  int digits = 2;

  @override
  void initState() {
    super.initState();
    saveSize = StorageUtil.getBool(AppKeys.saveSize);
    savePosition = StorageUtil.getBool(AppKeys.savePosition);
    autoRename = StorageUtil.getBool(AppKeys.autoRename);
    cancelRename = StorageUtil.getBool(AppKeys.cancelRename);
    prefix = StorageUtil.getString(AppKeys.autoPrefix) ?? '_';
    digits = StorageUtil.getInt(AppKeys.autoDigits) ?? 2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: tr(AppL10n.bottomSave),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EasyCheckbox(
                checked: saveSize,
                onChanged: (v) => setState(() => saveSize = v!),
                label: tr(AppL10n.bottomSaveSize),
              ),
              EasyCheckbox(
                checked: autoRename,
                onChanged: (v) => setState(() => autoRename = v!),
                label: tr(AppL10n.bottomAutoRename),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EasyCheckbox(
                checked: savePosition,
                onChanged: (v) => setState(() => savePosition = v!),
                label: tr(AppL10n.bottomSavePosition),
              ),
              EasyCheckbox(
                checked: cancelRename,
                onChanged: (v) => setState(() => cancelRename = v!),
                label: tr(AppL10n.bottomCancelRename),
              ),
            ],
          ),
          SizedBox(height: AppNum.spaceSmall),
          DialogOption(
            title: '${tr(AppL10n.bottomAutoRenameFormat)}:',
            padding: EdgeInsets.only(
              top: AppNum.spaceSmall,
              left: AppNum.spaceSmall,
              right: AppNum.spaceMedium,
            ),
            spacing: AppNum.spaceMedium,
            children: [
              SizedBox(
                width: 80,
                child: DialogBaseInput(
                  value: prefix,
                  hintText: tr(AppL10n.advanceAddPrefix),
                  onChanged: (value) => setState(() => prefix = value),
                ),
              ),
              SizedBox(
                width: 120,
                child: DigitInput(
                  value: digits,
                  unit: tr(AppL10n.advanceDigits),
                  onChanged: (value) => setState(() => digits = value),
                ),
              ),
            ],
          ),
        ],
      ),
      onOk: () async {
        await StorageUtil.setBool(AppKeys.saveSize, saveSize);
        await StorageUtil.setBool(AppKeys.savePosition, savePosition);
        await StorageUtil.setBool(AppKeys.autoRename, autoRename);
        await StorageUtil.setBool(AppKeys.cancelRename, cancelRename);
        await StorageUtil.setString(AppKeys.autoPrefix, prefix);
        await StorageUtil.setInt(AppKeys.autoDigits, digits);
      },
    );
  }
}
