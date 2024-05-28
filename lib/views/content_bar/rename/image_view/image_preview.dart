import 'dart:io';

import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview(this.file, {super.key});

  final String file;

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
              child: Image.file(File(file), fit: BoxFit.scaleDown),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: IconButton(
          //     icon: const Icon(Icons.arrow_back_ios_new_rounded),
          //     onPressed: () => provider.previousImage(file),
          //     color: Colors.white,
          //   ),
          // ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: IconButton(
          //     icon: const Icon(Icons.arrow_forward_ios_rounded),
          //     onPressed: () => provider.nextImage(file),
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }
}
