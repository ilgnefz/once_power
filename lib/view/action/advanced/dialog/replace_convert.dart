import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/replace.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/base/radio.dart';

class ReplaceConvertGroup extends StatelessWidget {
  const ReplaceConvertGroup({
    super.key,
    required this.selected,
    required this.type,
    required this.onConvertChanged,
  });

  final bool selected;
  final ConvertType type;
  final void Function(ConvertType) onConvertChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: RadioGroup<ConvertType>(
        groupValue: type,
        onChanged: (value) => onConvertChanged(value!),
        child: DialogItem(
          title: context.tr(AppL10n.replaceConvertText),
          padding: const .only(top: 4.0),
          spacing: AppNumber.space,
          children: ConvertType.values
              .map((e) => EasyRadio(label: e.label, value: e))
              .toList(),
        ),
      ),
    );
  }
}
