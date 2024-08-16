import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/views/content_bar/rename/view_mode/loading_image.dart';

import 'err_image.dart';

class ImageView extends ConsumerWidget {
  const ImageView({super.key, required this.file});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isRefresh = ref.watch(refreshImageProvider);
    return Image.file(
      File(file.filePath),
      fit: BoxFit.contain,
      color: file.checked ? null : Colors.grey,
      colorBlendMode: BlendMode.saturation,
      cacheWidth: AppNum.imageW.toInt() + (isRefresh ? 1 : 0),
      errorBuilder: (context, exception, stackTrace) => const ErrorImage(),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: frame != null ? child : const LoadingImage(),
          );
        }
      },
    );
  }
}
