import 'package:material_ui/material_ui.dart';
import 'package:once_power/model/actions.dart';
import 'package:once_power/view/action/advanced/dialog/dialog.dart';
import 'package:once_power/view/content/grid/preview/preview.dart';
import 'package:once_power/view/setting/setting.dart';

void showAdvanceView(BuildContext context, PresetAction action) {
  showDialog(
    context: context,
    builder: (BuildContext _) => AdvanceActionDialog(action),
  );
}

void showPreviewView(BuildContext context, int index) {
  // showDialog(
  //   context: context,
  //   builder: (BuildContext _) => Dialog(
  //     insetPadding: .zero,
  //     backgroundColor: Colors.transparent,
  //     child: PreviewView(index: index),
  //   ),
  // );
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (context) => PreviewView(index: index)),
  );
}

void showSettingView(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext _) => const SettingView(),
  );
}
