import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/advance.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/base/checkbox.dart';

class DeleteTypeGroup extends StatelessWidget {
  const DeleteTypeGroup({
    super.key,
    required this.selected,
    required this.deleteTypes,
    required this.onChanged,
    required this.onAllChanged,
  });

  final bool selected;
  final List<DeleteType> deleteTypes;
  final void Function(DeleteType) onChanged;
  final void Function(bool) onAllChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: DialogItem(
        title: context.tr(AppL10n.deleteTypeLabel),
        spacing: AppNumber.space,
        runSpacing: 0.0,
        children: [
          EasyCheckbox(
            label: context.tr(AppL10n.all),
            checked: deleteTypes.length == DeleteType.values.length,
            onChanged: (value) => onAllChanged(value!),
          ),
          ...DeleteType.values.map((e) {
            return EasyCheckbox(
              label: e.label,
              checked: deleteTypes.contains(e),
              onChanged: (v) => onChanged(e),
            );
          }),
        ],
      ),
    );
  }
}
