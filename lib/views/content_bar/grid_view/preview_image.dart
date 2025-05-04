import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/views/content_bar/grid_view/loading_image.dart';

import 'err_image.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({super.key, required this.id, required this.file});

  final String id;
  final String file;

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      key: ValueKey(id),
      maxScale: 8,
      boundaryMargin: EdgeInsets.all(double.infinity),
      child: Image.file(
        File(file),
        key: ValueKey(file),
        fit: BoxFit.scaleDown,
        errorBuilder: (context, exception, stackTrace) =>
            ErrorImage(isPreview: true, file: file),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          } else {
            return AnimatedSwitcher(
              duration: Duration.zero,
              child: frame != null
                  ? child
                  : Image.file(
                      File(file),
                      key: ValueKey(file),
                      fit: BoxFit.scaleDown,
                      cacheHeight: MediaQuery.of(context).size.height.toInt(),
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) {
                          return child;
                        } else {
                          return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 1),
                              child: frame != null
                                  ? child
                                  : const LoadingImage(isPreview: true));
                        }
                      },
                    ),
            );
          }
        },
      ),
    );
  }
}
