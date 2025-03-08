import 'dart:io';

import 'package:flutter/material.dart';

import 'err_image.dart';
import 'loading_image.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({super.key, required this.id, required this.file});

  final String id;
  final String file;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      maxScale: 8,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Image.file(
          File(file),
          key: ValueKey(file),
          fit: BoxFit.scaleDown,
          cacheHeight: MediaQuery.of(context).size.height.toInt(),
          errorBuilder: (context, exception, stackTrace) =>
              ErrorImage(isPreview: true, file: file),
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded) {
              return child;
            } else {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child:
                    frame != null ? child : const LoadingImage(isPreview: true),
              );
            }
          },
        ),
      ),
    );
  }
}
