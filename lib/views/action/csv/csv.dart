import 'dart:io';

import 'package:flutter/material.dart';

class CSVView extends StatelessWidget {
  const CSVView({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(r'C:\Users\ilgnefz\Pictures\image_苏晓彤头像 需要自取__#明星不..._5.png'),
      fit: BoxFit.cover,
    );
  }
}
