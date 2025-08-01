import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class DatePropertyTitle extends StatelessWidget {
  const DatePropertyTitle({
    super.key,
    required this.label,
    required this.checked,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool checked;
  final String value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EasyCheckbox(
          label: label,
          checked: checked,
          onChanged: onChanged,
        ),
        Padding(
          padding: EdgeInsets.only(right: AppNum.defaultP),
          child: Text(value),
        ),
      ],
    );
  }
}
