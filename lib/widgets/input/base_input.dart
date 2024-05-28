import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/core/rename.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/click_icon.dart';

class BaseInput extends StatelessWidget {
  const BaseInput({
    super.key,
    this.disable = false,
    this.readOnly = false,
    this.padding,
    this.textStyle,
    this.leading,
    this.controller,
    this.hintText,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    required this.show,
    this.action,
  });

  final bool disable;
  final bool readOnly;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Widget? leading;
  final TextEditingController? controller;
  final String? hintText;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final bool show;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disable,
      child: Container(
        height: AppNum.inputH,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: AppNum.inputP),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 2)
          ],
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 4.0)],
            Expanded(
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                style: textStyle,
                decoration: InputDecoration(
                  hintText: hintText,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
                textAlign: textAlign,
                inputFormatters: inputFormatters,
                focusNode: focusNode,
                onChanged: onChanged,
                onEditingComplete: onEditingComplete,
                onSubmitted: onSubmitted,
              ),
            ),
            if (show) ...[
              const SizedBox(width: 4.0),
              Consumer(
                builder: (context, ref, child) => ClickIcon(
                  icon: Icons.close_rounded,
                  onTap: () async {
                    controller!.clear();
                    if (ref.watch(currentModeProvider) ==
                        FunctionMode.organize) {
                      await StorageUtil.remove(AppKeys.targetFolder);
                    }
                    updateName(ref);
                    updateExtension(ref);
                  },
                ),
              ),
            ],
            if (action != null) ...[const SizedBox(width: 4.0), action!],
          ],
        ),
      ),
    );
  }
}
