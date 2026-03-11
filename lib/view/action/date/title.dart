import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/widget/common/checkbox.dart';

class DateTitle extends StatelessWidget {
  const DateTitle({
    super.key,
    required this.checked,
    required this.title,
    required this.label,
    required this.fullReplace,
    required this.selfAdjust,
    required this.onChanged,
  });

  final bool checked;
  final String title;
  final String label;
  final bool fullReplace;
  final bool selfAdjust;
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
          Text(
            checked ? formatModifyDate(label, fullReplace, selfAdjust) : '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
