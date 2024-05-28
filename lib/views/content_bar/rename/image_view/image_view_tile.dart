import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/file_info.dart';
import 'package:once_power/utils/utils.dart';

import 'image_preview.dart';

class ImageViewTile extends StatelessWidget {
  const ImageViewTile(this.file, {super.key});

  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        // TODO ???
        onTap: () {},
        onDoubleTap: () {
          showDialog(
            context: context,
            builder: (context) => ImagePreview(file.filePath),
          );
        },
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
