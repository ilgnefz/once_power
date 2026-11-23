import 'dart:io';

import 'package:material_ui/material_ui.dart';

class PresetList extends StatelessWidget {
  const PresetList({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: .loose,
      child: Image.file(
        File(
          r'C:\Users\ilgnefz\Pictures\Camera Roll\a2d60795ly1hrd1yq15a4j21rb2k6u0y.jpg',
        ),
      ),
    );
  }
}
