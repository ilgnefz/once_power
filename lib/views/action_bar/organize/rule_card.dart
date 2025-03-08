import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/action_bar/folder_input.dart';

class RuleCard extends StatelessWidget {
  const RuleCard({super.key, required this.title, this.value, this.onChanged});

  final String title;
  final String? value;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppNum.inputP, vertical: AppNum.smallG),
      child: Row(
        // spacing: AppNum.smallG,
        children: [
          Text('$title:'),
          Expanded(
            child: FolderInput(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
