import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';

class CommonLocationRadio extends StatelessWidget {
  const CommonLocationRadio({
    super.key,
    required this.location,
    required this.onChanged,
  });

  final MatchLocation location;
  final Function(MatchLocation) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('${S.of(context).matchLocation}: '),
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
    );
  }
}
