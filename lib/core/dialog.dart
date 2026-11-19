import 'package:material_ui/material_ui.dart';
import 'package:once_power/view/content/grid/preview/preview.dart';
import 'package:once_power/view/setting/setting.dart';

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
