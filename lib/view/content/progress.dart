import 'dart:io';

import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(r'D:\天翼云盘下载\aa\横屏图片\0103.jpg'),
      fit: .cover,
      height: double.infinity,
      width: double.infinity,
    );
  }
}
