import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'err_image.dart';
import 'loading_image.dart';

class PreviewSvg extends StatelessWidget {
  const PreviewSvg({super.key, required this.id, required this.file});

  final String id;
  final String file;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 8,
      child: SvgPicture.file(
        File(file),
        key: ValueKey(file),
        fit: BoxFit.scaleDown,
        errorBuilder: (context, exception, stackTrace) =>
            ErrorImage(isPreview: true, file: file),
        placeholderBuilder: (context) => const LoadingImage(isPreview: true),
      ),
    );
  }
}
