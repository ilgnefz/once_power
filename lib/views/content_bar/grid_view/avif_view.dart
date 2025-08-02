import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:once_power/models/file_info.dart';

import 'err_image.dart';

class AvifView extends StatelessWidget {
  const AvifView({super.key, required this.file});

  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    Widget child = AvifImage.file(
      File(file.filePath),
      fit: BoxFit.contain,
      errorBuilder: (context, exception, stackTrace) =>
          ErrorImage(file: file.filePath),
      // placeholderBuilder: (context) => const LoadingImage(isPreview: true),
    );

    if (!file.checked) {
      return Opacity(opacity: .5, child: child);
    } else {
      return child;
    }
  }
}
