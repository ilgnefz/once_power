import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/views/action_bar/advance/dialog/add.dart';
import 'package:once_power/views/action_bar/advance/dialog/add_preset.dart';
import 'package:once_power/views/action_bar/advance/dialog/delete.dart';
import 'package:once_power/views/action_bar/advance/dialog/replace.dart';
import 'package:once_power/views/action_bar/advance/export_preset.dart';
import 'package:once_power/views/action_bar/organize/group_list.dart';
import 'package:once_power/views/action_bar/organize/rule_list.dart';
import 'package:once_power/views/action_bar/rename/show_upload_text.dart';
import 'package:once_power/views/content_bar/custom_image_size.dart';
import 'package:once_power/views/content_bar/edit_group.dart';
import 'package:once_power/views/content_bar/grid_view/preview_view.dart';
import 'package:once_power/widgets/content_bar/type_detail_panel.dart';

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

Future<void> showAllType(BuildContext context,
    [bool isPath = false, bool needPop = false]) async {
  if (needPop) Navigator.of(context).pop();
  await showCustomDialog(
    context: context,
    builder: (BuildContext context) => TypeDetailPanel(isPath: isPath),
  );
}

Future<void> showText(BuildContext context, UploadMarkInfo info) async {
  await showCustomDialog(
    context: context,
    builder: (BuildContext context) {
      return ShowUploadText(info: info);
    },
  );
}

void previewView(BuildContext context, List<FileInfo> files, FileInfo file) {
  showCustomDialog(
    context: context,
    builder: (context) => PreviewView(files, file),
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
    BuildContext context, WidgetRef ref, List<AdvanceMenuModel> menus) {
  if (menus.isEmpty) {
    return NotificationInfo(
      type: NotificationType.error,
      title: S.of(context).presetAddErrorTitle,
      message: S.of(context).presetAddError,
      time: 3,
    ).show();
  }
  showCustomDialog(
    context: context,
    builder: (context) => AddPreset(),
  );
}

void renamePreset(BuildContext context, AdvancePreset preset) {
  showCustomDialog(
    context: context,
    builder: (context) => AddPreset(preset: preset),
  );
}

void editGroup(BuildContext context, [bool isDirective = false]) {
  showCustomDialog(
    context: context,
    builder: (context) => EditGroup(isDirective: isDirective),
  );
}

void showAllRule(BuildContext context) {
  showCustomDialog(context: context, builder: (context) => RuleList());
}

void showAllGroup(BuildContext context) {
  showCustomDialog(context: context, builder: (context) => GroupList());
}

Future<void> showImageSize(BuildContext context) async {
  await showCustomDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomImageSize();
    },
  );
}

void exportPreset(BuildContext context) {
  showCustomDialog(
    context: context,
    builder: (context) => ExportPresetView(),
  );
}
