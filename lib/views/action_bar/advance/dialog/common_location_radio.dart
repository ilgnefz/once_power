import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/digit_input.dart';
import 'package:once_power/widgets/action_bar/easy_radio.dart';

class CommonLocationRadio extends StatelessWidget {
  const CommonLocationRadio({
    super.key,
    required this.location,
    required this.onChanged,
    required this.start,
    required this.end,
    required this.onStartChanged,
    required this.onEndChanged,
    required this.front,
    required this.back,
    required this.onFrontChanged,
    required this.onBackChanged,
  });

  final MatchLocation location;
  final Function(MatchLocation) onChanged;
  final int front;
  final int back;
  final Function(int) onFrontChanged;
  final Function(int) onBackChanged;
  final int start;
  final int end;
  final Function(int) onStartChanged;
  final Function(int) onEndChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text('${S.of(context).matchLocation}: '),
        ),
        Expanded(
          child: Wrap(
            runSpacing: AppNum.mediumG,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: MatchLocation.values.map((e) {
              if (e.isPosition) {
                return EasyRadio(
                  label: '',
                  value: e,
                  groupValue: location,
                  onChanged: (value) => onChanged(value!),
                  space: 0,
                  trailing: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: DigitInput(
                          value: start,
                          label: S.of(context).start,
                          min: 1,
                          onChanged: onStartChanged,
                        ),
                      ),
                      const SizedBox(width: AppNum.largeG),
                      SizedBox(
                        width: 120,
                        child: DigitInput(
                          value: end,
                          label: S.of(context).end,
                          min: 1,
                          onChanged: onEndChanged,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (e.isFront) {
                return EasyRadio(
                  label: e.label,
                  value: e,
                  groupValue: location,
                  onChanged: (value) => onChanged(value!),
                  trailing: SizedBox(
                    width: 100,
                    child: DigitInput(
                      value: front,
                      label: S.of(context).place,
                      min: 1,
                      onChanged: onFrontChanged,
                    ),
                  ),
                );
              }
              if (e.isBack) {
                return EasyRadio(
                  label: e.label,
                  value: e,
                  groupValue: location,
                  onChanged: (value) => onChanged(value!),
                  trailing: SizedBox(
                    width: 100,
                    child: DigitInput(
                      value: back,
                      label: S.of(context).place,
                      min: 1,
                      onChanged: onBackChanged,
                    ),
                  ),
                );
              }
              return EasyRadio(
                label: e.label,
                value: e,
                groupValue: location,
                onChanged: (value) => onChanged(value!),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
