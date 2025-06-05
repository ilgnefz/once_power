import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:once_power/views/content_bar/grid_view/loading_image.dart';

import 'err_image.dart';

class PreviewPsd extends StatefulWidget {
  const PreviewPsd({
    super.key,
    required this.id,
    required this.file,
    required this.data,
  });

  final String id;
  final String file;
  final Uint8List data;

  @override
  State<PreviewPsd> createState() => _PreviewPsdState();
}

class _PreviewPsdState extends State<PreviewPsd> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      key: ValueKey(widget.id),
      maxScale: 8,
      boundaryMargin: EdgeInsets.all(double.infinity),
      child: Image.memory(
        widget.data,
        key: ValueKey(widget.file),
        fit: BoxFit.scaleDown,
        errorBuilder: (context, exception, stackTrace) =>
            ErrorImage(isPreview: true, file: widget.file),
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (wasSynchronouslyLoaded) {
            return child;
          } else {
            return AnimatedSwitcher(
              duration: Duration.zero,
              child: frame != null
                  ? child
                  : Image.memory(
                      widget.data,
                      key: ValueKey(widget.file),
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
