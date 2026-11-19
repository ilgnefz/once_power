import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/widget/content/image.dart';

import 'error.dart';
import 'loading.dart';

class ImageView extends ConsumerWidget {
  const ImageView(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int width =
        (AppNumber.gridCellWidth * MediaQuery.devicePixelRatioOf(context))
            .round();
    Widget image = Image(
      image: ResizeImage(
        FileImageWithKey(File(file.path), file.id),
        width: width,
      ),
      fit: BoxFit.contain,
      // cacheWidth: ref.watch(viewImageWidthProvider),
      gaplessPlayback: true,
      errorBuilder: (_, _, _) => ErrorImage(file: file.path),
      frameBuilder: (_, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: frame != null ? child : const LoadingImage(isPreview: false),
        );
      },
    );

    if (!file.checked) return Opacity(opacity: .5, child: image);
    return image;
  }
}
