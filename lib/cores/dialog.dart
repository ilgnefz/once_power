import 'package:flutter/material.dart';
import 'package:once_power/models/file.dart';
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

Future<void> showAllType(
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
