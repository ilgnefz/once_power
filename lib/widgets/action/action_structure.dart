import 'package:flutter/material.dart';

class ActionStructure extends StatelessWidget {
  const ActionStructure({
    super.key,
    required this.menus,
    required this.actions,
  });

  final Widget menus;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SingleChildScrollView(child: menus)),
        ...actions,
      ],
    );
  }
}
