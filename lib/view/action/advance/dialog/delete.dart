import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/model/advance_delete.dart';
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
  int start = 1, length = 1;
  AdvanceMatch match = AdvanceMatch();
  List<DeleteType> deleteTypes = [];

  @override
  void initState() {
    super.initState();
    if (widget.menu == null) return;
    value = widget.menu!.value;
    mode = widget.menu!.mode;
    start = widget.menu!.start;
    length = widget.menu!.length;
    match = widget.menu!.match;
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
        mainAxisSize: .min,
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
            content: match.content,
            onChanged: (value) => setState(() {
              match = match.copyWith(content: value);
              mode = DeleteMode.input;
            }),
            number: match.contentIndex,
            onNumberChanged: (value) => setState(() {
              match = match.copyWith(
                content: MatchContent.number,
                contentIndex: value,
              );
              mode = DeleteMode.input;
            }),
          ),
          MatchPositionGroup(
            position: match.position,
            onChanged: (value) => setState(() {
              match = match.copyWith(position: value);
              mode = DeleteMode.input;
            }),
            front: match.frontIndex,
            onFrontChanged: (value) => setState(() {
              match = match.copyWith(
                position: MatchPosition.front,
                frontIndex: value,
              );
              mode = DeleteMode.input;
            }),
            behind: match.behindIndex,
            onBehindChanged: (value) => setState(() {
              match = match.copyWith(
                position: MatchPosition.behind,
                behindIndex: value,
              );
              mode = DeleteMode.input;
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
          match: match,
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
