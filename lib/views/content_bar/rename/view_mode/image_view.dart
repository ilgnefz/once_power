import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/file_info.dart';

import 'err_image.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key, required this.file});

  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(file.filePath),
      fit: BoxFit.contain,
      color: file.checked ? null : Colors.grey,
      colorBlendMode: BlendMode.saturation,
      cacheWidth: AppNum.imageW,
      errorBuilder: (context, exception, stackTrace) => const ErrorImage(),
    );
  }
}
