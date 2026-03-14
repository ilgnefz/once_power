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
import 'package:once_power/view/action/advance/dialog/delete_mode.dart';
import 'package:once_power/view/action/advance/dialog/group_dropdown.dart';
import 'package:once_power/view/action/advance/dialog/match_content.dart';
import 'package:once_power/view/action/advance/dialog/match_position.dart';
import 'package:once_power/widget/action/item.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/input_field.dart';

import 'delete_type.dart';

class DeleteView extends ConsumerStatefulWidget {
  const DeleteView({super.key, this.menu});

  final AdvanceMenuDelete? menu;

  @override
  ConsumerState<DeleteView> createState() => _DeleteViewState();
}

class _DeleteViewState extends ConsumerState<DeleteView> {
  String value = '', group = 'all';
  bool useRegex = false;
  DeleteMode mode = DeleteMode.input;
  MatchContent matchContent = MatchContent.number;
  MatchPosition matchPosition = MatchPosition.self;
  int number = 1, front = 1, behind = 1, start = 1, length = 1;
  List<DeleteType> deleteTypes = [];

  @override
  void initState() {
    super.initState();
    if (widget.menu == null) return;
    value = widget.menu!.value;
    mode = widget.menu!.mode;
    matchContent = widget.menu!.matchContent;
    matchPosition = widget.menu!.matchPosition;
    number = widget.menu!.number;
    front = widget.menu!.front;
    behind = widget.menu!.behind;
    start = widget.menu!.start;
    length = widget.menu!.length;
    deleteTypes = widget.menu!.deleteTypes;
    useRegex = widget.menu!.useRegex;
    group = widget.menu!.group;
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      width: 500,
      title: tr(AppL10n.advanceDeleteTitle),
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
              mode = DeleteMode.input;
            }),
            child: InputField(
              text: value,
              hintText: tr(AppL10n.advanceDeleteHint),
              onChanged: (value) => setState(() {
                this.value = value;
                mode = DeleteMode.input;
              }),
            ),
          ),
          DeleteModeGroup(
            mode: mode,
            onChanged: (value) => setState(() => mode = value),
            start: start,
            end: length,
            onStartChanged: (value) => setState(() {
              start = value;
              mode = DeleteMode.position;
            }),
            onEndChanged: (value) => setState(() {
              length = value;
              mode = DeleteMode.position;
            }),
          ),
          MatchContentGroup(
            content: matchContent,
            onChanged: (value) => setState(() {
              matchContent = value;
              mode = DeleteMode.input;
            }),
            number: number,
            onNumberChanged: (value) => setState(() {
              number = value;
              mode = DeleteMode.input;
              matchContent = MatchContent.number;
            }),
          ),
          MatchPositionGroup(
            position: matchPosition,
            onChanged: (value) => setState(() {
              matchPosition = value;
              mode = DeleteMode.input;
            }),
            front: front,
            onFrontChanged: (value) => setState(() {
              front = value;
              mode = DeleteMode.input;
              matchPosition = MatchPosition.front;
            }),
            behind: behind,
            onBehindChanged: (value) => setState(() {
              behind = value;
              mode = DeleteMode.input;
              matchPosition = MatchPosition.behind;
            }),
          ),
          DeleteTypeGroup(
            deleteTypes: deleteTypes,
            onChanged: (value) => setState(() {
              deleteTypes.contains(value)
                  ? deleteTypes.remove(value)
                  : deleteTypes.add(value);
              mode = DeleteMode.type;
            }),
            onAllChanged: (value) => setState(() {
              deleteTypes = value
                  ? Set<DeleteType>.from(DeleteType.values).toList()
                  : [];
              mode = DeleteMode.type;
            }),
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
        AdvanceMenuDelete delete = AdvanceMenuDelete(
          id: id,
          value: value,
          useRegex: useRegex,
          mode: mode,
          start: start,
          length: length,
          matchContent: matchContent,
          matchPosition: matchPosition,
          number: number,
          front: front,
          behind: behind,
          deleteTypes: deleteTypes,
          group: group,
          checked: true,
        );
        widget.menu == null
            ? ref.read(advanceMenuListProvider.notifier).add(delete)
            : ref.read(advanceMenuListProvider.notifier).update(id, delete);
        ref.read(currentPresetNameProvider.notifier).update('');
        advanceUpdateName(ref);
      },
    );
  }
}
