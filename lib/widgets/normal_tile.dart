import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/my_text.dart';

class NormalTile extends StatelessWidget {
  const NormalTile(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
        child: MyText(label, maxLines: 1),
      ),
    );
  }
}
