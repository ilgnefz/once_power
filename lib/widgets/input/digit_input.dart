import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/widgets/input/base_input.dart';
import 'package:once_power/widgets/custom_tooltip.dart';

class DigitInput extends StatefulWidget {
  const DigitInput({
    super.key,
    required this.controller,
    required this.value,
    required this.label,
    this.length,
    this.callback,
    this.onChanged,
  });

  final TextEditingController controller;
  final int value;
  final String label;
  final int? length;
  final VoidCallback? callback;
  final void Function(String)? onChanged;

  @override
  State<DigitInput> createState() => _DigitInputState();
}

class _DigitInputState extends State<DigitInput> {
  // late TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  late String tip;

  @override
  void initState() {
    super.initState();
    tip = "${widget.value}${widget.label}";
    // controller = TextEditingController(text: '${widget.value}${widget.label}');
    focusNode.addListener(() {
      final text = widget.controller.text;
      if (focusNode.hasFocus) {
        widget.controller.text = text.replaceAll(widget.label, '');
        widget.controller.selection = TextSelection(
            baseOffset: 0, extentOffset: widget.controller.text.length);
      } else {
        widget.controller.text = widget.controller.text.isEmpty
            ? '${widget.value}${widget.label}'
            : "${int.parse(text)}${widget.label}";
        tip = widget.controller.text;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  onSubmitted(value) {
    widget.controller.text = '${int.parse(value)}${widget.label}';
    setState(() {});
  }

  increment() {
    final num = widget.controller.text.replaceAll(widget.label, '');
    widget.controller.text = "${int.parse(num) + 1}${widget.label}";
    widget.callback!();
    setState(() {});
  }

  reduce() {
    final num = widget.controller.text.replaceAll(widget.label, '');
    if (num == "0") return;
    widget.controller.text = "${int.parse(num) - 1}${widget.label}";
    widget.callback!();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomTooltip(
      content: Text(tip),
      child: BaseInput(
        padding: EdgeInsets.zero,
        controller: widget.controller,
        show: false,
        textAlign: TextAlign.center,
        inputFormatters: [
          if (widget.length != null)
            LengthLimitingTextInputFormatter(widget.length),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: widget.onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        leading: OperatorButton('-', onTap: reduce),
        action: OperatorButton('+', start: false, onTap: increment),
      ),
    );
  }
}

class OperatorButton extends StatelessWidget {
  const OperatorButton(
    this.operator, {
    super.key,
    this.start = true,
    required this.onTap,
  });

  final String operator;
  final bool start;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final radius = start
        ? const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          );

    return Material(
      child: Ink(
        decoration: BoxDecoration(borderRadius: radius),
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Container(
            width: 20,
            // height: 32,
            alignment: Alignment.center,
            child: Text(operator, style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
