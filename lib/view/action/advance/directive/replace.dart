import 'package:flutter/material.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/widget/base/text.dart';

class ReplaceCard extends StatelessWidget {
  const ReplaceCard({super.key, required this.menu});

  final AdvanceMenuReplace menu;

  @override
  Widget build(BuildContext context) {
    return BaseText('替换');
  }
}
