import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/base/input.dart';
import 'package:once_power/widget/common/click_icon.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    this.controller,
    this.text,
    required this.hintText,
    this.action,
    this.obscureText = false,
    this.onChange,
    this.onComplete,
  });

  final TextEditingController? controller;
  final String? text;
  final String hintText;
  final Widget? action;
  final bool obscureText;
  final void Function(String)? onChange;
  final void Function(String)? onComplete;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late TextEditingController controller;
  late FocusNode focusNode;
  bool isShow = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: widget.text);
    isShow = controller.text.isNotEmpty;
    controller.addListener(_onControllerChange);
    focusNode = FocusNode()
      ..addListener(() {
        if (!focusNode.hasFocus) widget.onComplete?.call(controller.text);
      });
  }

  void _onControllerChange() {
    if (mounted) {
      isShow = controller.text.isNotEmpty;
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onControllerChange);
    if (widget.controller == null) controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void clear() {
    controller.clear();
    widget.onChange?.call('');
    widget.onComplete?.call('');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      padding: EdgeInsets.only(
        left: AppNum.spaceMedium,
        right: AppNum.spaceSmall,
      ),
      focusNode: focusNode,
      controller: controller,
      hintText: widget.hintText,
      obscureText: widget.obscureText,
      clearButton: isShow
          ? ClickIcon(onPressed: clear, icon: Icons.close_rounded, iconSize: 18)
          : null,
      action: widget.action,
      onChange: widget.onChange,
    );
  }
}
