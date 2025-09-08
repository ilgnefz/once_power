import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:once_power/models/file.dart';

import 'error.dart';

class AvifView extends StatelessWidget {
  const AvifView({super.key, required this.file});

  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    Widget child = AvifImage.file(
      File(file.path),
      cacheWidth: 136,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => ErrorImage(file: file.path),
      // placeholderBuilder: (context) => const LoadingImage(isPreview: true),
    );

    if (!file.checked) return Opacity(opacity: .5, child: child);
    return child;
  }
}
