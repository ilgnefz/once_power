import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/rename.dart';
import 'package:once_power/widgets/upload_button.dart';

import 'my_text.dart';

final TextStyle myStyle = const TextStyle(fontSize: 14).useSystemChineseFont();

class SimpleInput extends StatelessWidget {
  const SimpleInput({
    super.key,
    required this.controller,
    this.readOnly = false,
    this.decoration,
    this.hintText,
    required this.hidden,
    this.textStyle,
    this.action,
    required this.onClear,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool hidden;
  final bool readOnly;
  final Decoration? decoration;
  final String? hintText;
  final TextStyle? textStyle;
  final Widget? action;
  final void Function() onClear;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 1)
            ],
          ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: myStyle,
              readOnly: readOnly,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: textStyle ?? myStyle,
                contentPadding: const EdgeInsets.only(left: 8.0),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onChanged,
            ),
          ),
          if (hidden)
            action ?? const SizedBox()
          else
            IconButton(
              splashRadius: 12,
              onPressed: onClear,
              icon: const Icon(Icons.close, size: 16),
            ),
        ],
      ),
    );
  }
}

class LabelSimpleInput extends StatelessWidget {
  const LabelSimpleInput({
    Key? key,
    required this.label,
    required this.controller,
    required this.uploadType,
    required this.provider,
    required this.hidden,
    required this.onChanged,
    this.readOnly = false,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final UploadType uploadType;
  final RenameProvider provider;
  final bool readOnly;
  final bool hidden;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyText('$label:'),
        const SizedBox(width: 8.0),
        Expanded(
          child: SimpleInput(
            controller: controller,
            readOnly: readOnly,
            hidden: hidden,
            onClear: () => provider.clearInput(controller, uploadType),
            onChanged: onChanged,
            action: UploadButton(
                () => provider.uploadContent(controller, uploadType)),
          ),
        ),
      ],
    );
  }
}
