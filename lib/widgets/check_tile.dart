import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class CheckTile extends StatelessWidget {
  const CheckTile(this.label, {super.key, this.action});

  final String label;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: AppNum.fileCardH,
        padding: const EdgeInsets.symmetric(horizontal: AppNum.fileCardP),
        child: Row(
          children: [
            Checkbox(value: true, onChanged: (v) {}),
            Expanded(
              child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
