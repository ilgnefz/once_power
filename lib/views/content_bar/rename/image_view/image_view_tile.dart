import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/content_bar/rename/image_view/err_image.dart';

import 'image_preview.dart';

class ImageViewTile extends StatelessWidget {
  const ImageViewTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    void showImage() {
      showDialog(
        context: context,
        builder: (context) => ImagePreview(file.filePath),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onDoubleTap: showImage,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Image.file(
                  File(file.filePath),
                  fit: BoxFit.contain,
                  color: file.checked ? null : Colors.grey,
                  colorBlendMode: BlendMode.saturation,
                  cacheWidth: AppNum.imageW,
                  errorBuilder: (context, exception, stackTrace) =>
                      const ErrorImage(),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                fileName(file.newName, file.newExtension),
                style: TextStyle(
                  fontSize: AppNum.tileFontSize,
                  color: file.checked ? Colors.black : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
