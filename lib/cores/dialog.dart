import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/views/action_bar/rename/show_upload_text.dart';
import 'package:once_power/widgets/content_bar/type_detail_panel.dart';

Future<void> showAllType(BuildContext context,
    [bool isPath = false, bool needPop = false]) async {
  if (needPop) Navigator.of(context).pop();
  await showDialog(
    context: context,
    builder: (BuildContext context) => TypeDetailPanel(isPath: isPath),
  );
}

Future<void> showText(BuildContext context, UploadMarkInfo info) async {
  Size size = MediaQuery.of(context).size;
  // print(size);
  // print(size.height * .9);
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return UnconstrainedBox(
        child: Material(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          child: Container(
            width: AppNum.detailDialogW,
            // height: AppNum.detailDialogH + 100,
            height: size.height * .85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(
                horizontal: AppNum.detailDialogP, vertical: AppNum.largeG),
            child: ShowUploadText(info: info),
          ),
        ),
      );
    },
  );
}
