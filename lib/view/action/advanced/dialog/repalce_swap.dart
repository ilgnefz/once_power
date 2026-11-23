import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/replace.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/action/number_input.dart';
import 'package:once_power/widget/base/checkbox.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/base/radio.dart';
import 'package:once_power/widget/base/tooltip.dart';

class ReplaceSwapGroup extends StatelessWidget {
  const ReplaceSwapGroup({
    super.key,
    required this.selected,
    required this.type,
    required this.onTypeChanged,
    required this.index,
    required this.onIndexChanged,
    required this.separator,
    required this.onSeparatorChanged,
    required this.all,
    required this.onAllChanged,
  });

  final bool selected;
  final SwapType type;
  final void Function(SwapType) onTypeChanged;
  final int index;
  final void Function(int) onIndexChanged;
  final String separator;
  final void Function(String) onSeparatorChanged;
  final bool all;
  final void Function(bool) onAllChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: RadioGroup(
        groupValue: type,
        onChanged: (value) => onTypeChanged(value!),
        child: DialogItem(
          title: context.tr(AppL10n.replaceSwapText),
          padding: const .only(top: 4.0),
          spacing: AppNumber.space,
          // runSpacing: AppNumber.spaceSmall,
          children: SwapType.values.map((e) {
            switch (e) {
              case SwapType.custom:
                return ReplaceSwapCustom(
                  index: index,
                  onIndexChanged: onIndexChanged,
                  separator: separator,
                  onSeparatorChanged: onSeparatorChanged,
                  all: all,
                  onAllChanged: onAllChanged,
                );
              default:
                return EasyRadio(label: e.label, value: e);
            }
          }).toList(),
        ),
      ),
    );
  }
}

class ReplaceSwapCustom extends StatelessWidget {
  const ReplaceSwapCustom({
    super.key,
    required this.index,
    required this.onIndexChanged,
    required this.separator,
    required this.onSeparatorChanged,
    required this.all,
    required this.onAllChanged,
  });

  final int index;
  final void Function(int) onIndexChanged;
  final String separator;
  final void Function(String) onSeparatorChanged;
  final bool all;
  final void Function(bool) onAllChanged;

  @override
  Widget build(BuildContext context) {
    return EasyRadio(
      label: SwapType.custom.label,
      value: SwapType.custom,
      space: 0,
      trailing: Row(
        crossAxisAlignment: .center,
        children: [
          const SizedBox(width: AppNumber.spaceMedium),
          SizedBox(
            width: 112,
            child: NumberInput(
              value: index,
              unit: context.tr(AppL10n.ordinalUnit),
              min: 1,
              onChanged: onIndexChanged,
            ),
          ),
          const SizedBox(width: AppNumber.spaceMedium),
          SizedBox(
            width: 108,
            child: EasyInput(
              value: separator,
              hintText: context.tr(AppL10n.replaceSeparator),
              onChanged: onSeparatorChanged,
            ),
          ),
          EasyCheckbox(
            checked: all,
            onChanged: (value) => onAllChanged(value!),
            label: context.tr(AppL10n.replaceSwapAll),
            space: 4,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: EasyTooltip(
                waitDuration: .zero,
                tip: context.tr(AppL10n.replaceSwapAllTip),
                child: BaseIcon(
                  icon: Icons.info_outline_rounded,
                  size: 18,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
