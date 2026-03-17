import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_avif/flutter_avif.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/value.dart';

import 'error.dart';

class AvifView extends ConsumerWidget {
  const AvifView(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget child = AvifImage.file(
      File(file.path),
      cacheWidth: ref.watch(viewImageWidthProvider),
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => ErrorImage(file: file.path),
      // placeholderBuilder: (context) => const LoadingImage(isPreview: true),
    );

    if (!file.checked) return Opacity(opacity: .5, child: child);
    return child;
  }
}
