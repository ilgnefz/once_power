import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/widgets/action_bar/operator_btn.dart';
import 'package:once_power/widgets/base/base_input.dart';

class DigitInput extends StatefulWidget {
  const DigitInput({
    super.key,
    required this.value,
    required this.label,
    this.min = 0,
    required this.onChanged,
  });

  final int value;
  final String label;
  final int min;
  final void Function(int) onChanged;

  @override
  State<DigitInput> createState() => _DigitInputState();
}

class _DigitInputState extends State<DigitInput> {
  late TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '${widget.value} ${widget.label}');
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        int num = getNum(controller.text);
        editCompleted(num);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void editCompleted(int num) {
    if (num < widget.min) num = widget.min;
    controller.text = '$num ${widget.label}';
    widget.onChanged(num);
  }

  void reduce() {
    int num = getNum(controller.text);
    num--;
    if (num < widget.min) num = widget.min;
    editCompleted(num);
  }

  void increment() {
    int num = getNum(controller.text);
    num++;
    editCompleted(num);
  }

  void onChanged(String value) {
    int result = int.tryParse(value) ?? widget.min;
    widget.onChanged(result);
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      // focusNode: focusNode,
      controller: controller,
      padding: EdgeInsets.zero,
      textAlign: TextAlign.center,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      leading: OperatorBtn('-', onTap: reduce),
      trailing: OperatorBtn('+', start: false, onTap: increment),
    );
  }
}
