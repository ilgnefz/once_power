import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/widgets/action_bar/digit_input.dart';
import 'package:once_power/widgets/common/base_input.dart';

class AdvanceDigitInput extends StatefulWidget {
  const AdvanceDigitInput({
    super.key,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  final int value;
  final String label;
  final void Function(String) onChanged;

  @override
  State<AdvanceDigitInput> createState() => _AdvanceDigitInputState();
}

class _AdvanceDigitInputState extends State<AdvanceDigitInput> {
  late TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '${widget.value}${widget.label}');
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
    controller.text = '${num.toString()}${widget.label}';
    widget.onChanged(num.toString());
  }

  void reduce() {
    int num = getNum(controller.text);
    num--;
    editCompleted(num);
  }

  void increment() {
    int num = getNum(controller.text);
    num++;
    editCompleted(num);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BaseInput(
        focusNode: focusNode,
        controller: controller,
        padding: EdgeInsets.zero,
        show: false,
        textAlign: TextAlign.center,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: widget.onChanged,
        leading: OperatorButton('-', onTap: reduce),
        action: OperatorButton('+', start: false, onTap: increment),
      ),
    );
  }
}
