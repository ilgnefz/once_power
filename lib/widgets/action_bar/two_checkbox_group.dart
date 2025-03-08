import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';

class TwoCheckboxGroup extends StatelessWidget {
  const TwoCheckboxGroup({super.key, this.left, required this.children});

  final double? left;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: left ?? AppNum.smallG, right: AppNum.defaultP),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
