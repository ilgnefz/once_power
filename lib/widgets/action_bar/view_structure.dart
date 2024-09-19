import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';

class ViewStructure extends StatelessWidget {
  const ViewStructure({
    super.key,
    required this.topAction,
    required this.bottomActions,
  });

  final Widget topAction;
  final List<Widget> bottomActions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: topAction),
        const SizedBox(height: AppNum.mediumG),
        ...bottomActions,
      ],
    );
  }
}
