import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';

import '../error.dart';

class PreviewAvif extends StatelessWidget {
  const PreviewAvif({super.key, required this.id, required this.file});

  final String id;
  final String file;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      key: ValueKey(id),
      maxScale: 8,
      child: AvifImage.file(
        File(file),
        key: ValueKey(file),
        fit: BoxFit.scaleDown,
        errorBuilder: (_, __, ___) => ErrorImage(isPreview: true, file: file),
        // placeholderBuilder: (context) => const LoadingImage(isPreview: true),
      ),
    );
  }
}
