import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/value.dart';

import 'error.dart';
import 'loading.dart';

class ImageView extends ConsumerWidget {
  const ImageView({super.key, required this.file});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget image = Image.file(
      File(file.path),
      fit: BoxFit.contain,
      cacheWidth: ref.watch(viewImageWidthProvider).toInt(),
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
