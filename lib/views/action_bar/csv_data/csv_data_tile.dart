import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/provider/file.dart';

class CsvDataTile extends ConsumerStatefulWidget {
  const CsvDataTile({
    super.key,
    required this.index,
    required this.flag,
    required this.text,
  });

  final int index;
  final String flag;
  final String text;

  @override
  ConsumerState<CsvDataTile> createState() => _CsvDataTileState();
}

class _CsvDataTileState extends ConsumerState<CsvDataTile> {
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
    focusNode.addListener(() {
      if (!focusNode.hasFocus) onChanged(controller.text);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onChanged(String v) {
    v = v.trim();
    ref.read(cSVDataProvider.notifier).updateOne(widget.index, widget.flag, v);
    cSVDataRename(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: UniqueKey(),
      child: InkWell(
        child: Container(
          constraints: BoxConstraints(
            minHeight: AppNum.cSVDataMinH,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          width: double.infinity,
          alignment: Alignment.center,
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            textAlign: TextAlign.center,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
            // onSubmitted: (value) {
            //   print('输入完成');
            // },
            maxLines: null,
            style: const TextStyle(fontSize: 13).useSystemChineseFont(),
            // readOnly: readOnly,
          ),
        ),
      ),
    );
  }
}
