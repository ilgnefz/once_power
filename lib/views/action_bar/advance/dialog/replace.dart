import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/providers/select.dart';

import 'case_conversion_group.dart';
import 'common_dialog.dart';
import 'common_location_radio.dart';
import 'dialog_base_input.dart';
import 'format_group.dart';
import 'group_dropdown.dart';
import 'word_spacing.dart';

class ReplaceView extends ConsumerStatefulWidget {
  const ReplaceView({super.key, this.menu});

  final AdvanceMenuReplace? menu;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeleteViewState();
}

class _DeleteViewState extends ConsumerState<ReplaceView> {
  String oldValue = '', newValue = '';
  ReplaceMode mode = ReplaceMode.normal;
  FillPosition position = FillPosition.front;
  MatchLocation location = MatchLocation.first;
  int start = 1, end = 1, front = 1, back = 1;
  CaseType type = CaseType.noConversion;
  String wordSpacing = '';
  String group = S.current.all;

  @override
  void initState() {
    super.initState();
    if (widget.menu != null) {
      oldValue = widget.menu!.value[0];
      newValue = widget.menu!.value[1];
      mode = widget.menu!.replaceMode;
      position = widget.menu!.fillPosition;
      location = widget.menu!.matchLocation;
      front = widget.menu!.front;
      back = widget.menu!.back;
      start = widget.menu!.start;
      end = widget.menu!.end;
      type = widget.menu!.caseType;
      wordSpacing = widget.menu!.wordSpacing;
      group = widget.menu!.group;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: S.of(context).replaceTitle,
      extraButton: GroupDropdown(
        value: group,
        onChanged: (value) {
          group = value!;
          setState(() {});
        },
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          bool isFormat = ref.watch(currentReplaceModeProvider).isFormat;
          return Form(
            child: Column(
              spacing: AppNum.mediumG,
              children: [
                DialogBaseInput(
                  value: oldValue,
                  enable: !location.isPosition && type.isNoConversion,
                  hintText: isFormat
                      ? S.of(context).formatDigit
                      : S.of(context).replaceInputHint,
                  inputFormatters:
                      isFormat ? [FilteringTextInputFormatter.digitsOnly] : [],
                  onChanged: (value) {
                    oldValue = value;
                    setState(() {});
                  },
                ),
                DialogBaseInput(
                  value: newValue,
                  enable: type.isNoConversion,
                  hintText: isFormat
                      ? S.of(context).completeContent
                      : S.of(context).replaceInputHint2,
                  onChanged: (value) {
                    newValue = value;
                    setState(() {});
                  },
                ),
                FormatGroup(
                  mode: mode,
                  onChanged: (value) {
                    mode = value;
                    String temp = oldValue;
                    if (mode.isFormat) {
                      bool isNum = int.tryParse(oldValue) != null;
                      if (!isNum) oldValue = oldValue.length.toString();
                    }
                    if (mode.isNormal) oldValue = temp;
                    ref.read(currentReplaceModeProvider.notifier).update(mode);
                    setState(() {});
                  },
                  position: position,
                  onPositionChanged: (value) {
                    position = value;
                    setState(() {});
                  },
                ),
                CommonLocationRadio(
                  location: location,
                  onChanged: (value) {
                    location = value;
                    setState(() {});
                  },
                  front: front,
                  back: back,
                  onFrontChanged: (value) {
                    front = value;
                    setState(() {});
                  },
                  onBackChanged: (value) {
                    back = value;
                    setState(() {});
                  },
                  start: start,
                  end: end,
                  onStartChanged: (value) {
                    start = value;
                    setState(() {});
                  },
                  onEndChanged: (value) {
                    end = value;
                    setState(() {});
                  },
                ),
                CaseConversionGroup(
                  type: type,
                  typeChanged: (value) {
                    type = value;
                    setState(() {});
                  },
                ),
                WordSpacing(
                  value: wordSpacing,
                  onChanged: (value) {
                    wordSpacing = value;
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
      onOk: () {
        String id = widget.menu != null ? widget.menu!.id : nanoid(10);
        AdvanceMenuReplace replace = AdvanceMenuReplace(
          id: id,
          checked: true,
          value: [oldValue, newValue],
          replaceMode: mode,
          fillPosition: position,
          matchLocation: location,
          front: front,
          back: back,
          start: start,
          end: end,
          caseType: type,
          wordSpacing: wordSpacing,
          group: group,
        );
        if (widget.menu != null) {
          ref.read(advanceMenuListProvider.notifier).update(id, replace);
        } else {
          ref.read(advanceMenuListProvider.notifier).add(replace);
        }
        advanceUpdateName(ref);
      },
    );
  }
}
