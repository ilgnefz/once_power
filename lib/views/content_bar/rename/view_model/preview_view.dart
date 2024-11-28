import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/core.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/file_info.dart';

import 'preview_image.dart';
import 'preview_video.dart';

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
  List<FileInfo> tempList = [];

  @override
  void initState() {
    super.initState();
    tempList.addAll(widget.files);
    index = tempList.indexOf(widget.file);
    setState(() {});
  }

  void previous() {
    index = index == 0 ? tempList.length - 1 : index - 1;
    setState(() {});
  }

  void next() {
    index = index == tempList.length - 1 ? 0 : index + 1;
    setState(() {});
  }

  void delete() {
    String id = tempList[index].id;
    int currentIndex = index;
    deleteOne(ref, id);
    tempList.remove(tempList[currentIndex]);
    if (tempList.isEmpty) {
      Navigator.pop(context);
      return;
    }
    if (currentIndex == tempList.length) {
      index = 0;
    }
    setState(() {});
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
            tempList[index].type == FileClassify.image
                ? ImagePreview(file: tempList[index].filePath)
                : VideoPreview(
                    file: tempList[index].filePath,
                    key: ValueKey(tempList[index].id),
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
