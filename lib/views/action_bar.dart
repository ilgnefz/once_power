import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppNum.actionBarP),
      width: AppNum.actionBarW,
    );
  }
}
