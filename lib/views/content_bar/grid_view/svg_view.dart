import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_power/models/file_info.dart';

import 'err_image.dart';
import 'loading_image.dart';

class SvgView extends ConsumerWidget {
  const SvgView({super.key, required this.file});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget svg = SvgPicture.file(
      File(file.filePath),
      fit: BoxFit.contain,
      errorBuilder: (context, exception, stackTrace) =>
          ErrorImage(file: file.filePath),
      placeholderBuilder: (context) => const LoadingImage(isPreview: true),
    );

    if (!file.checked) {
      return Opacity(opacity: .5, child: svg);
    } else {
      return svg;
    }
  }
}
