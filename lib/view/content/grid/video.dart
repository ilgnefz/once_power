import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/src/rust/api/models.dart';
import 'package:once_power/view/content/grid/loading.dart';
import 'package:once_power/widget/common/click_icon.dart';

import 'error.dart';

class VideoView extends ConsumerWidget {
  const VideoView(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = file.thumbnail;
    if (thumbnail == null) return const LoadingImage(isPreview: false);

    return thumbnail.isEmpty
        ? ErrorImage(file: file.path)
        : ColoredBox(
            color: Colors.black,
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Image.memory(thumbnail, fit: BoxFit.contain),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: ClickIcon(
                    icon: Icons.play_circle_fill_rounded,
                    color: Colors.white,
                    size: 28,
                    iconSize: 24,
                    onPressed: () => showPreviewView(context, file),
                  ),
                ),
              ],
            ),
          );
  }
}
