import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/widgets/action_bar/digit_input.dart';

class CommonLocationRadio extends StatelessWidget {
  const CommonLocationRadio({
    super.key,
    required this.location,
    required this.onChanged,
    required this.start,
    required this.end,
    required this.onStartChanged,
    required this.onEndChanged,
  });

  final MatchLocation location;
  final Function(MatchLocation) onChanged;
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
          child: Column(
            children: [
              Row(
                children: [
                  Radio(
                    groupValue: location,
                    value: MatchLocation.first,
                    onChanged: (value) => onChanged(value!),
                  ),
                  Text(S.of(context).first),
                  Spacer(),
                  Radio(
                    groupValue: location,
                    value: MatchLocation.last,
                    onChanged: (value) => onChanged(value!),
                  ),
                  Text(S.of(context).last),
                  Spacer(),
                  Radio(
                    groupValue: location,
                    value: MatchLocation.all,
                    onChanged: (value) => onChanged(value!),
                  ),
                  Text(S.of(context).all),
                ],
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Radio(
                    groupValue: location,
                    value: MatchLocation.position,
                    onChanged: (value) => onChanged(value!),
                  ),
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
