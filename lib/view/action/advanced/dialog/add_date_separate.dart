import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/add.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/base/dropdown.dart';

class AddDateSeparate extends StatelessWidget {
  const AddDateSeparate({
    super.key,
    required this.dateSeparate,
    required this.onDateSeparateChange,
    required this.custom,
    required this.onCustomChange,
  });

  final DateSeparate dateSeparate;
  final void Function(DateSeparate) onDateSeparateChange;
  final String custom;
  final void Function(String) onCustomChange;

  @override
  Widget build(BuildContext context) {
    return DialogItem(
      title: context.tr(AppL10n.dateSeparate),
      spacing: AppNumber.spaceSmall,
      children: [
        const SizedBox.shrink(),
        EasyTextDropdown<DateSeparate>(
          items: DateSeparate.values.map((e) {
            return TextDropdownItem(e, label: e.label);
          }).toList(),
          value: dateSeparate,
          onChanged: onDateSeparateChange,
        ),
        SizedBox(
          width: 242,
          child: EasyInput(
            value: custom,
            hintText: tr(AppL10n.dateSeparateCustomHint),
            onChanged: onCustomChange,
          ),
        ),
      ],
    );
  }
}
