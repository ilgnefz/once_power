import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/csv.dart';
import 'package:once_power/provider/list.dart';

class CsvDataCard extends ConsumerStatefulWidget {
  const CsvDataCard({
    super.key,
    required this.index,
    required this.flag,
    required this.text,
  });

  final int index;
  final String flag;
  final String text;

  @override
  ConsumerState<CsvDataCard> createState() => _CsvDataTileState();
}

class _CsvDataTileState extends ConsumerState<CsvDataCard> {
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
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  void onChanged(String v) {
    v = v.trim();
    ref.read(cSVDataProvider.notifier).updateOne(widget.index, widget.flag, v);
    csvDataRename(ref);
  }

  void onTapOutside(PointerDownEvent event) {
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(minHeight: AppNum.csvData),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        width: double.infinity,
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(isDense: true, border: InputBorder.none),
          onTapOutside: onTapOutside,
          maxLines: null,
          style: TextStyle(fontSize: 13, fontFamily: defaultFont),
          // readOnly: readOnly,
        ),
      ),
    );
  }
}
