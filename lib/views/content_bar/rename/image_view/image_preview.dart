import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/views/content_bar/rename/image_view/err_image.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview(this.file, {super.key});

  final String file;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          InteractiveViewer(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.file(
                File(widget.file),
                fit: BoxFit.scaleDown,
                errorBuilder: (context, exception, stackTrace) =>
                    const ErrorImage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
