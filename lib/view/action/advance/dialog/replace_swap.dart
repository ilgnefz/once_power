import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/common/checkbox.dart';
import 'package:once_power/widget/common/digit_input.dart';
import 'package:once_power/widget/common/input_field.dart';
import 'package:once_power/widget/common/radio.dart';
import 'package:once_power/widget/common/tooltip.dart';

class ReplaceSwap extends StatelessWidget {
  const ReplaceSwap({
    super.key,
    required this.type,
    required this.index,
    required this.separator,
    required this.all,
    required this.onChanged,
    required this.onIndexChanged,
    required this.onSeparatorChanged,
    required this.onAllChanged,
  });

  final SwapType type;
  final int index;
  final String separator;
  final bool all;
  final void Function(SwapType) onChanged;
  final void Function(int) onIndexChanged;
  final void Function(String) onSeparatorChanged;
  final void Function(bool) onAllChanged;

  @override
  Widget build(BuildContext context) {
    return RadioGroup(
      groupValue: type,
      onChanged: (value) => onChanged(value!),
      child: DialogOption(
        title: tr(AppL10n.advanceSwapText),
        padding: const .only(top: 4.0),
        spacing: AppNum.spaceLarge,
        runSpacing: AppNum.spaceSmall,
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
          const SizedBox(width: AppNum.spaceMedium),
          DigitInput(
            width: 112,
            value: index,
            unit: tr(AppL10n.advanceGe),
            min: 1,
            onChanged: onIndexChanged,
          ),
          const SizedBox(width: AppNum.spaceMedium),
          SizedBox(
            width: 108,
            child: InputField(
              text: separator,
              hintText: tr(AppL10n.advanceSeparator),
              onChanged: onSeparatorChanged,
            ),
          ),
          EasyCheckbox(
            checked: all,
            onChanged: (value) => onAllChanged(value!),
            label: tr(AppL10n.advanceSwapAll),
            space: 4,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: EasyTooltip(
                waitDuration: .zero,
                tip: tr(AppL10n.advanceSwapAllTip),
                child: BaseIcon(
                  icon: Icons.info_rounded,
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
