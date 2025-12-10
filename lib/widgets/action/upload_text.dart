import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/widgets/base/easy_dialog.dart';

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
      content: Expanded(
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
