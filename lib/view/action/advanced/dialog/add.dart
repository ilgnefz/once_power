import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/add.dart';
import 'package:once_power/enmu/date.dart';
import 'package:once_power/view/action/advanced/dialog/add_date.dart';
import 'package:once_power/view/action/advanced/dialog/add_index.dart';
import 'package:once_power/view/action/advanced/dialog/add_meta.dart';
import 'package:once_power/view/action/advanced/dialog/add_position.dart';
import 'package:once_power/view/action/advanced/dialog/add_random.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/action/mode_switch.dart';

import 'frame.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({super.key});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  String enter = '', custom = '', prefix = '', suffix = '', group = 'all';
  AddMode mode = .enter;
  int digit = 1, start = 1, step = 1, positionIndex = 1;
  DateType date = .created;
  DateStyle dateStyle = .none;
  WeekdayStyle weekdayStyle = .none;
  TimeStyle timeStyle = .none;
  DateSeparate dateSeparate = .none;
  IndexRule rule = .none;
  DateType dateType = .created;
  List<String> randoms = [];
  MetaDataType metaData = .title;
  AddPosition position = .behind;

  @override
  Widget build(BuildContext context) {
    Localizations.localeOf(context);
    return AdvanceDialogFrame(
      footerSpacing: AppNumber.spaceMedium,
      group: group,
      onComplete: () {},
      onCompleteExit: () => Navigator.of(context).pop(),
      onGroupChange: (value) => setState(() => group = value),
      child: Column(
        children: [
          Wrap(
            alignment: .center,
            spacing: AppNumber.space,
            children: AddMode.values.map((e) {
              return ModeSwitchItem(
                selected: mode == e,
                label: e.label,
                onTap: () => setState(() => mode = e),
              );
            }).toList(),
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          SelectedBox(
            selected: mode.isEnter,
            child: EasyInput(
              value: enter,
              hintText: context.tr(AppL10n.addHint),
              onChanged: (value) => setState(() {
                enter = value;
                mode = .enter;
              }),
            ),
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          AddDateGroup(
            selected: mode.isDate,
            date: date,
            onDateChange: (value) => setState(() {
              date = value;
              mode = .date;
            }),
            dateStyle: dateStyle,
            onDateStyleChange: (value) => setState(() {
              dateStyle = value;
              mode = .date;
            }),
            weekdayStyle: weekdayStyle,
            onWeekdayStyleChange: (value) => setState(() {
              weekdayStyle = value;
              mode = .date;
            }),
            timeStyle: timeStyle,
            onTimeStyleChange: (value) => setState(() {
              timeStyle = value;
              mode = .date;
            }),
            dateSeparate: dateSeparate,
            onDateSeparateChange: (value) => setState(() {
              dateSeparate = value;
              mode = .date;
            }),
            custom: custom,
            onCustomChange: (value) => setState(() {
              custom = value;
              mode = .date;
            }),
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          AddIndexGroup(
            selected: mode.isIndex,
            digit: digit,
            onDigitChanged: (value) => setState(() {
              digit = value;
              mode = .indexes;
            }),
            start: start,
            onStartChanged: (value) => setState(() {
              start = value;
              mode = .indexes;
            }),
            step: step,
            onStepChanged: (value) => setState(() {
              step = value;
              mode = .indexes;
            }),
            rule: rule,
            onRuleChanged: (value) => setState(() {
              rule = value;
              mode = .indexes;
            }),
            dateType: dateType,
            onDateTypeChange: (value) => setState(() {
              dateType = value;
              mode = .indexes;
            }),
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          AddMetaGroup(
            selected: mode.isMeta,
            prefix: prefix,
            onPrefixChanged: (value) => setState(() {
              prefix = value;
              mode = .meta;
            }),
            metaData: metaData,
            onMetaDataChange: (value) => setState(() {
              metaData = value;
              mode = .meta;
            }),
            suffix: suffix,
            onSuffixChanged: (value) => setState(() {
              suffix = value;
              mode = .meta;
            }),
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          AddRandomGroup(
            selected: mode.isRandom,
            randoms: randoms,
            onRandomChanged: (value) => setState(() {
              randoms = value;
              mode = .random;
            }),
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          AddPositionGroup(
            position: position,
            onChanged: (value) => setState(() => position = value),
            positionIndex: positionIndex,
            onIndexChanged: (value) => setState(() => positionIndex = value),
          ),
        ],
      ),
    );
  }
}
