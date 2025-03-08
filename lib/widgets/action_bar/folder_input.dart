import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/organize.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:once_power/widgets/common/click_icon.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class FolderInput extends StatefulWidget {
  const FolderInput({
    super.key,
    this.value = '',
    this.hintText,
    this.controller,
    this.enable,
    this.showClear,
    this.onKeyEvent,
    this.onChanged,
    this.onClear,
    this.onTap,
  });

  final String? value;
  final String? hintText;
  final TextEditingController? controller;
  final bool? enable;
  final bool? showClear;
  final void Function(KeyEvent)? onKeyEvent;
  final void Function(String)? onChanged;
  final void Function()? onClear;
  final void Function()? onTap;

  @override
  State<FolderInput> createState() => _FolderInputState();
}

class _FolderInputState extends State<FolderInput> {
  late final TextEditingController controller;
  bool showClear = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController(text: widget.value);
    controller.addListener(() {
      showClear = controller.text != '';
      print('是空的吗？${controller.text.isNotEmpty}');
      print('值是？${controller.text}');
      widget.onChanged?.call(controller.text);
    });
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> selectTargetFolder() async {
    final String? folder = await getDirectoryPath();
    if (folder != null) {
      controller.text = folder;
      widget.onChanged?.call(folder);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppNum.largeG, right: AppNum.mediumG),
      child: BaseInput(
        enable: widget.enable ?? true,
        hintText: widget.hintText ?? S.of(context).targetFolder,
        controller: controller,
        padding: EdgeInsets.only(left: AppNum.inputP, right: AppNum.smallG),
        showClear: widget.showClear ?? showClear,
        onClear: widget.onClear ?? controller.clear,
        onChanged: widget.onChanged ?? widget.onChanged,
        onKeyEvent: widget.onKeyEvent ?? widget.onKeyEvent,
        trailing: TooltipIcon(
          tip: S.of(context).targetFolder,
          icon: Icons.folder_open_rounded,
          // color: Theme.of(context).primaryColor,
          // size: 32,
          // iconSize: 24,
          onTap: widget.onTap ?? selectTargetFolder,
        ),
      ),
    );
  }
}
