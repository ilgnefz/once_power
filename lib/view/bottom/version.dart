import 'package:flutter/material.dart';
import 'package:once_power/util/pack.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/bottom/text.dart';

class VersionText extends StatelessWidget {
  const VersionText({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      'v${PackInfo.getVersion()}',
      fontSize: 13,
      color: Colors.grey,
    );
  }
}
