import 'package:flutter/material.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/view/action/advance/dialog/add.dart';
import 'package:once_power/view/action/advance/dialog/add_key_input.dart';
import 'package:once_power/view/action/advance/dialog/delete.dart';
import 'package:once_power/view/action/advance/dialog/replace.dart';
import 'package:once_power/view/action/normal/upload_text.dart';
import 'package:once_power/view/action/organize/dialog/group.dart';
import 'package:once_power/view/action/organize/dialog/type.dart';
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

Future<void> editGroup(BuildContext context, [bool isDirective = false]) async {
  await showDialog(
    context: context,
    // builder: (context) => EditGroup(isDirective: isDirective),
    builder: (context) => SizedBox.expand(),
  );
}

Future<void> autoGroup(BuildContext context, FileInfo file) async {
  await showDialog(
    context: context,
    // builder: (context) => AutoGroup(file: file),
    builder: (context) => SizedBox.shrink(),
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

Future<void> showKeyInput(BuildContext context) async {
  await showDialog(context: context, builder: (context) => KeyInputView());
}
