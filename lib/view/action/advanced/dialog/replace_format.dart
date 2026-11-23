import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/replace.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/base/radio.dart';

class ReplaceFormatGroup extends StatelessWidget {
  const ReplaceFormatGroup({
    super.key,
    required this.selected,
    required this.fillPosition,
    required this.onPositionChanged,
  });

  final bool selected;
  final FillPosition fillPosition;
  final void Function(FillPosition) onPositionChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: RadioGroup<FillPosition>(
        groupValue: fillPosition,
        onChanged: (value) => onPositionChanged(value!),
        child: DialogItem(
          title: context.tr(AppL10n.replaceFormatText),
          padding: const .only(top: 4.0),
          spacing: AppNumber.space,
          children: FillPosition.values
              .map((e) => EasyRadio(label: e.label, value: e))
              .toList(),
        ),
      ),
    );
  }
}
