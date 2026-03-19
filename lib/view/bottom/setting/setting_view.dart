import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/view/bottom/setting/rename.dart';
import 'package:once_power/view/bottom/setting/rename_format.dart';
import 'package:once_power/view/bottom/setting/theme.dart';
import 'package:once_power/view/bottom/setting/tip.dart';
import 'package:once_power/view/bottom/setting/window.dart';
import 'package:once_power/widget/base/text.dart';

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
  String prefix = '_', suffix = '';
  int width = 2;

  @override
  void initState() {
    super.initState();
    saveSize = StorageUtil.getBool(AppKeys.saveSize);
    savePosition = StorageUtil.getBool(AppKeys.savePosition);
    autoRename = StorageUtil.getBool(AppKeys.autoRename);
    cancelRename = StorageUtil.getBool(AppKeys.cancelEmptyRename);
    prefix = StorageUtil.getString(AppKeys.autoPrefix) ?? '_';
    width = StorageUtil.getInt(AppKeys.autoWidth) ?? 1;
    suffix = StorageUtil.getString(AppKeys.autoSuffix) ?? '';
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
            padding: .symmetric(vertical: AppNum.padding),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: .center,
              mainAxisSize: .min,
              children: [
                Center(
                  child: BaseText(tr(AppL10n.dialogSetting), fontWeight: .bold),
                ),
                SizedBox(height: AppNum.spaceLarge),
                Flexible(
                  child: SingleChildScrollView(
                    padding: .symmetric(horizontal: AppNum.padding),
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisSize: .min,
                      children: [
                        WindowSetting(
                          saveSize: saveSize,
                          savePosition: savePosition,
                          onSizeChanged: (value) => setState(() {
                            saveSize = value;
                            StorageUtil.setBool(AppKeys.saveSize, saveSize);
                          }),
                          onPositionChanged: (value) => setState(() {
                            savePosition = value;
                            StorageUtil.setBool(
                              AppKeys.savePosition,
                              savePosition,
                            );
                          }),
                        ),
                        SizedBox(height: AppNum.spaceMedium),
                        RenameSetting(
                          cancelRename: cancelRename,
                          autoRename: autoRename,
                          onCancelChanged: (value) => setState(() {
                            cancelRename = value;
                            StorageUtil.setBool(
                              AppKeys.cancelEmptyRename,
                              cancelRename,
                            );
                          }),
                          onAutoChanged: (value) => setState(() {
                            autoRename = value;
                            StorageUtil.setBool(AppKeys.autoRename, autoRename);
                          }),
                        ),
                        SizedBox(height: AppNum.spaceSmall),
                        RenameFormat(
                          prefix: prefix,
                          width: width,
                          suffix: suffix,
                          onPrefixChanged: (value) => setState(() {
                            prefix = value;
                            StorageUtil.setString(AppKeys.autoPrefix, prefix);
                          }),
                          onWidthChanged: (value) => setState(() {
                            width = value;
                            StorageUtil.setInt(AppKeys.autoWidth, width);
                          }),
                          onSuffixChanged: (value) => setState(() {
                            suffix = value;
                            StorageUtil.setString(AppKeys.autoSuffix, suffix);
                          }),
                        ),
                        SizedBox(height: AppNum.spaceMedium),
                        ThemeSetting(),
                        SizedBox(height: AppNum.spaceMedium),
                        SettingTitle(tr(AppL10n.settingHotKey)),
                        TipPanel(),
                      ],
                    ),
                  ),
                ),
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

class SettingTitle extends StatelessWidget {
  const SettingTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BaseText(title, fontSize: 13, color: Colors.grey);
  }
}
