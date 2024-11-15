import 'dart:io';

import 'package:flutter/material.dart';

import 'err_image.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.file});

  final String file;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 8,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Image.file(
          File(file),
          fit: BoxFit.scaleDown,
          cacheHeight: MediaQuery.of(context).size.height.toInt(),
          errorBuilder: (context, exception, stackTrace) =>
              ErrorImage(isPreview: true, file: file),
        ),
      ),
    );
  }
}
