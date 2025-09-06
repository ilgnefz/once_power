import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/widgets/action/digit_btn.dart';
import 'package:once_power/widgets/base/base_input.dart';

class DigitInput extends StatefulWidget {
  const DigitInput({
    super.key,
    required this.value,
    required this.unit,
    this.min = 0,
    this.max,
    required this.onChanged,
  });

  final int value;
  final String unit;
  final int min;
  final int? max;
  final void Function(int) onChanged;

  @override
  State<DigitInput> createState() => _DigitInputState();
}

class _DigitInputState extends State<DigitInput> {
  late TextEditingController controller;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '${widget.value} ${widget.unit}');
    controller.addListener(() {
      widget.onChanged(formatToInt(controller.text));
    });
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        controller.text = '${widget.value} ${widget.unit}';
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  void add() {
    int num = formatToInt(controller.text);
    if (widget.max != null && num >= widget.max!) return;
    controller.text = '${num + 1} ${widget.unit}';
    widget.onChanged(num + 1);
  }

  void minus() {
    int num = formatToInt(controller.text);
    if (num <= widget.min) return;
    controller.text = '${num - 1} ${widget.unit}';
    widget.onChanged(num - 1);
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      focusNode: focusNode,
      controller: controller,
      padding: EdgeInsets.zero,
      textAlign: TextAlign.center,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      leading: DigitBtn('-', right: false, onPressed: minus),
      trailing: DigitBtn('+', right: true, onPressed: add),
    );
  }
}
