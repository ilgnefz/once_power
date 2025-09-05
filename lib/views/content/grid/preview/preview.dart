import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/context_menu.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/list.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/click_icon.dart';

import 'avif.dart';
import 'image.dart';
import 'psd.dart';
import 'svg.dart';
import 'video.dart';

class PreviewView extends ConsumerStatefulWidget {
  const PreviewView(this.file, {super.key});
  final FileInfo file;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreviewImageViewState();
}

class _PreviewImageViewState extends ConsumerState<PreviewView> {
  List<Shadow> shadows = [
    Shadow(
      color: Colors.black.withValues(alpha: .4),
      blurRadius: 8,
      offset: Offset.zero,
    ),
  ];

  FocusNode focusNode = FocusNode();
  int index = 0;
  List<FileInfo> previewList = [];

  @override
  void initState() {
    super.initState();
    previewList.addAll(ref.read(sortListProvider));
    index = previewList.indexOf(widget.file);
    setState(() {});
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  void previous() {
    index = index == 0 ? previewList.length - 1 : index - 1;
    setState(() {});
  }

  void next() {
    index = index == previewList.length - 1 ? 0 : index + 1;
    setState(() {});
  }

  void delete() {
    String id = previewList[index].id;
    int currentIndex = index;
    // removeOne(ref, id);
    previewList.remove(previewList[currentIndex]);
    if (previewList.isEmpty) return Navigator.pop(context);
    if (currentIndex == previewList.length) index = 0;
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
    bool isMax = ref.watch(isMaxProvider);
    final double value = isMax ? 0.0 : 8.0;
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(value),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(value),
          color: Colors.black.withValues(alpha: .5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(value),
          onTap: () => Navigator.pop(context),
          onSecondaryTapDown: (details) => showFileRightMenu(
            context,
            ref,
            details,
            previewList[index],
            true,
          ),
          child: KeyboardListener(
            focusNode: focusNode,
            autofocus: true,
            onKeyEvent: onKeyEvent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(value),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      if (previewList[index].type.isVideo) {
                        return PreviewVideo(
                          file: previewList[index].path,
                          key: ValueKey(previewList[index].id),
                        );
                      }

                      if (previewList[index].ext == 'avif') {
                        return PreviewAvif(
                          id: previewList[index].id,
                          file: previewList[index].path,
                        );
                      }

                      if (previewList[index].ext == 'psd') {
                        return PreviewPsd(
                          id: previewList[index].id,
                          file: previewList[index],
                          data: previewList[index].thumbnail,
                        );
                      }

                      if (previewList[index].ext == 'svg') {
                        return PreviewSvg(
                          id: previewList[index].id,
                          file: previewList[index].path,
                        );
                      }

                      return PreviewImage(
                        id: previewList[index].id,
                        file: previewList[index].path,
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClickIcon(
                        icon: Icons.keyboard_arrow_left_rounded,
                        onPressed: previous,
                        color: Colors.white,
                        size: 48,
                        iconSize: 40,
                        shadows: shadows,
                      ),
                      ClickIcon(
                        icon: Icons.keyboard_arrow_right_rounded,
                        onPressed: next,
                        color: Colors.white,
                        size: 48,
                        iconSize: 40,
                        shadows: shadows,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
