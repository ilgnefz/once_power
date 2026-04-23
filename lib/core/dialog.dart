import 'package:flutter/material.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/advance_add.dart';
import 'package:once_power/model/advance_delete.dart';
import 'package:once_power/model/advance_replace.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/rule.dart';
import 'package:once_power/view/action/advance/dialog/add.dart';
import 'package:once_power/view/action/advance/dialog/add_key_input.dart';
import 'package:once_power/view/action/advance/dialog/delete.dart';
import 'package:once_power/view/action/advance/dialog/replace.dart';
import 'package:once_power/view/action/advance/group/auto.dart';
import 'package:once_power/view/action/advance/group/rule.dart';
import 'package:once_power/view/action/advance/group/edit.dart';
import 'package:once_power/view/action/advance/preset/add.dart';
import 'package:once_power/view/action/advance/preset/export.dart';
import 'package:once_power/view/action/normal/upload_text.dart';
import 'package:once_power/view/action/organize/dialog/group.dart';
import 'package:once_power/view/action/organize/dialog/type.dart';
import 'package:once_power/view/bottom/setting/setting_view.dart';
import 'package:once_power/view/content/grid/preview/preview.dart';
import 'package:once_power/view/content/top/export_file.dart';
import 'package:once_power/view/content/top/image_size.dart';
import 'package:once_power/view/content/top/rule.dart';
import 'package:once_power/view/content/top/type_detail.dart';
import 'package:once_power/widget/common/animated_dialog.dart';

Future<void> showMarkText(BuildContext context, UploadMarkInfo info) async {
  await AnimatedDialog.show(
    context: context,
    child: ShowUploadText(info: info),
  );
}

Future<void> showSettingView(BuildContext context) async {
  await AnimatedDialog.show(context: context, child: SettingView());
}

Future<void> showEditGroup(
  BuildContext context, [
  bool isDirective = false,
  FileInfo? file,
]) async {
  await AnimatedDialog.show(
    context: context,
    child: EditGroup(isDirective: isDirective, file: file),
  );
}

Future<void> showRuleGroup(BuildContext context, FileInfo file) async {
  await AnimatedDialog.show(
    context: context,
    child: RuleGroup(file: file),
  );
}

Future<DateGroupInfo?> showAutoGroup(BuildContext context) async {
  return await AnimatedDialog.show(context: context, child: AutoGroup());
}

Future<void> showAllGroup(BuildContext context) async {
  await AnimatedDialog.show(context: context, child: GroupList());
}

Future<void> showAllTypeRule(BuildContext context) async {
  await AnimatedDialog.show(context: context, child: TypeList());
}

Future<void> showDeleteText(
  BuildContext context, [
  AdvanceMenuDelete? menu,
]) async {
  await AnimatedDialog.show(
    context: context,
    child: DeleteView(menu: menu),
  );
}

Future<void> showAddText(BuildContext context, [AdvanceMenuAdd? menu]) async {
  await AnimatedDialog.show(
    context: context,
    child: AddView(menu: menu),
  );
}

Future<void> showReplaceText(
  BuildContext context, [
  AdvanceMenuReplace? menu,
]) async {
  await AnimatedDialog.show(
    context: context,
    child: ReplaceView(menu: menu),
  );
}

Future<void> showAllTypeDetail(
  BuildContext context, [
  bool isPath = false,
  bool needPop = false,
]) async {
  if (needPop) Navigator.of(context).pop();
  await AnimatedDialog.show(
    context: context,
    child: TypeDetailPanel(isPath: isPath),
  );
}

Future<void> showKeyInput(BuildContext context) async {
  await AnimatedDialog.show(context: context, child: KeyInputView());
}

Future<void> showAddExport(BuildContext context) async {
  await AnimatedDialog.show(context: context, child: AddPresetView());
}

Future<void> showRenamePreset(
  BuildContext context,
  AdvancePreset preset,
) async {
  await AnimatedDialog.show(
    context: context,
    child: AddPresetView(preset: preset),
  );
}

Future<void> showExportPreset(BuildContext context) async {
  await AnimatedDialog.show(context: context, child: ExportPresetView());
}

Future<void> showRuleDetail(BuildContext context) async {
  Navigator.of(context).pop();
  await AnimatedDialog.show(context: context, child: RuleFilter());
}

Future<void> showPreviewView(BuildContext context, FileInfo file) async {
  await AnimatedDialog.show(context: context, child: PreviewView(file));
}

Future<void> showImageSize(BuildContext context) async {
  await AnimatedDialog.show(context: context, child: ImageSizeView());
}

Future<void> showExportMenu(BuildContext context) async {
  await AnimatedDialog.show(context: context, child: ExportFileView());
}
