import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/advance.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/number_input.dart';
import 'package:once_power/widget/base/radio.dart';

class MatchContentGroup extends StatelessWidget {
  const MatchContentGroup({
    super.key,
    required this.content,
    required this.onChanged,
    required this.number,
    required this.onNumberChanged,
  });

  final MatchContent content;
  final void Function(MatchContent) onChanged;
  final int number;
  final Function(int) onNumberChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<MatchContent>(
      groupValue: content,
      onChanged: (value) => onChanged(value!),
      child: DialogItem(
        title: tr(AppL10n.enterContent),
        spacing: AppNumber.space,
        children: MatchContent.values.map((e) {
          switch (e) {
            case MatchContent.number:
              return EasyRadio(
                label: e.label,
                value: e,
                trailing: SizedBox(
                  width: 112,
                  child: NumberInput(
                    value: number,
                    min: 1,
                    unit: tr(AppL10n.ordinalUnit),
                    onChanged: onNumberChanged,
                  ),
                ),
              );
            default:
              return EasyRadio(label: e.label, value: e);
          }
        }).toList(),
      ),
    );
  }
}
