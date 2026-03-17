import 'package:flutter/material.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/advance_add.dart';
import 'package:once_power/model/advance_delete.dart';
import 'package:once_power/model/advance_replace.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/view/action/advance/dialog/add.dart';
import 'package:once_power/view/action/advance/dialog/add_key_input.dart';
import 'package:once_power/view/action/advance/dialog/delete.dart';
import 'package:once_power/view/action/advance/dialog/replace.dart';
import 'package:once_power/view/action/advance/group/auto.dart';
import 'package:once_power/view/action/advance/group/edit.dart';
import 'package:once_power/view/action/advance/preset/add.dart';
import 'package:once_power/view/action/advance/preset/export.dart';
import 'package:once_power/view/action/normal/upload_text.dart';
import 'package:once_power/view/action/organize/dialog/group.dart';
import 'package:once_power/view/action/organize/dialog/type.dart';
import 'package:once_power/view/bottom/setting_view.dart';
import 'package:once_power/view/content/grid/preview/preview.dart';
import 'package:once_power/view/content/top/export_file.dart';
import 'package:once_power/view/content/top/image_size.dart';
import 'package:once_power/view/content/top/rule.dart';
import 'package:once_power/view/content/top/type_detail.dart';

Future<void> showMarkText(BuildContext context, UploadMarkInfo info) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => ShowUploadText(info: info),
  );
}

Future<void> showSettingView(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => SettingView(),
  );
}

Future<void> editGroup(
  BuildContext context, [
  bool isDirective = false,
  FileInfo? file,
]) async {
  await showDialog(
    context: context,
    builder: (context) => EditGroup(isDirective: isDirective, file: file),
  );
}

Future<void> autoGroup(BuildContext context, FileInfo file) async {
  await showDialog(
    context: context,
    builder: (context) => AutoGroup(file: file),
  );
}

Future<void> showAllGroup(BuildContext context) async {
  await showDialog(context: context, builder: (context) => GroupList());
}

Future<void> showAllTypeRule(BuildContext context) async {
  await showDialog(context: context, builder: (context) => TypeList());
}

Future<void> deleteText(BuildContext context, [AdvanceMenuDelete? menu]) async {
  await showDialog(
    context: context,
    builder: (context) => DeleteView(menu: menu),
  );
}

Future<void> addText(BuildContext context, [AdvanceMenuAdd? menu]) async {
  await showDialog(
    context: context,
    builder: (context) => AddView(menu: menu),
  );
}

Future<void> replaceText(
  BuildContext context, [
  AdvanceMenuReplace? menu,
]) async {
  await showDialog(
    context: context,
    builder: (context) => ReplaceView(menu: menu),
  );
}

Future<void> showAllTypeDetail(
  BuildContext context, [
  bool isPath = false,
  bool needPop = false,
]) async {
  if (needPop) Navigator.of(context).pop();
  await showDialog(
    context: context,
    builder: (context) => TypeDetailPanel(isPath: isPath),
  );
}

Future<void> showKeyInput(BuildContext context) async {
  await showDialog(context: context, builder: (context) => KeyInputView());
}

Future<void> showAddExport(BuildContext context) async {
  await showDialog(context: context, builder: (context) => AddPresetView());
}

Future<void> renamePreset(BuildContext context, AdvancePreset preset) async {
  await showDialog(
    context: context,
    builder: (context) => AddPresetView(preset: preset),
  );
}

Future<void> showExportPreset(BuildContext context) async {
  await showDialog(context: context, builder: (context) => ExportPresetView());
}

Future<void> showRuleDetail(BuildContext context) async {
  Navigator.of(context).pop();
  await showDialog(context: context, builder: (context) => RuleFilter());
}

Future<void> previewView(BuildContext context, FileInfo file) async {
  await showDialog(context: context, builder: (context) => PreviewView(file));
}

Future<void> showImageSize(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) => ImageSizeView(),
  );
}

Future<void> showExportMenu(BuildContext context) async {
  await showDialog(context: context, builder: (context) => ExportFileView());
}
