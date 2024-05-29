import 'dart:io';

import 'package:flutter/material.dart';

import 'err_image.dart';

class PreviewImageView extends StatefulWidget {
  const PreviewImageView(this.file, {super.key});

  final String file;

  @override
  State<PreviewImageView> createState() => _PreviewImageViewState();
}

class _PreviewImageViewState extends State<PreviewImageView> {
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
