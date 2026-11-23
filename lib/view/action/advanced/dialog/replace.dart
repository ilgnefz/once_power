import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/advance.dart';
import 'package:once_power/enmu/replace.dart';
import 'package:once_power/widget/action/mode_switch.dart';

import 'frame.dart';
import 'match_part.dart';
import 'replace_convert.dart';
import 'replace_format.dart';
import 'replace_inserter.dart';
import 'replace_swap.dart';
import 'replace_input.dart';

class ReplaceDialog extends StatefulWidget {
  const ReplaceDialog({super.key});

  @override
  State<ReplaceDialog> createState() => _ReplaceDialogState();
}

class _ReplaceDialogState extends State<ReplaceDialog> {
  String match = '', modify = '', swapSeparator = '', word = '', group = 'all';
  int number = 1, font = 1, behind = 1, start = 1, digit = 1, swapIndex = 1;
  bool regex = false, extension = false, swapAll = false;
  ReplaceMode mode = .enter;
  MatchContent content = .number;
  MatchPosition position = .self;
  FillPosition fillPosition = .front;
  ConvertType convertType = .uppercase;
  SwapType swapType = .reverse;

  @override
  Widget build(BuildContext context) {
    Localizations.localeOf(context);
    return AdvanceDialogFrame(
      footerSpacing: AppNumber.space,
      group: group,
      onComplete: () {},
      onCompleteExit: () => Navigator.of(context).pop(),
      onGroupChange: (value) => setState(() => group = value),
      child: Column(
        children: [
          Wrap(
            alignment: .center,
            spacing: AppNumber.space,
            children: ReplaceMode.values.map((e) {
              return ModeSwitchItem(
                selected: mode == e,
                label: e.label,
                onTap: () => setState(() => mode = e),
              );
            }).toList(),
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          ReplaceInputGroup(
            selected: mode.isEnter,
            match: match,
            onMatchChanged: (value) {
              match = value;
              mode = .enter;
              setState(() {});
            },
            regex: regex,
            onRegexPressed: () {
              regex = !regex;
              mode = .enter;
              setState(() {});
            },
            modify: modify,
            onModifyChanged: (value) {
              modify = value;
              mode = .enter;
              setState(() {});
            },
            extension: extension,
            onExtensionPressed: () {
              extension = !extension;
              mode = .enter;
              setState(() {});
            },
            content: content,
            onContentChanged: (value) {
              content = value;
              mode = .enter;
              setState(() {});
            },
            number: number,
            onNumberChanged: (value) {
              number = value;
              mode = .enter;
              setState(() {});
            },
            position: position,
            onPositionChanged: (value) {
              position = value;
              mode = .enter;
              setState(() {});
            },
            front: font,
            onFrontChanged: (value) {
              font = value;
              mode = .enter;
              setState(() {});
            },
            behind: behind,
            onBehindChanged: (value) {
              behind = value;
              mode = .enter;
              setState(() {});
            },
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          MatchPartGroup(
            selected: mode.isPart,
            start: start,
            digit: digit,
            onStartChanged: (value) {
              start = value;
              mode = .part;
              setState(() {});
            },
            onDigitChanged: (value) {
              digit = value;
              mode = .part;
              setState(() {});
            },
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          ReplaceFormatGroup(
            selected: mode.isFormat,
            fillPosition: fillPosition,
            onPositionChanged: (value) {
              fillPosition = value;
              mode = .format;
              setState(() {});
            },
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          ReplaceConvertGroup(
            selected: mode.isConvert,
            type: convertType,
            onConvertChanged: (value) {
              convertType = value;
              mode = .convert;
              setState(() {});
            },
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          ReplaceSwapGroup(
            selected: mode.isSwap,
            type: swapType,
            onTypeChanged: (value) {
              swapType = value;
              mode = .swap;
              setState(() {});
            },
            index: swapIndex,
            onIndexChanged: (value) {
              swapIndex = value;
              mode = .swap;
              setState(() {});
            },
            separator: swapSeparator,
            onSeparatorChanged: (value) {
              swapSeparator = value;
              mode = .swap;
              setState(() {});
            },
            all: swapAll,
            onAllChanged: (value) {
              swapAll = value;
              mode = .swap;
              setState(() {});
            },
          ),
          const SizedBox(height: AppNumber.spaceMedium),
          ReplaceInserterGroup(
            selected: mode.isInserter,
            inserter: word,
            onInserterChanged: (value) {
              word = value;
              mode = .inserter;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
