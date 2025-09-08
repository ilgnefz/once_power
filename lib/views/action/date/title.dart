import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

class DateTitle extends StatelessWidget {
  const DateTitle({
    super.key,
    required this.checked,
    required this.title,
    required this.label,
    required this.onChanged,
  });

  final bool checked;
  final String title;
  final String label;
  final Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppNum.paddingMedium,
        right: AppNum.padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyCheckbox(checked: checked, label: title, onChanged: onChanged),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
