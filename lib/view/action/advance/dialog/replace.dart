import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/advance_replace.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/util/verify.dart';
import 'package:once_power/view/action/advance/dialog/match_content.dart';
import 'package:once_power/view/action/advance/dialog/replace_conversion.dart';
import 'package:once_power/view/action/advance/dialog/replace_mode.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/input_field.dart';

import 'group_dropdown.dart';
import 'match_position.dart';

class ReplaceView extends ConsumerStatefulWidget {
  const ReplaceView({super.key, this.menu});

  final AdvanceMenuReplace? menu;

  @override
  ConsumerState<ReplaceView> createState() => _ReplaceViewState();
}

class _ReplaceViewState extends ConsumerState<ReplaceView> {
  bool useRegex = false, matchExtension = false;
  String oldValue = '', newValue = '', wordSpacing = '', group = 'all';
  ReplaceMode mode = ReplaceMode.normal;
  FillPosition position = FillPosition.front;
  int start = 1, length = 1;
  AdvanceMatch match = AdvanceMatch();
  ConvertType type = ConvertType.uppercase;

  @override
  void initState() {
    super.initState();
    if (widget.menu == null) return;
    useRegex = widget.menu!.useRegex;
    matchExtension = widget.menu!.matchExtension;
    oldValue = widget.menu!.value[0];
    newValue = widget.menu!.value[1];
    mode = widget.menu!.mode;
    position = widget.menu!.fillPosition;
    match = widget.menu!.match;
    start = widget.menu!.start;
    length = widget.menu!.length;
    type = widget.menu!.convertType;
    wordSpacing = widget.menu!.wordSpacing;
    group = widget.menu!.group;
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      width: 500,
      title: tr(AppL10n.advanceReplaceTitle),
      content: Column(
        spacing: AppNum.spaceMedium,
        children: [
          ActionItem(
            padding: .zero,
            icon: AppIcons.regex,
            tip: tr(AppL10n.advanceRegex),
            checked: useRegex,
            onPressed: () => setState(() {
              useRegex = !useRegex;
              mode = ReplaceMode.normal;
            }),
            child: InputField(
              text: oldValue,
              hintText: mode.isFormat
                  ? tr(AppL10n.advanceFormatDigit)
                  : tr(AppL10n.advanceReplaceHint1),
              onChanged: (value) => setState(() => oldValue = value),
            ),
          ),
          ActionItem(
            padding: .zero,
            icon: AppIcons.extension,
            tip: tr(AppL10n.advanceMatchExt),
            checked: matchExtension,
            onPressed: () => setState(() {
              matchExtension = !matchExtension;
              mode = ReplaceMode.normal;
            }),
            child: InputField(
              text: newValue,
              hintText: mode.isFormat
                  ? tr(AppL10n.advanceCompleteContent)
                  : tr(AppL10n.advanceReplaceHint2),
              onChanged: (value) => setState(() => newValue = value),
            ),
          ),
          ReplaceModeGroup(
            mode: mode,
            onChanged: (value) => setState(() => mode = value),
            fillPosition: position,
            onFillChanged: (value) => setState(() {
              position = value;
              mode = ReplaceMode.format;
            }),
            start: start,
            end: length,
            onStartChanged: (value) => setState(() {
              start = value;
              mode = ReplaceMode.position;
            }),
            onEndChanged: (value) => setState(() {
              length = value;
              mode = ReplaceMode.position;
            }),
          ),
          MatchContentGroup(
            content: match.content,
            onChanged: (value) => setState(() {
              match = match.copyWith(content: value);
              mode = ReplaceMode.normal;
            }),
            number: match.contentIndex,
            onNumberChanged: (value) => setState(() {
              match = match.copyWith(
                content: MatchContent.number,
                contentIndex: value,
              );
              mode = ReplaceMode.normal;
            }),
          ),
          MatchPositionGroup(
            position: match.position,
            onChanged: (value) => setState(() {
              match = match.copyWith(position: value);
              mode = ReplaceMode.normal;
            }),
            front: match.frontIndex,
            onFrontChanged: (value) => setState(() {
              match = match.copyWith(
                position: MatchPosition.front,
                frontIndex: value,
              );
              mode = ReplaceMode.normal;
            }),
            behind: match.behindIndex,
            onBehindChanged: (value) => setState(() {
              match = match.copyWith(
                position: MatchPosition.behind,
                behindIndex: value,
              );
              mode = ReplaceMode.normal;
            }),
          ),
          ReplaceConversion(
            type: type,
            onChanged: (value) => setState(() {
              type = value;
              mode = ReplaceMode.convert;
            }),
          ),
          Row(
            spacing: AppNum.spaceMedium,
            children: [
              BaseText('${tr(AppL10n.advanceWord)}: '),
              Expanded(
                child: InputField(
                  text: wordSpacing,
                  hintText: tr(AppL10n.advanceWordHint),
                  onChanged: (value) => setState(() {
                    wordSpacing = value;
                    mode = ReplaceMode.separator;
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
      extraButton: GroupDropdown(
        value: group == 'all' ? tr(AppL10n.dialogAll) : group,
        onChanged: (value) {
          group = isAll(value) ? 'all' : value;
          setState(() {});
        },
      ),
      onOk: () {
        String id = widget.menu?.id ?? generateId();
        AdvanceMenuReplace replace = AdvanceMenuReplace(
          id: id,
          checked: true,
          value: [oldValue, newValue],
          useRegex: useRegex,
          matchExtension: matchExtension,
          mode: mode,
          fillPosition: position,
          start: start,
          length: length,
          match: match,
          convertType: type,
          wordSpacing: wordSpacing,
          group: group,
        );
        widget.menu == null
            ? ref.read(advanceMenuListProvider.notifier).add(replace)
            : ref.read(advanceMenuListProvider.notifier).update(id, replace);
        ref.read(currentPresetNameProvider.notifier).update('');
        advanceUpdateName(ref);
      },
    );
  }
}
