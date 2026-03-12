import 'package:flutter/material.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/widget/base/text.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key, required this.menu});

  final AdvanceMenuAdd menu;

  @override
  Widget build(BuildContext context) {
    return BaseText('添加');
  }
}
