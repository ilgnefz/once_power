import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/widget/base/input.dart';

class DigitInput extends StatefulWidget {
  const DigitInput({
    super.key,
    this.width,
    required this.value,
    required this.unit,
    this.max,
    required this.onChange,
  });

  final double? width;
  final int value;
  final String unit;
  final int? max;
  final void Function(int) onChange;

  @override
  State<DigitInput> createState() => _DigitInputState();
}

class _DigitInputState extends State<DigitInput> {
  late TextEditingController controller;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '${widget.value} ${widget.unit}');
    focusNode = FocusNode()
      ..addListener(() {
        if (!focusNode.hasFocus) {
          controller.text = '${change()} ${widget.unit}';
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  int change() {
    int currentValue = extractNum(controller.text);
    if (widget.max != null && currentValue > widget.max!) {
      currentValue = widget.max!;
    }
    return currentValue;
  }

  void increment() {
    int currentValue = extractNum(controller.text);
    if (widget.max != null && currentValue >= widget.max!) return;
    controller.text = '${currentValue + 1} ${widget.unit}';
    setState(() {});
    widget.onChange(currentValue + 1);
  }

  void decrement() {
    int currentValue = extractNum(controller.text);
    if (currentValue > 0) {
      final unit = controller.text.replaceAll(RegExp(r'\d+'), '').trim();
      controller.text = '${currentValue - 1} $unit';
      setState(() {});
      widget.onChange(currentValue - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = BaseInput(
      focusNode: focusNode,
      controller: controller,
      padding: EdgeInsets.zero,
      textAlign: TextAlign.center,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      leading: DigitInputButton(isAdd: false, onPressed: decrement),
      action: DigitInputButton(isAdd: true, onPressed: increment),
    );
    return widget.width == null
        ? Expanded(child: child)
        : SizedBox(width: widget.width, child: child);
  }
}

class DigitInputButton extends StatelessWidget {
  const DigitInputButton({
    super.key,
    required this.isAdd,
    required this.onPressed,
  });

  final bool isAdd;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(isAdd ? 0 : 8),
      topRight: Radius.circular(isAdd ? 8 : 0),
      bottomLeft: Radius.circular(isAdd ? 0 : 8),
      bottomRight: Radius.circular(isAdd ? 8 : 0),
    );
    return Material(
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onPressed,
        mouseCursor: SystemMouseCursors.click,
        borderRadius: borderRadius,
        child: Container(
          width: 20,
          height: double.infinity,
          alignment: Alignment.center,
          child: Text(
            isAdd ? '+' : '-',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
