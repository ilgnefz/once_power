import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/models/file_info.dart';

import 'err_image.dart';
import 'loading_image.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.file});

  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    Widget image = Image.file(
      File(file.filePath),
      fit: BoxFit.contain,
      cacheWidth: AppNum.imageW.toInt(),
      errorBuilder: (context, exception, stackTrace) =>
          ErrorImage(file: file.filePath),
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: frame != null ? child : const LoadingImage(isPreview: false),
          );
        }
      },
    );

    if (!file.checked) {
      return Opacity(opacity: .5, child: image);
    } else {
      return image;
    }
  }
}
