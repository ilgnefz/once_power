import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';

class ActionStruct extends StatelessWidget {
  const ActionStruct({super.key, required this.menus, required this.actions});

  final List<Widget> menus;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppNum.spaceMedium),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(spacing: AppNum.spaceMedium, children: menus),
            ),
          ),
          ...actions,
        ],
      ),
    );
  }
}
