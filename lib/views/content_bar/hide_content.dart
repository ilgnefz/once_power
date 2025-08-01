import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/common/easy_icon.dart';

class HideContent extends StatelessWidget {
  const HideContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EasyIcon(
            icon: Icons.hide_image_rounded,
            iconSize: 80,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            S.of(context).hideAll,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColor,
            ).useSystemChineseFont(),
          ),
        ],
      ),
    );
  }
}
