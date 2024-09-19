import 'package:flutter/material.dart';
import 'package:once_power/widgets/action_bar/action_menu.dart';
import 'package:once_power/widgets/common/base_input.dart';

class ActionInput extends StatelessWidget {
  const ActionInput({
    super.key,
    this.label,
    required this.disable,
    this.onKeyEvent,
    this.controller,
    required this.hintText,
    required this.show,
    this.action,
    this.focusNode,
    this.onChanged,
    required this.message,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String? label;
  final bool disable;
  final void Function(KeyEvent)? onKeyEvent;
  final TextEditingController? controller;
  final String hintText;
  final bool show;
  final Widget? action;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final String message;
  final String icon;
  final bool selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ActionMenu(
      label: label,
      slot: BaseInput(
        disable: disable,
        onKeyEvent: onKeyEvent,
        controller: controller,
        hintText: hintText,
        show: show,
        action: action,
        focusNode: focusNode,
        onChanged: onChanged,
      ),
      message: message,
      icon: icon,
      selected: selected,
      onTap: onTap,
    );
  }
}
