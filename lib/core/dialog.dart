import 'package:flutter/material.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/view/action/normal/upload_text.dart';
import 'package:once_power/view/bottom/setting_view.dart';

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
