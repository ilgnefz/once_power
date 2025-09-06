import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/verify.dart';

import 'case_conversion_group.dart';
import 'common_dialog.dart';
import 'common_position_radio.dart';
import 'format_group.dart';
import 'group_dropdown.dart';
import 'replace_match_input.dart';
import 'replace_modify_input.dart';
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
  MatchContent location = MatchContent.first;
  int start = 1, end = 1, front = 1, back = 1;
  ConvertType type = ConvertType.noConversion;
  String wordSpacing = '';
  bool useRegex = false, matchExt = false;
  String group = 'all';

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
      type = widget.menu!.convertType;
      wordSpacing = widget.menu!.wordSpacing;
      useRegex = widget.menu!.useRegex;
      matchExt = widget.menu!.matchExt;
      group = widget.menu!.group;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: tr(AppL10n.advanceReplaceTitle),
      extraButton: GroupDropdown(
        value: group == 'all' ? tr(AppL10n.dialogAll) : group,
        onChanged: (value) {
          group = isAll(value!) ? 'all' : value;
          setState(() {});
        },
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          bool isFormat = ref.watch(currentReplaceModeProvider).isFormat;
          return Form(
            child: Column(
              spacing: AppNum.spaceMedium,
              children: [
                ReplaceMatchInput(
                  value: oldValue,
                  enable: !location.isPosition && type.isNoConversion,
                  hintText: isFormat
                      ? tr(AppL10n.advanceFormatDigit)
                      : tr(AppL10n.advanceReplaceHint1),
                  inputFormatters: isFormat
                      ? [FilteringTextInputFormatter.digitsOnly]
                      : [],
                  useRegex: useRegex,
                  onChanged: (value) => setState(() => oldValue = value),
                  onPressed: () => setState(() => useRegex = !useRegex),
                ),
                ReplaceModifyInput(
                  value: newValue,
                  enable: type.isNoConversion,
                  hintText: isFormat
                      ? tr(AppL10n.advanceCompleteContent)
                      : tr(AppL10n.advanceReplaceHint2),
                  matchExt: matchExt,
                  onChanged: (value) => setState(() => newValue = value),
                  onTap: () => setState(() => matchExt = !matchExt),
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
                  onPositionChanged: (value) =>
                      setState(() => position = value),
                ),
                CommonPositionRadio(
                  location: location,
                  onChanged: (value) => setState(() => location = value),
                  front: front,
                  back: back,
                  onFrontChanged: (value) => setState(() => front = value),
                  onBackChanged: (value) => setState(() => back = value),
                  start: start,
                  end: end,
                  onStartChanged: (value) => setState(() => start = value),
                  onEndChanged: (value) => setState(() => end = value),
                ),
                CaseConversionGroup(
                  type: type,
                  typeChanged: (value) => setState(() => type = value),
                ),
                WordSpacing(
                  value: wordSpacing,
                  onChanged: (value) => setState(() => wordSpacing = value),
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
          convertType: type,
          wordSpacing: wordSpacing,
          useRegex: useRegex,
          matchExt: matchExt,
          group: group,
        );
        if (widget.menu != null) {
          ref.read(advanceMenuListProvider.notifier).update(id, replace);
        } else {
          ref.read(advanceMenuListProvider.notifier).add(replace);
        }
        ref.read(currentPresetNameProvider.notifier).update('');
        advanceUpdateName(ref);
      },
    );
  }
}
