import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/file.dart';

import 'err_image.dart';

class PreviewImageView extends ConsumerStatefulWidget {
  const PreviewImageView(this.files, this.file, {super.key});

  final List<FileInfo> files;
  final FileInfo file;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreviewImageViewState();
}

class _PreviewImageViewState extends ConsumerState<PreviewImageView> {
  List<Shadow> shadow = [
    Shadow(
      color: Colors.black.withOpacity(.4),
      blurRadius: 8,
      offset: Offset.zero,
    )
  ];

  FocusNode focusNode = FocusNode();
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.files.indexOf(widget.file);
    setState(() {});
  }

  void previous() {
    index = index == 0 ? widget.files.length - 1 : index - 1;
    setState(() {});
  }

  void next() {
    index = index == widget.files.length - 1 ? 0 : index + 1;
    setState(() {});
  }

  void delete() {
    String id = widget.files[index].id;
    deleteOne(ref, id);
    if (ref.watch(fileListProvider).isNotEmpty) {
      next();
      setState(() {});
    } else {
      Navigator.pop(context);
    }
  }

  void onKeyEvent(KeyEvent e) {
    if (e is KeyUpEvent) {
      if (e.physicalKey == PhysicalKeyboardKey.arrowLeft ||
          e.physicalKey == PhysicalKeyboardKey.arrowUp) {
        previous();
      } else if (e.physicalKey == PhysicalKeyboardKey.arrowRight ||
          e.physicalKey == PhysicalKeyboardKey.arrowDown) {
        next();
      } else if (e.physicalKey == PhysicalKeyboardKey.delete) {
        delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      onKeyEvent: onKeyEvent,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            InteractiveViewer(
              maxScale: 8,
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Image.file(
                  File(widget.files[index].filePath),
                  fit: BoxFit.scaleDown,
                  cacheHeight: MediaQuery.of(context).size.height.toInt(),
                  errorBuilder: (context, exception, stackTrace) => ErrorImage(
                      isPreview: true, file: widget.files[index].filePath),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: previous,
                  icon: Icon(
                    Icons.keyboard_arrow_left_rounded,
                    size: 48,
                    shadows: shadow,
                  ),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: next,
                  icon: Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 48,
                    shadows: shadow,
                  ),
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
