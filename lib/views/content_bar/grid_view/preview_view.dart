import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/list.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/views/content_bar/grid_view/preview_svg.dart';
import 'package:once_power/widgets/common/click_icon.dart';

import '../../../models/file_enum.dart';
import 'preview_image.dart';
import 'preview_video.dart';

class PreviewView extends ConsumerStatefulWidget {
  const PreviewView(this.files, this.file, {super.key});

  final List<FileInfo> files;
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
    )
  ];

  FocusNode focusNode = FocusNode();
  int index = 0;
  List<FileInfo> previewList = [];

  @override
  void initState() {
    super.initState();
    previewList.addAll(widget.files);
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
    removeOne(ref, id);
    previewList.remove(previewList[currentIndex]);
    if (previewList.isEmpty) {
      Navigator.pop(context);
      return;
    }
    if (currentIndex == previewList.length) {
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
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        bool isMax = ref.watch(isMaxProvider);
        return Material(
          color: Colors.transparent,
          child: Container(
            margin: EdgeInsets.all(isMax ? 0.0 : 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMax ? 0.0 : 8.0),
              color: Colors.black.withValues(alpha: .4),
            ),
            child: child,
          ),
        );
      },
      child: KeyboardListener(
        focusNode: focusNode,
        autofocus: true,
        onKeyEvent: onKeyEvent,
        child: Stack(
          fit: StackFit.expand,
          children: [
            previewList[index].type == FileClassify.video
                ? PreviewVideo(
                    file: previewList[index].filePath,
                    key: ValueKey(previewList[index].id),
                  )
                : previewList[index].extension == 'svg'
                    ? PreviewSvg(
                        id: previewList[index].id,
                        file: previewList[index].filePath,
                      )
                    : PreviewImage(
                        id: previewList[index].id,
                        file: previewList[index].filePath),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClickIcon(
                  icon: Icons.keyboard_arrow_left_rounded,
                  onTap: previous,
                  color: Colors.white,
                  size: 48,
                  iconSize: 40,
                  shadows: shadows,
                ),
                ClickIcon(
                  icon: Icons.keyboard_arrow_right_rounded,
                  onTap: next,
                  color: Colors.white,
                  size: 48,
                  iconSize: 40,
                  shadows: shadows,
                ),
                // IconButton(
                //   onPressed: previous,
                //   iconSize: 40,
                //   icon: Icon(
                //     Icons.keyboard_arrow_left_rounded,
                //     size: 40,
                //     shadows: shadow,
                //   ),
                //   color: Colors.white,
                // ),
                // IconButton(
                //   onPressed: next,
                //   iconSize: 40,
                //   icon: Icon(
                //     Icons.keyboard_arrow_right_rounded,
                //     size: 40,
                //     shadows: shadow,
                //   ),
                //   color: Colors.white,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
