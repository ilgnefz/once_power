import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widget/base/dialog.dart';

class ShowUploadText extends ConsumerStatefulWidget {
  const ShowUploadText({super.key, required this.info});

  final UploadMarkInfo info;

  @override
  ConsumerState<ShowUploadText> createState() => _ShowUploadTextState();
}

class _ShowUploadTextState extends ConsumerState<ShowUploadText> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.text = widget.info.content;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      width: AppNum.detailDialog,
      title: widget.info.name,
      content: Flexible(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          ),
          maxLines: null,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      okText: tr(AppL10n.dialogSave),
      cancelText: tr(AppL10n.dialogExit),
      onOk: () {
        if (controller.text != widget.info.content) {
          if (widget.info.isPrefix) {
            ref
                .read(prefixUploadMarkProvider.notifier)
                .update(
                  UploadMarkInfo(
                    name: widget.info.name,
                    content: controller.text,
                  ),
                );
          } else {
            ref
                .read(suffixUploadMarkProvider.notifier)
                .update(
                  UploadMarkInfo(
                    name: widget.info.name,
                    content: controller.text,
                    isPrefix: false,
                  ),
                );
          }
          normalUpdateName(ref);
        }
      },
    );
  }
}
