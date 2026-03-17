import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:once_power/model/file.dart';

import 'error.dart';
import 'loading.dart';

class SvgView extends StatelessWidget {
  const SvgView(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    Widget svg = SvgPicture.file(
      File(file.path),
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => ErrorImage(file: file.path),
      placeholderBuilder: (_) => const LoadingImage(isPreview: true),
    );

    if (!file.checked) return Opacity(opacity: .5, child: svg);
    return svg;
  }
}
