import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
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
  String match = '', modify = '', wordSpacing = '', group = 'all';
  ReplaceMode mode = ReplaceMode.normal;
  FillPosition position = FillPosition.front;
  MatchContent matchContent = MatchContent.number;
  MatchPosition matchPosition = MatchPosition.self;
  int number = 1, front = 1, behind = 1, start = 1, length = 1;
  ConvertType type = ConvertType.uppercase;

  @override
  void initState() {
    super.initState();
    if (widget.menu == null) return;
    useRegex = widget.menu!.useRegex;
    matchExtension = widget.menu!.matchExtension;
    match = widget.menu!.value[0];
    modify = widget.menu!.value[1];
    mode = widget.menu!.mode;
    position = widget.menu!.fillPosition;
    matchContent = widget.menu!.matchContent;
    matchPosition = widget.menu!.matchPosition;
    number = widget.menu!.number;
    front = widget.menu!.front;
    behind = widget.menu!.behind;
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
              text: match,
              hintText: mode.isFormat
                  ? tr(AppL10n.advanceFormatDigit)
                  : tr(AppL10n.advanceReplaceHint1),
              onChanged: (value) => setState(() => match = value),
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
              text: modify,
              hintText: mode.isFormat
                  ? tr(AppL10n.advanceCompleteContent)
                  : tr(AppL10n.advanceReplaceHint2),
              onChanged: (value) => setState(() => modify = value),
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
            content: matchContent,
            onChanged: (value) => setState(() {
              matchContent = value;
              mode = ReplaceMode.normal;
            }),
            number: number,
            onNumberChanged: (value) => setState(() {
              number = value;
              mode = ReplaceMode.normal;
              matchContent = MatchContent.number;
            }),
          ),
          MatchPositionGroup(
            position: matchPosition,
            onChanged: (value) => setState(() {
              matchPosition = value;
              mode = ReplaceMode.normal;
            }),
            front: front,
            onFrontChanged: (value) {
              setState(() => front = value);
              mode = ReplaceMode.normal;
              matchPosition = MatchPosition.front;
            },
            behind: behind,
            onBehindChanged: (value) => setState(() {
              behind = value;
              mode = ReplaceMode.normal;
              matchPosition = MatchPosition.behind;
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
          value: [match, modify],
          useRegex: useRegex,
          matchExtension: matchExtension,
          mode: mode,
          fillPosition: position,
          matchContent: matchContent,
          matchPosition: matchPosition,
          number: number,
          front: front,
          behind: behind,
          start: start,
          length: length,
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
