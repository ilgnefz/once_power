import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/widgets/action_bar/easy_btn.dart';

class ShowUploadText extends StatefulWidget {
  const ShowUploadText({super.key, required this.info});

  final UploadMarkInfo info;

  @override
  State<ShowUploadText> createState() => _ShowUploadTextState();
}

class _ShowUploadTextState extends State<ShowUploadText> {
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
    return Column(
      spacing: AppNum.largeG,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(widget.info.name, style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(border: InputBorder.none),
            maxLines: null,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            EasyBtn(S.of(context).exit, onTap: () => Navigator.pop(context)),
            Consumer(
              builder: (context, ref, child) => EasyBtn(
                S.of(context).save,
                onTap: () {
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
              ),
            ),
            // TextButton(onPressed: () {}, child: Text('保存')),
          ],
        ),
      ],
    );
  }
}
