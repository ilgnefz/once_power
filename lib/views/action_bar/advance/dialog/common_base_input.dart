import 'package:flutter/material.dart';
import 'package:once_power/widgets/common/base_input.dart';

class CommonBaseInput extends StatefulWidget {
  const CommonBaseInput({
    super.key,
    required this.value,
    required this.hintText,
    required this.onChanged,
  });

  final String value;
  final String hintText;
  final void Function(String) onChanged;

  @override
  State<CommonBaseInput> createState() => _CommonBaseInputState();
}

class _CommonBaseInputState extends State<CommonBaseInput> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      controller: controller,
      show: false,
      hintText: widget.hintText,
      onChanged: widget.onChanged,
    );
  }
}
