import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/organize.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class FolderInput extends StatefulWidget {
  const FolderInput({
    super.key,
    this.cacheKey,
    this.cacheListKey,
    this.value = '',
    this.hintText,
    this.controller,
    this.enable,
    this.showClear,
    this.cache = false,
    this.onKeyEvent,
    this.onChanged,
    this.onClear,
    this.onPressed,
  });

  final String? cacheKey;
  final String? cacheListKey;
  final String? value;
  final String? hintText;
  final TextEditingController? controller;
  final bool? enable;
  final bool? showClear;
  final bool cache;
  final void Function(KeyEvent)? onKeyEvent;
  final void Function(String)? onChanged;
  final void Function()? onClear;
  final void Function()? onPressed;

  @override
  State<FolderInput> createState() => _FolderInputState();
}

class _FolderInputState extends State<FolderInput> {
  late final TextEditingController controller;
  FocusNode focusNode = FocusNode();
  bool showClear = false;

  @override
  void initState() {
    super.initState();
    showClear = widget.value != '';
    controller = widget.controller ?? TextEditingController(text: widget.value);
    controller.addListener(() {
      showClear = controller.text != '';
      if (widget.cacheKey != null) {
        StorageUtil.setString(widget.cacheKey!, controller.text);
      }
      setState(() {});
    });
    focusNode.addListener(() {
      if (!focusNode.hasFocus) cacheInputFolder();
    });
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void cacheInputFolder() {
    if (!widget.cache) return;
    String currentFolder = controller.text;
    if (currentFolder == '') return;
    if (widget.cacheListKey == null) return;
    targetFolderCache(currentFolder, widget.cacheListKey!);
  }

  void onKeyEvent(KeyEvent event) {
    if (widget.cacheListKey == null || widget.cacheKey == null) return;
    if (event is! KeyUpEvent) return;
    if (!widget.cache) return;
    String currentFolder = controller.text;
    List<String> list = StorageUtil.getStringList(widget.cacheListKey!);
    if (list.isEmpty) return;
    int index = list.indexOf(currentFolder);
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      if (currentFolder == '') index = 0;
      if (index == 0) {
        controller.text = list[list.length - 1];
      } else {
        controller.text = list[index - 1];
      }
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      if (currentFolder == '') index == list.length - 1;
      if (index == list.length - 1) {
        controller.text = list[0];
      } else {
        controller.text = list[index + 1];
      }
    }
    StorageUtil.setString(widget.cacheKey!, controller.text);
    List<String> res1 = list.sublist(0, index + 1);
    List<String> res2 = list.sublist(index + 1);
    StorageUtil.setStringList(widget.cacheListKey!, [...res1, ...res2]);
    controller.selection = TextSelection.collapsed(
      offset: controller.text.length,
    );
  }

  Future<void> selectTargetFolder() async {
    final String? folder = await getDirectoryPath();
    if (folder != null) {
      controller.text = folder;
      widget.onChanged?.call(folder);
      if (widget.cacheListKey == null) return;
      if (widget.cache) targetFolderCache(folder, widget.cacheListKey!);
    }
  }

  void onClear() async {
    String? folder = controller.text;
    controller.clear();
    widget.onChanged?.call('');
    if (widget.cacheListKey == null) return;
    List<String> list = StorageUtil.getStringList(widget.cacheListKey!);
    if (list.contains(folder)) list.remove(folder);
    await StorageUtil.setStringList(widget.cacheListKey!, list);
  }

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      focusNode: focusNode,
      enable: widget.enable ?? true,
      hintText: widget.hintText ?? tr(AppL10n.organizeTarget),
      controller: controller,
      padding: EdgeInsets.only(
        left: AppNum.paddingMedium,
        right: AppNum.spaceSmall,
      ),
      show: widget.showClear ?? showClear,
      onClear: onClear,
      onChanged: widget.onChanged,
      onKeyEvent: widget.onKeyEvent ?? onKeyEvent,
      trailing: ClickIcon(
        icon: Icons.folder_open_rounded,
        onPressed: widget.onPressed ?? selectTargetFolder,
      ),
    );
  }
}
