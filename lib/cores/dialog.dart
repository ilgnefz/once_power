import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/views/action/advance/dialog/add.dart';
import 'package:once_power/views/action/advance/dialog/delete.dart';
import 'package:once_power/views/action/advance/dialog/replace.dart';
import 'package:once_power/views/action/advance/preset/add_preset.dart';
import 'package:once_power/views/action/advance/preset/export.dart';
import 'package:once_power/views/action/organize/group_list.dart';
import 'package:once_power/views/action/organize/type_list.dart';
import 'package:once_power/views/bottom/theme_view.dart';
import 'package:once_power/views/content/grid/preview/preview.dart';
import 'package:once_power/views/content/group.dart';
import 'package:once_power/views/content/top/view_size.dart';
import 'package:once_power/widgets/action/upload_text.dart';
import 'package:once_power/widgets/content/type_panel.dart';

Future<T?> showCustomDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  return showDialog<T>(
    context: context,
    builder: builder,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
  );
}

void previewView(BuildContext context, FileInfo file) {
  showCustomDialog(context: context, builder: (context) => PreviewView(file));
}

void editGroup(BuildContext context, [bool isDirective = false]) {
  showCustomDialog(
    context: context,
    builder: (context) => EditGroup(isDirective: isDirective),
  );
}

Future<void> showAllTypeDetail(
  BuildContext context, [
  bool isPath = false,
  bool needPop = false,
]) async {
  if (needPop) Navigator.of(context).pop();
  await showCustomDialog(
    context: context,
    builder: (context) => TypeDetailPanel(isPath: isPath),
  );
}

Future<void> showText(BuildContext context, UploadMarkInfo info) async {
  await showCustomDialog(
    context: context,
    builder: (BuildContext context) => ShowUploadText(info: info),
  );
}

Future<void> showImageSize(BuildContext context) async {
  await showCustomDialog(
    context: context,
    builder: (BuildContext context) => CustomViewSize(),
  );
}

void deleteText(BuildContext context, [AdvanceMenuDelete? menu]) {
  showCustomDialog(
    context: context,
    builder: (context) => DeleteView(menu: menu),
  );
}

void addText(BuildContext context, [AdvanceMenuAdd? menu]) {
  showCustomDialog(
    context: context,
    builder: (context) => AddView(menu: menu),
  );
}

void replaceText(BuildContext context, [AdvanceMenuReplace? menu]) {
  showCustomDialog(
    context: context,
    builder: (context) => ReplaceView(menu: menu),
  );
}

void addPreset(
  BuildContext context,
  WidgetRef ref,
  List<AdvanceMenuModel> menus,
) {
  if (menus.isEmpty) return showPresetEmptyNotification();
  showCustomDialog(context: context, builder: (context) => AddPresetView());
}

void renamePreset(BuildContext context, AdvancePreset preset) {
  showCustomDialog(
    context: context,
    builder: (context) => AddPresetView(preset: preset),
  );
}

void exportPreset(BuildContext context) {
  showCustomDialog(context: context, builder: (context) => ExportPresetView());
}

void showAllGroup(BuildContext context) {
  showCustomDialog(context: context, builder: (context) => GroupList());
}

void showAllTypeRule(BuildContext context) {
  showCustomDialog(context: context, builder: (context) => TypeList());
}

void showThemeView(BuildContext context, [AdvanceMenuAdd? menu]) {
  showCustomDialog(context: context, builder: (context) => ThemeView());
}
