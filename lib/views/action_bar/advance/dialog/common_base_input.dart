import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/widgets/common/base_input.dart';

class CommonBaseInput extends StatefulWidget {
  const CommonBaseInput({
    super.key,
    required this.value,
    required this.hintText,
    this.inputFormatters,
    required this.onChanged,
  });

  final String value;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String) onChanged;

  @override
  State<CommonBaseInput> createState() => _CommonBaseInputState();
}

class _CommonBaseInputState extends State<CommonBaseInput> {
  late TextEditingController controller;
  bool show = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value)
      ..addListener(() {
        if (controller.text.isNotEmpty) {
          show = true;
        } else {
          show = false;
        }
        setState(() {});
      });
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
      show: show,
      hintText: widget.hintText,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
    );
  }
}
