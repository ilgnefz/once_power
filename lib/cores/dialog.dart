import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/views/action_bar/advance/dialog/add.dart';
import 'package:once_power/views/action_bar/advance/dialog/add_preset.dart';
import 'package:once_power/views/action_bar/advance/dialog/delete.dart';
import 'package:once_power/views/action_bar/advance/dialog/replace.dart';
import 'package:once_power/views/action_bar/rename/show_upload_text.dart';
import 'package:once_power/widgets/content_bar/detail_dialog.dart';
import 'package:once_power/widgets/content_bar/type_detail_panel.dart';

Future<void> showAllType(BuildContext context,
    [bool isPath = false, bool needPop = false]) async {
  if (needPop) Navigator.of(context).pop();
  await showDialog(
    context: context,
    builder: (BuildContext context) =>
        DetailDialog(child: TypeDetailPanel(isPath: isPath)),
  );
}

Future<void> showText(BuildContext context, UploadMarkInfo info) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return DetailDialog(
        padding: EdgeInsets.symmetric(
            horizontal: AppNum.detailDialogP, vertical: AppNum.largeG),
        child: ShowUploadText(info: info),
      );
    },
  );
}

void deleteText(BuildContext context, [AdvanceMenuDelete? menu]) {
  showDialog(context: context, builder: (context) => DeleteView(menu: menu));
}

void addText(BuildContext context, [AdvanceMenuAdd? menu]) {
  showDialog(context: context, builder: (context) => AddView(menu: menu));
}

void replaceText(BuildContext context, [AdvanceMenuReplace? menu]) {
  showDialog(context: context, builder: (context) => ReplaceView(menu: menu));
}

void addPreset(
    BuildContext context, WidgetRef ref, List<AdvanceMenuModel> menus) {
  if (menus.isEmpty) return;
  showDialog(context: context, builder: (context) => AddPreset());
}
