import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class NormalTile extends StatelessWidget {
  const NormalTile(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
        child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
