import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/view/bottom/setting/rename_format.dart';
import 'package:once_power/view/bottom/setting/setting_checkbox.dart';
import 'package:once_power/view/bottom/setting/tip.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool saveSize = false;
  bool savePosition = false;
  bool autoRename = false;
  bool cancelRename = false;
  String prefix = '_';
  int width = 2;

  @override
  void initState() {
    super.initState();
    saveSize = StorageUtil.getBool(AppKeys.saveSize);
    savePosition = StorageUtil.getBool(AppKeys.savePosition);
    autoRename = StorageUtil.getBool(AppKeys.autoRename);
    cancelRename = StorageUtil.getBool(AppKeys.cancelRename);
    prefix = StorageUtil.getString(AppKeys.autoPrefix) ?? '_';
    width = StorageUtil.getInt(AppKeys.autoWidth) ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return UnconstrainedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.95,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: theme.scaffoldBackgroundColor,
          child: Container(
            width: AppNum.easyDialog,
            padding: EdgeInsets.all(AppNum.padding),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Center(
                  child: Text(
                    tr(AppL10n.dialogSetting),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SettingCheckbox(
                  label: tr(AppL10n.bottomSaveSize),
                  checked: saveSize,
                  onChanged: (value) => setState(() {
                    saveSize = value;
                    StorageUtil.setBool(AppKeys.saveSize, saveSize);
                  }),
                ),
                SettingCheckbox(
                  label: tr(AppL10n.bottomSavePosition),
                  checked: savePosition,
                  onChanged: (value) => setState(() {
                    savePosition = value;
                    StorageUtil.setBool(AppKeys.savePosition, savePosition);
                  }),
                ),
                SettingCheckbox(
                  label: tr(AppL10n.bottomCancelRename),
                  checked: cancelRename,
                  onChanged: (value) => setState(() {
                    cancelRename = value;
                    StorageUtil.setBool(AppKeys.cancelRename, cancelRename);
                  }),
                ),
                SettingCheckbox(
                  label: tr(AppL10n.bottomAutoRename),
                  checked: autoRename,
                  onChanged: (value) => setState(() {
                    autoRename = value;
                    StorageUtil.setBool(AppKeys.autoRename, autoRename);
                  }),
                ),
                SizedBox(height: AppNum.spaceSmall),
                RenameFormat(
                  prefix: prefix,
                  width: width,
                  onPrefixChanged: (value) => setState(() {
                    prefix = value;
                    StorageUtil.setString(AppKeys.autoPrefix, prefix);
                  }),
                  onWidthChanged: (value) => setState(() {
                    width = value;
                    StorageUtil.setInt(AppKeys.autoWidth, width);
                  }),
                ),
                SizedBox(height: AppNum.spaceMedium),
                TipPanel(),
                SizedBox(height: AppNum.spaceLarge),
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  style: ButtonStyle(
                    fixedSize: .all(Size(AppNum.easyDialog - 24, 32)),
                  ),
                  child: Text(tr(AppL10n.dialogClose)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
