import 'package:flutter/material.dart';
import 'package:once_power/widget/common/input_field.dart';

// TODO: 删除
class DialogInput extends StatelessWidget {
  const DialogInput({
    super.key,
    required this.text,
    required this.hintText,
    required this.onChanged,
  });

  final String text;
  final String hintText;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return InputField(text: text, hintText: hintText, onChanged: onChanged);
  }
}
