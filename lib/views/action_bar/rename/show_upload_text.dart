import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/widgets/action_bar/easy_dialog.dart';

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
      width: AppNum.detailDialogW,
      title: widget.info.name,
      extraContent: Expanded(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(border: InputBorder.none),
          maxLines: null,
        ),
      ),
      okText: S.of(context).save,
      cancelText: S.of(context).exit,
      onOk: () {
        if (controller.text != widget.info.content) {
          if (widget.info.isPrefix) {
            ref.read(prefixUploadMarkProvider.notifier).update(
                  UploadMarkInfo(
                    name: widget.info.name,
                    content: controller.text,
                  ),
                );
          } else {
            ref.read(suffixUploadMarkProvider.notifier).update(
                  UploadMarkInfo(
                    name: widget.info.name,
                    content: controller.text,
                    isPrefix: false,
                  ),
                );
          }
          updateName(ref);
        }
        Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
    );
  }
}
