import 'package:flutter/material.dart';
import 'package:once_power/config/theme/bottom_text.dart';
import 'package:once_power/utils/pack_info.dart';

class VersionText extends StatelessWidget {
  const VersionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'v${PackInfo.getVersion()}',
      style: Theme.of(context).extension<BottomTextTheme>()?.textStyle,
    );
  }
}
