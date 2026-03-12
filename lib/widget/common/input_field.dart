import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/base/input.dart';
import 'package:once_power/widget/common/click_icon.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    this.controller,
    this.text,
    required this.hintText,
    this.leading,
    this.action,
    this.obscureText = false,
    this.enabled = true,
    this.inputFormatters,
    this.onChanged,
    this.onComplete,
    this.onClear,
  });

  final TextEditingController? controller;
  final String? text;
  final String hintText;
  final Widget? leading;
  final Widget? action;
  final bool obscureText;
  final bool enabled;
  final List<FilteringTextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onComplete;
  final void Function()? onClear;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
    widget.onClear?.call();
    widget.onChanged?.call('');
    controller.clear();
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
      hintText: widget.enabled ? widget.hintText : tr(AppL10n.renameDisable),
      obscureText: widget.obscureText,
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters,
      clearButton: isShow
          ? ClickIcon(onPressed: clear, icon: Icons.close_rounded, iconSize: 18)
          : null,
      leading: widget.leading,
      action: widget.action,
      onChange: widget.onChanged,
    );
  }
}
