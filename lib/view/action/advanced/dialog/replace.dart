import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/advance.dart';
import 'package:once_power/enmu/replace.dart';
import 'package:once_power/view/action/advanced/dialog/replace_format.dart';
import 'package:once_power/view/action/advanced/dialog/replace_inserter.dart';
import 'package:once_power/widget/action/mode_switch.dart';

import 'frame.dart';
import 'match_part.dart';
import 'repalce_convert.dart';
import 'repalce_swap.dart';
import 'replace_input.dart';

class ReplaceDialog extends StatefulWidget {
  const ReplaceDialog({super.key});

  @override
  State<ReplaceDialog> createState() => _ReplaceDialogState();
}

class _ReplaceDialogState extends State<ReplaceDialog> {
  String match = '', modify = '', swapSeparator = '', word = '', group = '0';
  int number = 1, font = 1, behind = 1, start = 1, digit = 1, swapIndex = 1;
  bool regex = false, extension = false, swapAll = false;
  ReplaceMode mode = .input;
  MatchContent content = .number;
  MatchPosition position = .self;
  FillPosition fillPosition = .front;
  ConvertType convertType = .uppercase;
  SwapType swapType = .reverse;

  @override
  Widget build(BuildContext context) {
    Localizations.localeOf(context);
    return AdvanceDialogFrame(
      // 按钮上方留白：等价于原先 spacing + SizedBox + spacing。
      footerSpacing: AppNumber.space,
      group: group,
      onComplete: () {},
      onCompleteExit: () => Navigator.of(context).pop(),
      onGroupChange: (value) => setState(() => group = value),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .center,
            spacing: AppNumber.space,
            children: ReplaceMode.values.map((e) {
              return ModeSwitchItem(
                selected: mode == e,
                label: e.label,
                onTap: () => setState(() => mode = e),
              );
            }).toList(),
          ),
          SizedBox(height: AppNumber.spaceMedium),
          ReplaceInputGroup(
            selected: mode == ReplaceMode.input,
            match: match,
            onMatchChanged: (value) {
              match = value;
              mode = ReplaceMode.input;
              setState(() {});
            },
            regex: regex,
            onRegexPressed: () {
              regex = !regex;
              mode = ReplaceMode.input;
              setState(() {});
            },
            modify: modify,
            onModifyChanged: (value) {
              modify = value;
              mode = ReplaceMode.input;
              setState(() {});
            },
            extension: extension,
            onExtensionPressed: () {
              extension = !extension;
              mode = ReplaceMode.input;
              setState(() {});
            },
            content: content,
            onContentChanged: (value) {
              content = value;
              mode = ReplaceMode.input;
              setState(() {});
            },
            number: number,
            onNumberChanged: (value) {
              number = value;
              mode = ReplaceMode.input;
              setState(() {});
            },
            position: position,
            onPositionChanged: (value) {
              position = value;
              mode = ReplaceMode.input;
              setState(() {});
            },
            front: font,
            onFrontChanged: (value) {
              font = value;
              mode = ReplaceMode.input;
              setState(() {});
            },
            behind: behind,
            onBehindChanged: (value) {
              behind = value;
              mode = ReplaceMode.input;
              setState(() {});
            },
          ),
          SizedBox(height: AppNumber.spaceMedium),
          MatchPartGroup(
            selected: mode == ReplaceMode.part,
            start: start,
            digit: digit,
            onStartChanged: (value) {
              start = value;
              mode = ReplaceMode.part;
              setState(() {});
            },
            onDigitChanged: (value) {
              digit = value;
              mode = ReplaceMode.part;
              setState(() {});
            },
          ),
          SizedBox(height: AppNumber.spaceMedium),
          ReplaceFormatGroup(
            selected: mode == ReplaceMode.format,
            fillPosition: fillPosition,
            onPositionChanged: (value) {
              fillPosition = value;
              mode = ReplaceMode.format;
              setState(() {});
            },
          ),
          SizedBox(height: AppNumber.spaceMedium),
          ReplaceConvertGroup(
            selected: mode == ReplaceMode.convert,
            type: convertType,
            onConvertChanged: (value) {
              convertType = value;
              mode = ReplaceMode.convert;
              setState(() {});
            },
          ),
          SizedBox(height: AppNumber.spaceMedium),
          ReplaceSwapGroup(
            selected: mode == ReplaceMode.swap,
            type: swapType,
            onTypeChanged: (value) {
              swapType = value;
              mode = ReplaceMode.swap;
              setState(() {});
            },
            index: swapIndex,
            onIndexChanged: (value) {
              swapIndex = value;
              mode = ReplaceMode.swap;
              setState(() {});
            },
            separator: swapSeparator,
            onSeparatorChanged: (value) {
              swapSeparator = value;
              mode = ReplaceMode.swap;
              setState(() {});
            },
            all: swapAll,
            onAllChanged: (value) {
              swapAll = value;
              mode = ReplaceMode.swap;
              setState(() {});
            },
          ),
          SizedBox(height: AppNumber.spaceMedium),
          ReplaceInserterGroup(
            selected: mode == ReplaceMode.inserter,
            inserter: word,
            onInserterChanged: (value) {
              word = value;
              mode = ReplaceMode.inserter;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
