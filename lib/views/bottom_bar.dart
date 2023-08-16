import 'package:flutter/material.dart';

import '../constants/constants.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNum.bottomBarH,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line, width: 1)),
      ),
    );
  }
}
